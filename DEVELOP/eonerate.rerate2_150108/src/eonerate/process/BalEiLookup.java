/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package eonerate.process;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import ElcRate.exception.InitializationException;
import ElcRate.exception.ProcessingException;
import ElcRate.lang.CustProductInfo;
import ElcRate.logging.ILogger;
import ElcRate.logging.LogUtil;
import ElcRate.record.IRecord;
import ElcRate.record.RecordError;
import eonerate.common.Constant;
import eonerate.entity.BalanceEi;
import eonerate.entity.RatRec;
import eonerate.util.DatabaseUtil;

/**
 *
 * @author manucian86
 */
public class BalEiLookup extends ElcRate.process.AbstractStubPlugIn {

	ILogger LOG_PROCESSING = LogUtil.getLogUtil().getLogger("Processing");

	private static String OriginalPipelineName;
	private static String OriginalModuleName;

	public static List<BalanceEi> BalanceEis = null;

	public static void InitCache() throws InitializationException {
		if (OriginalPipelineName == null
				|| OriginalModuleName == null) {

			return;

		}

		Connection connection = null;
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;

		if (BalanceEis == null) {
			BalanceEis = new ArrayList<BalanceEi>();
		} else {
			BalanceEis.clear();
		}

		try {
			connection = DatabaseUtil.getDatabaseConnection(OriginalPipelineName, OriginalModuleName);

			String selectQuery = DatabaseUtil.getDataStatements(OriginalPipelineName, OriginalModuleName, "SelectStatement");

			preparedStatement = DatabaseUtil.getPreparedStatement(connection, selectQuery);

			// Execute the query
			resultSet = preparedStatement.executeQuery();

			// Loop through the results for the customer login cache
			while (resultSet.next()) {
				BalanceEi balanceEi = new BalanceEi();
				balanceEi.BalanceEiId = resultSet.getInt("BALANCE_EI_ID");
				balanceEi.resellerVersionId = resultSet.getInt("RESELLER_VERSION_ID");

				balanceEi.OfferName = resultSet.getString("OFFER_NAME");
				balanceEi.offerId = resultSet.getInt("OFFER_ID");

				balanceEi.BalanceName = resultSet.getString("BALANCE_NAME");
				balanceEi.BalanceId = resultSet.getInt("BALANCE_ID");

				balanceEi.RcTermName = resultSet.getString("RC_TERM_NAME");
				balanceEi.RcTermId = resultSet.getInt("RC_TERM_ID");

				balanceEi.NrcTermName = resultSet.getString("NRC_TERM_NAME");
				balanceEi.NrcTermId = resultSet.getInt("NRC_TERM_ID");

				balanceEi.EiFlag = resultSet.getString("EI_FLAG");

				balanceEi.TimeTypeName = resultSet.getString("TIME_TYPE_NAME");
				balanceEi.TimeTypeId = resultSet.getInt("TIME_TYPE_ID");

				balanceEi.UaName = resultSet.getString("UA_NAME");
				balanceEi.uaId = resultSet.getInt("UA_ID");

				balanceEi.UaGroupName = resultSet.getString("UA_GROUP_NAME");
				balanceEi.UaGroupId = resultSet.getInt("UA_GROUP_ID");

				//				balanceEi.UnitTypeId = resultSet.getInt("UNIT_TYPE_ID");

				BalanceEis.add(balanceEi);
			}

		} catch (InitializationException ex) {
			throw new InitializationException("WHEN: Initialize BALANCE_EI ResultSet. Error: " + ex.toString(), ex, OriginalModuleName);
		} catch (SQLException ex) {
			throw new InitializationException("WHEN: Initialize BALANCE_EI ResultSet. Error: " + ex.toString(), ex, OriginalModuleName);
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
	//        if (BalanceEis == null) {
	//            BalanceEis = new ArrayList<BalanceEi>();
	//        } else {
	//            BalanceEis.clear();
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
	//                BalanceEi balanceEi = new BalanceEi();
	//                balanceEi.POOfferId = resultSet.getInt("PO_OFFER_ID");
	//                balanceEi.POOfferName = resultSet.getString("PO_OFFER_NAME");
	//                balanceEi.ResellerVersionId = resultSet.getInt("RESELLER_VERSION_ID");
	//                balanceEi.UpsellTemplateId = resultSet.getInt("UPSELL_TEMPLATE_ID");
	//                balanceEi.UpsellTemplateName = resultSet.getString("UPSELL_TEMPLATE_NAME");
	//                balanceEi.UpsellTemplateMapId = resultSet.getInt("UPSELL_TEMPLATE_MAP_ID");
	////                balanceEi.BundleName = resultSet.getString("BUNDLE_NAME");
	////                balanceEi.BundleId = resultSet.getInt("BUNDLE_ID");
	//                balanceEi.UpsellTmpOfferId = resultSet.getInt("UPSELL_TMP_OFFER_ID");
	//                balanceEi.UpsellTmpOfferName = resultSet.getString("UPSELL_TMP_OFFER_NAME");
	//                balanceEi.TariffPriority = resultSet.getInt("TARIFF_PRIORITY");
	//                balanceEi.RCPriority = resultSet.getInt("RC_PRIORITY");
	//                balanceEi.DiscountPriority = resultSet.getInt("DISCOUNT_PRIORITY");
	//                balanceEi.BalancePriority = resultSet.getInt("BALANCE_PRIORITY");
	//                balanceEi.DisplayPriority = resultSet.getInt("DISPLAY_PRIORITY");
	//
	//                BalanceEis.add(balanceEi);
	//            }
	//
	//        } catch (InitializationException ex) {
	//            throw new InitializationException("WHEN: Initialize BALANCE_EI ResultSet. Error: " + ex.toString(), ex, getSymbolicName());
	//        } catch (SQLException ex) {
	//            throw new InitializationException("WHEN: Initialize BALANCE_EI ResultSet. Error: " + ex.toString(), ex, getSymbolicName());
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

		//		List<BalanceEi> sortedOfferPriorities = new ArrayList<BalanceEi>();

		currentRecord.balEiIncls = new ArrayList<BalanceEi>();

		//		String poProductId = currentRecord.RatePlans.get(0).getProductID();

		for (CustProductInfo RatePlan : currentRecord.RatePlans) {
			aCustProductInfo = RatePlan;

			//			boolean existed = false;

			for (BalanceEi balanceEi : BalanceEis) {
				if (currentRecord.rvId.equals(balanceEi.resellerVersionId) &&
						aCustProductInfo.getProductID().equals(balanceEi.offerId.toString()) &&
						currentRecord.uaId.equals(balanceEi.uaId.toString())) {

					// TODO Truong hop EiFlag = EXCL
					if (balanceEi.EiFlag.equals(Constant.EI_FLAG_INCL)) {

						// TODO Cac truong hop TimeType = 0_24, Peak, Off-Peak, ...
						if (balanceEi.TimeTypeId.equals(-1)) { // Any
							currentRecord.balEiIncls.add(balanceEi);

							//					existed = true;

							//					break;
						}
					}
				}
			}

			//			if (!existed) {
			//				for (BalanceEi balanceEi : BalanceEis) {
			//					if (aCustProductInfo.getProductID().equals(balanceEi.POOfferId.toString())
			//							&& aCustProductInfo.getProductID().equals(balanceEi.UpsellTmpOfferId.toString())
			//							&& balanceEi.UpsellTemplateId.equals(0)) {
			//
			//						sortedOfferPriorities.add(balanceEi);
			//
			//						break;
			//
			//					}
			//				}
			//			}
		}

		//		if (sortedOfferPriorities.size() != currentRecord.RatePlans.size()) {
		//			recordError = new RecordError("ERR_BALANCE_EI_LOOKUP: Not full OfferPriorities");
		//			currentRecord.addError(recordError);
		//			return r;
		//		}

		//		// BALANCE
		//		for (int i = 0; i < sortedOfferPriorities.size() - 1; i++) {
		//			BalanceEi item1 = sortedOfferPriorities.get(i);
		//
		//			for (int j = i + 1; j < sortedOfferPriorities.size(); j++) {
		//				BalanceEi item2 = sortedOfferPriorities.get(j);
		//
		//				if (item1.BalancePriority > item2.BalancePriority) {
		//					Collections.swap(sortedOfferPriorities, i, j);
		//				}
		//
		//			}
		//		}
		//		currentRecord.OfferIdBs = new ArrayList<Integer>();
		//		for (BalanceEi balanceEi : sortedOfferPriorities) {
		//			currentRecord.OfferIdBs.add(balanceEi.UpsellTmpOfferId);
		//		}
		//
		//		// TARIFF
		//		for (int i = 0; i < sortedOfferPriorities.size() - 1; i++) {
		//			BalanceEi item1 = sortedOfferPriorities.get(i);
		//
		//			for (int j = i + 1; j < sortedOfferPriorities.size(); j++) {
		//				BalanceEi item2 = sortedOfferPriorities.get(j);
		//
		//				if (item1.TariffPriority > item2.TariffPriority) {
		//					Collections.swap(sortedOfferPriorities, i, j);
		//				}
		//
		//			}
		//		}
		//		currentRecord.OfferIdTs = new ArrayList<Integer>();
		//		for (BalanceEi balanceEi : sortedOfferPriorities) {
		//			currentRecord.OfferIdTs.add(balanceEi.UpsellTmpOfferId);
		//		}
		//
		//		// DISCOUNT
		//		for (int i = 0; i < sortedOfferPriorities.size() - 1; i++) {
		//			BalanceEi item1 = sortedOfferPriorities.get(i);
		//
		//			for (int j = i + 1; j < sortedOfferPriorities.size(); j++) {
		//				BalanceEi item2 = sortedOfferPriorities.get(j);
		//
		//				if (item1.DiscountPriority > item2.DiscountPriority) {
		//					Collections.swap(sortedOfferPriorities, i, j);
		//				}
		//
		//			}
		//		}
		//		currentRecord.OfferIdDs = new ArrayList<Integer>();
		//		for (BalanceEi balanceEi : sortedOfferPriorities) {
		//			currentRecord.OfferIdDs.add(balanceEi.UpsellTmpOfferId);
		//		}

		return currentRecord;
	}

	@Override
	public IRecord procErrorRecord(IRecord r) throws ProcessingException {
		return r;
	}

}
