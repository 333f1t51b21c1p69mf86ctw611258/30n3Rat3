/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package eonerate.process;

import ElcRate.exception.InitializationException;
import ElcRate.logging.ILogger;
import ElcRate.logging.LogUtil;
import ElcRate.process.AbstractRegexMatch;
import ElcRate.record.ErrorType;
import ElcRate.record.IRecord;
import ElcRate.record.RecordError;
import eonerate.entity.RatRec;
import eonerate.entity.Zone;
import eonerate.util.DatabaseUtil;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import org.apache.commons.lang.StringUtils;

/**
 *
 * @author manucian86
 */
public class ZoneGroupLookup extends AbstractRegexMatch {

    ILogger LOG_PROCESSING = LogUtil.getLogUtil().getLogger("Processing");

    public static List<Zone> Zones = null;
    private String TempZoneA = null;
    private String TempZoneB = null;

    @Override
    public void init(String PipelineName, String ModuleName) throws InitializationException {
	super.init(PipelineName, ModuleName); //To change body of generated methods, choose Tools | Templates.

	Connection connection = null;
	PreparedStatement preparedStatement = null;
	ResultSet resultSet = null;

	if (Zones == null) {
	    Zones = new ArrayList<Zone>();
	} else {
	    Zones.clear();
	}

	try {
	    connection = DatabaseUtil.getDatabaseConnection(PipelineName, ModuleName);

	    String selectQuery = DatabaseUtil.getDataStatements(PipelineName, ModuleName, "SelectStatement");

	    preparedStatement = DatabaseUtil.getPreparedStatement(connection, selectQuery);

	    // Execute the query
	    resultSet = preparedStatement.executeQuery();

	    // Loop through the results for the customer login cache
	    while (resultSet.next()) {
		Zone zone = new Zone();
		zone.ZoneName = resultSet.getString("ZONE_NAME");
		zone.PartOf = resultSet.getString("PART_OF");

		Zones.add(zone);
	    }

	} catch (InitializationException ex) {
	    throw new InitializationException("WHEN: Initialize ZONE ResultSet. Error: " + ex.toString(), ex, getSymbolicName());
	} catch (SQLException ex) {
	    throw new InitializationException("WHEN: Initialize ZONE ResultSet. Error: " + ex.toString(), ex, getSymbolicName());
	} finally {
	    if (resultSet != null) {
		try {
		    resultSet.close();
		} catch (SQLException ex) {
		    throw new InitializationException("WHEN: Close ResultSet. Error: " + ex.toString(), ex, getSymbolicName());
		}
	    }

	    if (preparedStatement != null) {
		try {
		    preparedStatement.close();
		} catch (SQLException ex) {
		    throw new InitializationException("WHEN: Close PreparedStatement. Error: " + ex.toString(), ex, getSymbolicName());
		}
	    }

	    if (connection != null) {
		try {
		    connection.close();
		} catch (SQLException ex) {
		    throw new InitializationException("WHEN: Close Connection. Error: " + ex.toString(), ex, getSymbolicName());
		}
	    }
	}
    }

    private String rec(String regexGroup, String zoneA, String zoneB) {

	String[] tmpSearchParameters = new String[2];

	tmpSearchParameters[0] = zoneA;
	tmpSearchParameters[1] = zoneB;

	// Look up the rate model to use
	String regexResult = getRegexMatch(regexGroup, tmpSearchParameters);

	if (!regexResult.equals("NOMATCH")) {
	    TempZoneA = zoneA;
	    TempZoneB = zoneB;
	} else {
	    for (Zone zone : Zones) {
		if (zone.ZoneName.equals(zoneB) && StringUtils.isNotEmpty(zone.PartOf)) {
		    regexResult = rec(regexGroup, zoneA, zone.PartOf);

		    break;
		}
	    }

	    if (regexResult.equals("NOMATCH")) {
		for (Zone zone : Zones) {
		    if (zone.ZoneName.equals(zoneA) && StringUtils.isNotEmpty(zone.PartOf)) {
			regexResult = rec(regexGroup, zone.PartOf, zoneB);

			break;
		    }
		}
	    }
	}

	return regexResult;
    }

    @Override
    public IRecord procValidRecord(IRecord r) {
	RatRec currentRecord = (RatRec) r;

	if (currentRecord.cdrType.equalsIgnoreCase(RatRec.CDR_TYPE_DATA)) {
	    return r;
	}

	String regexGroup;
	String regexResult;
	String logString = null;
	RecordError recordError;

//        tmpSearchParameters[0] = CurrentRecord.ZoneA;
//        tmpSearchParameters[1] = CurrentRecord.ZoneB;
	regexGroup = currentRecord.rvId.toString();

	// Look up the rate model to use
	regexResult = rec(regexGroup, currentRecord.ZoneA, currentRecord.ZoneB); // getRegexMatch(regexGroup, tmpSearchParameters);

	logString = getSymbolicName() + " [ZoneA: " + currentRecord.ZoneA + ", ZoneB: " + currentRecord.ZoneB + ", ResellerVersionId: " + currentRecord.rvId + "]";
	logString = logString + " => ZoneGroup: " + regexResult + " (TempZoneA=" + TempZoneA + "; TempZoneB=" + TempZoneB + ")";

	LOG_PROCESSING.debug(logString);

	if (regexResult.equals("NOMATCH")) {
	    recordError = new RecordError("ERR_ZONE_GROUP_NOT_FOUND", ErrorType.SPECIAL);
	    currentRecord.addError(recordError);
	} else {
	    currentRecord.ZoneGroupId = regexResult;
	}

	return r;
    }

    @Override
    public IRecord procErrorRecord(IRecord r) {
	return r;
    }
}
