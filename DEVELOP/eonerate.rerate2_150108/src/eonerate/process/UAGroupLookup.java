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

public class UAGroupLookup extends ElcRate.process.AbstractRegexMatch {

	ILogger LOG_PROCESSING = LogUtil.getLogUtil().getLogger("Processing");

	@Override
	public IRecord procValidRecord(IRecord r) throws ProcessingException {
		RatRec currentRecord = (RatRec) r;

		RecordError tmpError;
		String resultString;
		String regexGroup = null;

		String[] regexParams = new String[1];

		regexParams[0] = currentRecord.uaId;

		regexGroup = currentRecord.rvId.toString();

		resultString = getRegexMatch(regexGroup, regexParams);

		if (!isValidRegexMatchResult(resultString)) {

			tmpError = new RecordError(
					"ERR_UA_GROUP_LOOKUP",
					ErrorType.DATA_NOT_FOUND,
					getSymbolicName());

			currentRecord.addError(tmpError);

			LOG_PROCESSING.error(currentRecord.concatHeader(0, "ERROR: UAGrp isn't found"));

		} else {

			currentRecord.uaGroupId = resultString;

			LOG_PROCESSING.debug(currentRecord.concatHeader(0, "UAGroupId: " + currentRecord.uaGroupId));

		}

		return r;
	}

	@Override
	public IRecord procErrorRecord(IRecord r) throws ProcessingException {
		return r;
	}

}
