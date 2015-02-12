/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package eonerate.util;

import ElcRate.db.DBUtil;
import ElcRate.exception.InitializationException;
import ElcRate.utils.PropertyUtils;
import eonerate.entity.DiscountItem;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author manucian86
 */
public class DatabaseUtil {

    public static Connection getDatabaseConnection(String pipelineName, String moduleName) throws InitializationException {
        Connection jdbcCon = null;

        // Get the data source name
        String cacheDataSourceName = PropertyUtils.getPropertyUtils().getPluginPropertyValueDef(pipelineName, moduleName, "ConfigDataSource", "None");

        if (cacheDataSourceName.equals("None")) {
            throw new InitializationException("Data source DB name not found for cache <" + moduleName + ">", pipelineName);
        } else {
            jdbcCon = DBUtil.getConnection(cacheDataSourceName);
        }

        return jdbcCon;
    }

    public static String getDataStatements(String pipelineName, String ModuleName, String queryNodeName) throws InitializationException {

        String query = PropertyUtils.getPropertyUtils().getPluginPropertyValueDef(pipelineName, ModuleName, queryNodeName, "None");

        if (query.equals("None")) {
            return null;
        } else {
            return query;
        }

    }

    public static PreparedStatement getPreparedStatement(Connection jdbcConnection, String query)
            throws InitializationException {

        PreparedStatement stmtCacheData = null;

        try {
            stmtCacheData = jdbcConnection.prepareStatement(query,
                    ResultSet.TYPE_SCROLL_INSENSITIVE,
                    ResultSet.CONCUR_READ_ONLY);
        } catch (SQLException ex) {
            throw new InitializationException(
                    "Error preparing the statement <" + query + ">; ERROR: " + ex.toString(), "getPreparedStatement");
        }

        return stmtCacheData;
    }

    // *** FOR DISCOUNT
//    public static List<DiscountItem> DiscountItems = null;
    public static List<DiscountItem> InitDiscountData(String PipelineName, String ModuleName)
            throws InitializationException {

        List<DiscountItem> result = null;

        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        if (result == null) {
            result = new ArrayList<DiscountItem>();
        } else {
            result.clear();
        }

        try {
            connection = DatabaseUtil.getDatabaseConnection(PipelineName, ModuleName);

            String selectQuery = DatabaseUtil.getDataStatements(PipelineName, ModuleName, "SelectStatement");

            preparedStatement = DatabaseUtil.getPreparedStatement(connection, selectQuery);

            // Execute the query
            resultSet = preparedStatement.executeQuery();

            // Loop through the results for the customer login cache
            while (resultSet.next()) {
                DiscountItem discountItem = new DiscountItem();
                discountItem.ResellerVersionId = resultSet.getInt(DiscountItem.FN_RESELLER_VERSION_ID);
                discountItem.DiscountItemId = resultSet.getInt(DiscountItem.FN_DISCOUNT_ITEM_ID);
                discountItem.Threshold = resultSet.getInt(DiscountItem.FN_THRESHOLD);
                discountItem.Amount = resultSet.getDouble(DiscountItem.FN_AMOUNT);
                discountItem.RUMId = resultSet.getString(DiscountItem.FN_RUM_ID);
                discountItem.UsageActivityId = resultSet.getInt(DiscountItem.FN_UA_ID);
                discountItem.Period = resultSet.getString(DiscountItem.FN_PERIOD);

                result.add(discountItem);
            }

        } catch (InitializationException ex) {
            throw new InitializationException("WHEN: Initialize DISCOUNT_ITEM ResultSet. Error: " + ex.toString(), ex, PipelineName);
        } catch (SQLException ex) {
            throw new InitializationException("WHEN: Initialize DISCOUNT_ITEM ResultSet. Error: " + ex.toString(), ex, PipelineName);
        } finally {
            if (resultSet != null) {
                try {
                    resultSet.close();
                } catch (SQLException ex) {
                    throw new InitializationException("WHEN: Close ResultSet. Error: " + ex.toString(), ex, PipelineName);
                }
            }

            if (preparedStatement != null) {
                try {
                    preparedStatement.close();
                } catch (SQLException ex) {
                    throw new InitializationException("WHEN: Close PreparedStatement. Error: " + ex.toString(), ex, PipelineName);
                }
            }

            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException ex) {
                    throw new InitializationException("WHEN: Close Connection. Error: " + ex.toString(), ex, PipelineName);
                }
            }
        }

        return result;
    }
}
