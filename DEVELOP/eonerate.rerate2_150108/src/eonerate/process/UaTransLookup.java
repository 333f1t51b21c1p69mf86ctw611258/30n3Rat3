/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package eonerate.process;

import ElcRate.exception.ProcessingException;
import ElcRate.logging.ILogger;
import ElcRate.logging.LogUtil;
import ElcRate.record.ErrorType;
import ElcRate.record.IRecord;
import ElcRate.record.RecordError;
import eonerate.entity.RatRec;

public class UaTransLookup extends ElcRate.process.AbstractRegexMatch {

    ILogger LOG_PROCESSING = LogUtil.getLogUtil().getLogger("Processing");

    @Override
    public IRecord procValidRecord(IRecord r) throws ProcessingException {
	RatRec currentRecord = (RatRec) r;

	if (currentRecord.cdrType.equalsIgnoreCase(RatRec.CDR_TYPE_DATA)) {
	    return r;
	}

	RecordError recordError;
	String resultString;
	String regexGroup = currentRecord.rvId.toString();

	String[] regexParams = new String[2];

	// Get the rate plan meta data for this rate plan/charge packet type
	regexParams[0] = currentRecord.uaId.toString();
	regexParams[1] = currentRecord.ZoneGroupId;

	resultString = getRegexMatch(regexGroup, regexParams);

	if (!isValidRegexMatchResult(resultString)) {

	    recordError = new RecordError("ERR_UA_TRANS_LOOKUP", ErrorType.SPECIAL, getSymbolicName());
	    currentRecord.addError(recordError);

	} else {

	    String[] regexResults = resultString.split(":", -1);

	    currentRecord.AccountGroupId = regexResults[1];
	    currentRecord.SubsGroupId = regexResults[2];
	    currentRecord.MarketGroupId = regexResults[3];
	    currentRecord.AccessMethodGroupId = regexResults[4];
	    currentRecord.SpecialFeatureGroupId = regexResults[5];
	    currentRecord.OfflineGroupId = regexResults[6];

	}

	return r;
    }

    @Override
    public IRecord procErrorRecord(IRecord r) throws ProcessingException {
	return r;
    }

}
