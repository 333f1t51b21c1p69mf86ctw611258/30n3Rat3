/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package eonerate.process;

import ElcRate.cache.AbstractSyncLoaderCache;
import ElcRate.db.DBUtil;
import ElcRate.exception.InitializationException;
import ElcRate.logging.ILogger;
import ElcRate.logging.LogUtil;
import ElcRate.utils.PropertyUtils;
import eonerate.entity.ResellerVersion;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author manucian86
 */
public class ResVerCache extends AbstractSyncLoaderCache {

    ILogger LOG_PROCESSING = LogUtil.getLogUtil().getLogger("Processing");

    public static final String OBJECT_NAME = "RESELLER_VERSION";

//    private String NodeDataFile;
//    private String XrefDataFile;
//    private String NodeDataSelectQuery;
    private String XrefDataSelectQuery;
//    private PreparedStatement StmtNodeDataSelectQuery;
    private PreparedStatement StmtXrefDataSelectQuery;

    protected List<ResellerVersion> ObjectCache;

    public ResVerCache() {
        super();

        ObjectCache = new ArrayList<ResellerVersion>();
    }

    @Override
    public void loadDataFromFile() throws InitializationException {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    private void loadAllCache() throws InitializationException {
        
        LOG_PROCESSING.info("!!! Starting to load ALL Cache from DB");
        
        OPLookup.InitCache();
        PrRat.InitCache();
        Rat.InitCache();
        PoRat.InitCache();
    
    }

    @Override
    public void loadDataFromDB() throws InitializationException {
        
        int ObjectLinesLoaded = 0;

        // Find the location of the  RESELLER_VERSION configuration file
        LOG_PROCESSING.info("Starting " + OBJECT_NAME + " Cache Loading from DB");

        JDBCcon = DBUtil.getConnection(cacheDataSourceName);

        // Now prepare the statements
        prepareStatements();

        // *************************************************************************
        // Execute the query to get the RESELLER_VERSION
        try {
            mrs = StmtXrefDataSelectQuery.executeQuery();
        } catch (SQLException ex) {
            String Message = "Error performing SQL for retieving " + OBJECT_NAME + " Lookup data; " + ex.toString();
            LOG_PROCESSING.fatal(Message);
            throw new InitializationException(Message, getSymbolicName());
        }

        // loop through the results
        try {
            mrs.beforeFirst();

            while (mrs.next()) {
                ObjectLinesLoaded++;

                ResellerVersion resellerVersion = new ResellerVersion();
                resellerVersion.rvId = mrs.getInt("RESELLER_VERSION_ID");
                resellerVersion.activeDate = mrs.getDate("ACTIVE_DATE");
                resellerVersion.inactiveDate = mrs.getDate("INACTIVE_DATE");
                resellerVersion.status = mrs.getInt("STATUS");
                resellerVersion.svId = mrs.getInt("SERVICE_VERSION_ID");

                ObjectCache.add(resellerVersion);
            }
        } catch (SQLException ex) {
            String Message = "Error opening " + OBJECT_NAME + " Data for <"
                    + cacheDataSourceName + ">; ERROR: " + ex.toString();
            LOG_PROCESSING.fatal(Message);
            throw new InitializationException(Message, getSymbolicName());
        }

        // Close down the query
        try {
            mrs.close();
            StmtXrefDataSelectQuery.close();
        } catch (SQLException ex) {
            String Message = "Error closing " + OBJECT_NAME + " Data connection for <"
                    + cacheDataSourceName + ">; ERROR: " + ex.toString();
            LOG_PROCESSING.fatal(Message);
            throw new InitializationException(Message, getSymbolicName());
        }

        // *************************************************************************
        // Close down the connection
        try {
            JDBCcon.close();
        } catch (SQLException ex) {
            String Message = "Error closing " + OBJECT_NAME + " Data connection for <"
                    + cacheDataSourceName + ">" + "; ERROR: " + ex.toString();
            LOG_PROCESSING.fatal(Message);
            throw new InitializationException(Message, getSymbolicName());
        }

        LOG_PROCESSING.info(
                OBJECT_NAME + " Lookup Data Loading completed. <" + ObjectLinesLoaded
                + "> configuration lines loaded from <"
                + cacheDataSourceName + ">");
        
        loadAllCache();
        
    }

    @Override
    public void loadDataFromMethod() throws InitializationException {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public void clearCacheObjects() {
        ObjectCache.clear();
    }

    @Override
    protected boolean getDataStatements(String ResourceName, String CacheName) throws InitializationException {

        // Get the Select statement
        XrefDataSelectQuery = PropertyUtils.getPropertyUtils().getDataCachePropertyValueDef(ResourceName,
                CacheName,
                "XrefSelectStatement",
                "None");

        return !XrefDataSelectQuery.equals("None");

    }

    @Override
    protected void prepareStatements() throws InitializationException {
        // prepare our statements
        try {
            // prepare the SQL for the TestStatement
            StmtXrefDataSelectQuery = JDBCcon.prepareStatement(XrefDataSelectQuery,
                    ResultSet.TYPE_SCROLL_INSENSITIVE,
                    ResultSet.CONCUR_UPDATABLE);
        } catch (SQLException ex) {
            String Message = "Error preparing the statement " + XrefDataSelectQuery + "; ERROR: " + ex.toString();
            LOG_PROCESSING.error(Message);
            throw new InitializationException(Message, getSymbolicName());
        }
    }

    @Override
    public String processControlEvent(String Command, boolean Init, String Parameter) {

        return super.processControlEvent(Command, Init, Parameter); //To change body of generated methods, choose Tools | Templates.

    }

}
