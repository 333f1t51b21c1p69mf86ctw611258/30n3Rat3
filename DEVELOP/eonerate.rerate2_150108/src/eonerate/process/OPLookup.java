/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package eonerate.process;

import ElcRate.exception.InitializationException;
import ElcRate.exception.ProcessingException;
import ElcRate.lang.CustProductInfo;
import ElcRate.logging.ILogger;
import ElcRate.logging.LogUtil;
import ElcRate.record.IRecord;
import ElcRate.record.RecordError;
import eonerate.entity.RatRec;
import eonerate.entity.OfferPriority;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import eonerate.util.DatabaseUtil;
import java.util.Collections;

/**
 *
 * @author manucian86
 */
public class OPLookup extends ElcRate.process.AbstractStubPlugIn {

    ILogger LOG_PROCESSING = LogUtil.getLogUtil().getLogger("Processing");

    private static String OriginalPipelineName;
    private static String OriginalModuleName;

    public static List<OfferPriority> OfferPrioritys = null;

    public static void InitCache() throws InitializationException {
        if (OriginalPipelineName == null
                || OriginalModuleName == null) {
            
            return;
        
        }

        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        if (OfferPrioritys == null) {
            OfferPrioritys = new ArrayList<OfferPriority>();
        } else {
            OfferPrioritys.clear();
        }

        try {
            connection = DatabaseUtil.getDatabaseConnection(OriginalPipelineName, OriginalModuleName);

            String selectQuery = DatabaseUtil.getDataStatements(OriginalPipelineName, OriginalModuleName, "SelectStatement");

            preparedStatement = DatabaseUtil.getPreparedStatement(connection, selectQuery);

            // Execute the query
            resultSet = preparedStatement.executeQuery();

            // Loop through the results for the customer login cache
            while (resultSet.next()) {
                OfferPriority offerPriority = new OfferPriority();
                offerPriority.POOfferId = resultSet.getInt("PO_OFFER_ID");
                offerPriority.POOfferName = resultSet.getString("PO_OFFER_NAME");
                offerPriority.ResellerVersionId = resultSet.getInt("RESELLER_VERSION_ID");
                offerPriority.UpsellTemplateId = resultSet.getInt("UPSELL_TEMPLATE_ID");
                offerPriority.UpsellTemplateName = resultSet.getString("UPSELL_TEMPLATE_NAME");
                offerPriority.UpsellTemplateMapId = resultSet.getInt("UPSELL_TEMPLATE_MAP_ID");
//                offerPriority.BundleName = resultSet.getString("BUNDLE_NAME");
//                offerPriority.BundleId = resultSet.getInt("BUNDLE_ID");
                offerPriority.UpsellTmpOfferId = resultSet.getInt("UPSELL_TMP_OFFER_ID");
                offerPriority.UpsellTmpOfferName = resultSet.getString("UPSELL_TMP_OFFER_NAME");
                offerPriority.TariffPriority = resultSet.getInt("TARIFF_PRIORITY");
                offerPriority.RCPriority = resultSet.getInt("RC_PRIORITY");
                offerPriority.DiscountPriority = resultSet.getInt("DISCOUNT_PRIORITY");
                offerPriority.BalancePriority = resultSet.getInt("BALANCE_PRIORITY");
                offerPriority.DisplayPriority = resultSet.getInt("DISPLAY_PRIORITY");

                OfferPrioritys.add(offerPriority);
            }

        } catch (InitializationException ex) {
            throw new InitializationException("WHEN: Initialize OFFER_PRIORITY ResultSet. Error: " + ex.toString(), ex, OriginalModuleName);
        } catch (SQLException ex) {
            throw new InitializationException("WHEN: Initialize OFFER_PRIORITY ResultSet. Error: " + ex.toString(), ex, OriginalModuleName);
        } finally {
            if (resultSet != null) {
                try {
                    resultSet.close();
                } catch (SQLException ex) {
                    throw new InitializationException("WHEN: Close ResultSet. Error: " + ex.toString(), ex, OriginalModuleName);
                }
            }

            if (preparedStatement != null) {
                try {
                    preparedStatement.close();
                } catch (SQLException ex) {
                    throw new InitializationException("WHEN: Close PreparedStatement. Error: " + ex.toString(), ex, OriginalModuleName);
                }
            }

            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException ex) {
                    throw new InitializationException("WHEN: Close Connection. Error: " + ex.toString(), ex, OriginalModuleName);
                }
            }
        }
    }

    @Override
    public void init(String PipelineName, String ModuleName) throws InitializationException {
        OriginalPipelineName = PipelineName;
        OriginalModuleName = ModuleName;

        super.init(PipelineName, ModuleName); //To change body of generated methods, choose Tools | Templates.

        InitCache();
    }

