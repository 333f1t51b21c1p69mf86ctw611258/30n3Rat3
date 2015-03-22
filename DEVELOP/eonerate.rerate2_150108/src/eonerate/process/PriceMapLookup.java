/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package eonerate.process;

import ElcRate.logging.ILogger;
import ElcRate.logging.LogUtil;
import ElcRate.process.AbstractRegexMatch;
import ElcRate.record.ChargePacket;
import ElcRate.record.ErrorType;
import ElcRate.record.IRecord;
import ElcRate.record.RecordError;
import eonerate.entity.RatRec;

/**
 * @class PriceModelLookup.java
 * @time Created on Nov 8, 2013, 3:11:04 PM
 * @author hinhnd
 */
public class PriceMapLookup extends AbstractRegexMatch {

	ILogger LOG_PROCESSING = LogUtil.getLogUtil().getLogger("Processing");
	// String array used for searching
	private String[] tmpSearchParameters = new String[3];

	@Override
	public IRecord procValidRecord(IRecord r) {

		ChargePacket aChargePacket;
		String regexGroup;
		String regexResult;
		String logString = "";
		int Index;
		RecordError tmpError;
		RatRec currentRecord = (RatRec) r;
		// service TEL
		//for test lookup all
		for (Index = 0; Index < currentRecord.getChargePacketCount(); Index++) {
			// Prepare the paramters to perform the search on
			aChargePacket = currentRecord.getChargePacket(Index);

			tmpSearchParameters[0] = aChargePacket.ratePlanName;
			tmpSearchParameters[1] = aChargePacket.zoneResult;
			tmpSearchParameters[2] = aChargePacket.timeModel; // tmpCP.timeResult;

			regexGroup = currentRecord.rvId.toString(); // tmpCP.service;

			// Look up the rate model to use
			regexResult = getRegexMatch(regexGroup, tmpSearchParameters);
			logString = getSymbolicName() + " [A_NUMBER: " + currentRecord.NumberA + ", B_NUMBER: " + currentRecord.NumberB + ", CDR_TYPE: " + currentRecord.cdrTypeName + "]";
			logString = logString + " => Result: <rate model to use: " + regexResult + ">";
			LOG_PROCESSING.debug(logString);

			if (regexResult.equals("NOMATCH")) {
				tmpError = new RecordError("ERR_PRICE_MODEL_NOT_FOUND", ErrorType.SPECIAL);
				currentRecord.addError(tmpError);
			} else {
				aChargePacket.priceGroup = regexResult;
			}
		}

		return r;
	}

	@Override
	public IRecord procErrorRecord(IRecord r) {
		return r;
	}
}
