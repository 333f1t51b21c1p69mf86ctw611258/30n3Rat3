/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package eonerate.process;

import ElcRate.cache.ICacheManager;
import ElcRate.exception.InitializationException;
import ElcRate.exception.ProcessingException;
import ElcRate.logging.ILogger;
import ElcRate.logging.LogUtil;
import ElcRate.process.AbstractPlugIn;
import ElcRate.record.ErrorType;
import ElcRate.record.IRecord;
import ElcRate.record.RecordError;
import ElcRate.resource.CacheFactory;
import ElcRate.utils.PropertyUtils;
import eonerate.entity.RatRec;
import eonerate.entity.ResellerVersion;

/**
 *
 * @author manucian86
 */
public class ResVerLookup extends AbstractPlugIn {

	ILogger LOG_PROCESSING = LogUtil.getLogUtil().getLogger("Processing");

	//    public static List<ResellerVersion> ResellerVersions = null;
	// This is the object will be using the find the cache manager
	private ICacheManager cacheManager = null;

	// The zone model object
	private ResVerCache resellerVersionCache;

	@Override
	public void init(String PipelineName, String ModuleName) throws InitializationException {
		// Variable for holding the cache object name
		String CacheObjectName;

		super.init(PipelineName, ModuleName); //To change body of generated methods, choose Tools | Templates.

		// Get the cache object reference
		CacheObjectName = PropertyUtils.getPropertyUtils().getPluginPropertyValue(PipelineName,
				ModuleName,
				"DataCache");
		cacheManager = CacheFactory.getGlobalManager(CacheObjectName);

		if (cacheManager == null) {
			LOG_PROCESSING.fatal("Could not find cache entry for <" + CacheObjectName + ">");
			throw new InitializationException("Could not find cache entry for <"
					+ CacheObjectName + "> in module <" + getSymbolicName() + ">", getSymbolicName());
		}

		// Load up the mapping arrays
		resellerVersionCache = (ResVerCache) cacheManager.get(CacheObjectName);

		if (resellerVersionCache == null) {
			LOG_PROCESSING.fatal("Could not find cache entry for <" + CacheObjectName + ">");
			throw new InitializationException("Could not find cache entry for <"
					+ CacheObjectName + ">in module <" + getSymbolicName() + ">", getSymbolicName());
		}
	}

	//    @Override
	//    public void init(String PipelineName, String ModuleName) throws InitializationException {
	//        super.init(PipelineName, ModuleName); //To change body of generated methods, choose Tools | Templates.
	//
	//        Connection connection = null;
	//        PreparedStatement preparedStatement = null;
	//        ResultSet resultSet = null;
	//
	//        if (ResellerVersions == null) {
	//            ResellerVersions = new ArrayList<ResellerVersion>();
	//        } else {
	//            ResellerVersions.clear();
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
	//                ResellerVersion resellerVersion = new ResellerVersion();
	//                resellerVersion.resellerVersionId = resultSet.getInt("RESELLER_VERSION_ID");
	//                resellerVersion.activeDate = resultSet.getDate("ACTIVE_DATE");
	//                resellerVersion.inactiveDate = resultSet.getDate("INACTIVE_DATE");
	//                resellerVersion.status = resultSet.getInt("STATUS");
	//
	//                ResellerVersions.add(resellerVersion);
	//            }
	//
	//        } catch (InitializationException ex) {
	//            throw new InitializationException("WHEN: Initialize RESELLER_VERSION ResultSet. Error: " + ex.toString(), ex, getSymbolicName());
	//        } catch (SQLException ex) {
	//            throw new InitializationException("WHEN: Initialize RESELLER_VERSION ResultSet. Error: " + ex.toString(), ex, getSymbolicName());
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
		RatRec currentRecord = (RatRec) r;

		boolean existed = false;

		for (ResellerVersion resellerVersion : resellerVersionCache.ObjectCache) {

			if ((currentRecord.EventStartDate.getTime() >= resellerVersion.activeDate.getTime()
					&& resellerVersion.inactiveDate == null)
					//
					|| (currentRecord.EventStartDate.getTime() >= resellerVersion.activeDate.getTime()
					&& currentRecord.EventStartDate.getTime() <= resellerVersion.inactiveDate.getTime())) {

				currentRecord.rvId = resellerVersion.rvId;
				currentRecord.svId = resellerVersion.svId;

				LOG_PROCESSING.debug(currentRecord.concatHeader(0, "ResVerId: " + currentRecord.rvId.toString()));

				existed = true;

				break;

			}
		}

		if (!existed) {
			// error detected, add an error to the record
			LOG_PROCESSING.warning(currentRecord.concatHeader(0, "### RESELLER_VERSION ISN'T FOUND"));

			RecordError recordError = new RecordError("ResellerVersion isn't found", ErrorType.DATA_NOT_FOUND, this.getSymbolicName());
			currentRecord.addError(recordError);
		}

		return currentRecord;
	}

	@Override
	public IRecord procErrorRecord(IRecord r) throws ProcessingException {
		return r;
	}

	@Override
	public IRecord procHeader(IRecord r) {
		return r;
	}

	@Override
	public IRecord procTrailer(IRecord r) {
		return r;
	}

	@Override
	public String processControlEvent(String Command, boolean Init, String Parameter) {
		return super.processControlEvent(Command, Init, Parameter); //To change body of generated methods, choose Tools | Templates.
	}

}