//    @Override
//    public void init(String PipelineName, String ModuleName) throws InitializationException {
//        super.init(PipelineName, ModuleName); //To change body of generated methods, choose Tools | Templates.
//
//        Connection connection = null;
//        PreparedStatement preparedStatement = null;
//        ResultSet resultSet = null;
//
//        if (OfferPrioritys == null) {
//            OfferPrioritys = new ArrayList<OfferPriority>();
//        } else {
//            OfferPrioritys.clear();
//        }
//
//        try {
//            connection = DatabaseUtil.getDatabaseConnection(PipelineName, ModuleName, getSymbolicName());
//
//            String selectQuery = DatabaseUtil.getDataStatements(PipelineName, ModuleName, "SelectStatement");
//
//            preparedStatement = DatabaseUtil.getPreparedStatement(connection, selectQuery);
//
//            // Execute the query
//            resultSet = preparedStatement.executeQuery();
//
//            // Loop through the results for the customer login cache
//            while (resultSet.next()) {
//                OfferPriority offerPriority = new OfferPriority();
//                offerPriority.POOfferId = resultSet.getInt("PO_OFFER_ID");
//                offerPriority.POOfferName = resultSet.getString("PO_OFFER_NAME");
//                offerPriority.ResellerVersionId = resultSet.getInt("RESELLER_VERSION_ID");
//                offerPriority.UpsellTemplateId = resultSet.getInt("UPSELL_TEMPLATE_ID");
//                offerPriority.UpsellTemplateName = resultSet.getString("UPSELL_TEMPLATE_NAME");
//                offerPriority.UpsellTemplateMapId = resultSet.getInt("UPSELL_TEMPLATE_MAP_ID");
////                offerPriority.BundleName = resultSet.getString("BUNDLE_NAME");
////                offerPriority.BundleId = resultSet.getInt("BUNDLE_ID");
//                offerPriority.UpsellTmpOfferId = resultSet.getInt("UPSELL_TMP_OFFER_ID");
//                offerPriority.UpsellTmpOfferName = resultSet.getString("UPSELL_TMP_OFFER_NAME");
//                offerPriority.TariffPriority = resultSet.getInt("TARIFF_PRIORITY");
//                offerPriority.RCPriority = resultSet.getInt("RC_PRIORITY");
//                offerPriority.DiscountPriority = resultSet.getInt("DISCOUNT_PRIORITY");
//                offerPriority.BalancePriority = resultSet.getInt("BALANCE_PRIORITY");
//                offerPriority.DisplayPriority = resultSet.getInt("DISPLAY_PRIORITY");
//
//                OfferPrioritys.add(offerPriority);
//            }
//
//        } catch (InitializationException ex) {
//            throw new InitializationException("WHEN: Initialize OFFER_PRIORITY ResultSet. Error: " + ex.toString(), ex, getSymbolicName());
//        } catch (SQLException ex) {
//            throw new InitializationException("WHEN: Initialize OFFER_PRIORITY ResultSet. Error: " + ex.toString(), ex, getSymbolicName());
//        } finally {
//            if (resultSet != null) {
//                try {
//                    resultSet.close();
//                } catch (SQLException ex) {
//                    throw new InitializationException("WHEN: Close ResultSet. Error: " + ex.toString(), ex, getSymbolicName());
//                }
//            }
//
//            if (preparedStatement != null) {
//                try {
//                    preparedStatement.close();
//                } catch (SQLException ex) {
//                    throw new InitializationException("WHEN: Close PreparedStatement. Error: " + ex.toString(), ex, getSymbolicName());
//                }
//            }
//
//            if (connection != null) {
//                try {
//                    connection.close();
//                } catch (SQLException ex) {
//                    throw new InitializationException("WHEN: Close Connection. Error: " + ex.toString(), ex, getSymbolicName());
//                }
//            }
//        }
//    }
    @Override
    public IRecord procValidRecord(IRecord r) throws ProcessingException {
        RecordError recordError;
        RatRec currentRecord = (RatRec) r;
        CustProductInfo aCustProductInfo;

        List<OfferPriority> sortedOfferPriorities = new ArrayList<OfferPriority>();

        String poProductId = currentRecord.RatePlans.get(0).getProductID();

        for (CustProductInfo RatePlan : currentRecord.RatePlans) {
            aCustProductInfo = RatePlan;
            boolean existed = false;
            // Co cau hinh trong UpsellTemplate
            for (OfferPriority offerPriority : OfferPrioritys) {
                if (poProductId.equals(offerPriority.POOfferId.toString())
                        && aCustProductInfo.getProductID().equals(offerPriority.UpsellTmpOfferId.toString())) {

                    sortedOfferPriorities.add(offerPriority);

                    existed = true;

                    break;

                }
            }
            // Khong cau hinh trong UpsellTemplate
            if (!existed) {
                for (OfferPriority offerPriority : OfferPrioritys) {
                    if (aCustProductInfo.getProductID().equals(offerPriority.POOfferId.toString())
                            && aCustProductInfo.getProductID().equals(offerPriority.UpsellTmpOfferId.toString())
                            && offerPriority.UpsellTemplateId.equals(0)) {

                        sortedOfferPriorities.add(offerPriority);

                        break;

                    }
                }
            }
        }
        if (sortedOfferPriorities.size() != currentRecord.RatePlans.size()) {
            recordError = new RecordError("ERR_OFFER_PRIORITY_LOOKUP: Not full OfferPriorities");
            currentRecord.addError(recordError);
            return r;
        }

        // BALANCE
        for (int i = 0; i < sortedOfferPriorities.size() - 1; i++) {
            OfferPriority item1 = sortedOfferPriorities.get(i);

            for (int j = i + 1; j < sortedOfferPriorities.size(); j++) {
                OfferPriority item2 = sortedOfferPriorities.get(j);

                if (item1.BalancePriority > item2.BalancePriority) {
                    Collections.swap(sortedOfferPriorities, i, j);
                }

            }
        }
        currentRecord.offIdBs = new ArrayList<Integer>();
        for (OfferPriority offerPriority : sortedOfferPriorities) {
            currentRecord.offIdBs.add(offerPriority.UpsellTmpOfferId);
        }

        // TARIFF
        for (int i = 0; i < sortedOfferPriorities.size() - 1; i++) {
            OfferPriority item1 = sortedOfferPriorities.get(i);

            for (int j = i + 1; j < sortedOfferPriorities.size(); j++) {
                OfferPriority item2 = sortedOfferPriorities.get(j);

                if (item1.TariffPriority > item2.TariffPriority) {
                    Collections.swap(sortedOfferPriorities, i, j);
                }

            }
        }
        currentRecord.offIdTs = new ArrayList<Integer>();
        for (OfferPriority offerPriority : sortedOfferPriorities) {
            currentRecord.offIdTs.add(offerPriority.UpsellTmpOfferId);
        }

        // DISCOUNT
        for (int i = 0; i < sortedOfferPriorities.size() - 1; i++) {
            OfferPriority item1 = sortedOfferPriorities.get(i);

            for (int j = i + 1; j < sortedOfferPriorities.size(); j++) {
                OfferPriority item2 = sortedOfferPriorities.get(j);

                if (item1.DiscountPriority > item2.DiscountPriority) {
                    Collections.swap(sortedOfferPriorities, i, j);
                }

            }
        }
        currentRecord.offIdDs = new ArrayList<Integer>();
        for (OfferPriority offerPriority : sortedOfferPriorities) {
            currentRecord.offIdDs.add(offerPriority.UpsellTmpOfferId);
        }

        return currentRecord;
    }

    @Override
    public IRecord procErrorRecord(IRecord r) throws ProcessingException {
        return r;
    }

}
