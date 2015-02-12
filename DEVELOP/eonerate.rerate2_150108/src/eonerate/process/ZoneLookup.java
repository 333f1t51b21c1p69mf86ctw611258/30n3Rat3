/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package eonerate.process;

import ElcRate.exception.ProcessingException;
import ElcRate.lang.DigitTree;
import ElcRate.logging.ILogger;
import ElcRate.logging.LogUtil;
import ElcRate.process.AbstractBestMatch;
import ElcRate.record.ErrorType;
import ElcRate.record.IRecord;
import ElcRate.record.RecordError;
import eonerate.entity.RatRec;
import org.apache.commons.lang.StringUtils;

/**
 *
 * @author manucian86
 */
public class ZoneLookup extends AbstractBestMatch {

	ILogger LOG_PROCESSING = LogUtil.getLogUtil().getLogger("Processing");

	@Override
	public IRecord procValidRecord(IRecord r) throws ProcessingException {
		RatRec currentRecord = (RatRec) r;

		if (currentRecord.cdrType.equalsIgnoreCase(RatRec.CDR_TYPE_DATA)) {
			return r;
		}

		RecordError recordError;
		String zoneA;
		String zoneB;
		String logString = null;

		// Neu reformat da enrich cho BZone
		// Thi currentRecord.ZoneInfo = BZone
		if (StringUtils.isNotEmpty(currentRecord.ZoneA)
				&& StringUtils.isNotEmpty(currentRecord.ZoneB)) {

			//            currentRecord.ZoneInfo = currentRecord.ZoneB;

			//log
			logString = getSymbolicName() + " [A_NUMBER: " + currentRecord.NumberA + "]-[B_NUMBER: " + currentRecord.NumberB + "] => Result: ZoneA: " + currentRecord.ZoneA + "; ZoneB: " + currentRecord.ZoneB;
			LOG_PROCESSING.debug(logString);

			//return record
			return r;
		}

		// Look up Zone by Service group
		try {
			//            zoneA = getBestMatch(RateRecord.SERVICE_TEMP, currentRecord.NumberA);
			zoneA = getBestMatch(currentRecord.svId.toString(), currentRecord.NumberA);
			//        	zoneB = getBestMatch(RateRecord.SERVICE_TEMP, currentRecord.NumberB);
			zoneB = getBestMatch(currentRecord.svId.toString(), currentRecord.NumberB);

			if (zoneA.equalsIgnoreCase(DigitTree.NO_DIGIT_TREE_MATCH)) {
				recordError = new RecordError("Zone wasnt found for NumberA=" + currentRecord.NumberB);
				currentRecord.addError(recordError);
			} else {
				if (!zoneB.equalsIgnoreCase(DigitTree.NO_DIGIT_TREE_MATCH)) {
					// Write the information back into the record
					//                    currentRecord.ZoneInfo = zoneB;

					currentRecord.ZoneA = zoneA;
					currentRecord.ZoneB = zoneB;

					logString = getSymbolicName()
							+ " [A_NUMBER: " + currentRecord.NumberA + "]-[B_NUMBER: " + currentRecord.NumberB
							+ "] => Result: ZoneA: " + currentRecord.ZoneA + "; ZoneB: " + currentRecord.ZoneB;

				} else {
					//                    currentRecord.ZoneInfo = "UNKNOWN"; // "VAS";

					recordError = new RecordError("Zone wasnt found for BNumber=" + currentRecord.NumberB);
					currentRecord.addError(recordError);
				}
			}

		} catch (Exception e) {
			// error detected, add an error to the record
			recordError = new RecordError("Zone wasnt found; Detail: " + e.toString(), ErrorType.DATA_NOT_FOUND, this.getSymbolicName());
			currentRecord.addError(recordError);
			logString = getSymbolicName() + " [A_NUMBER: " + currentRecord.NumberA + "]-[B_NUMBER: " + currentRecord.NumberB + "]; EXCEPTION: " + recordError;
		}

		LOG_PROCESSING.debug(logString);
		return r;
	}

	@Override
	public IRecord procErrorRecord(IRecord r) throws ProcessingException {
		return r;
	}

}
