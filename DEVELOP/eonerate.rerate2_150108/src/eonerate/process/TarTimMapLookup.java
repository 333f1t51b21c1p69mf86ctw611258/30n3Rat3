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

public class TarTimMapLookup extends ElcRate.process.AbstractRegexMatch {

    ILogger LOG_PROCESSING = LogUtil.getLogUtil().getLogger("Processing");

    @Override
    public IRecord procValidRecord(IRecord r) throws ProcessingException {
        RatRec currentRecord = (RatRec) r;

        RecordError tmpError;
        String resultString;
        String regexGroup = null;

        String[] regexParams = new String[1];

        regexParams[0] = currentRecord.tpId;

        regexGroup = currentRecord.rvId.toString();

        resultString = getRegexMatch(regexGroup, regexParams);

        if (!isValidRegexMatchResult(resultString)) {

            tmpError = new RecordError(
                    "ERR_TARIFF_TIME_MAP_LOOKUP",
                    ErrorType.DATA_NOT_FOUND,
                    getSymbolicName());

            currentRecord.addError(tmpError);

            LOG_PROCESSING.error(currentRecord.concatHeader(0, "ERROR: Cal isn't found"));

        } else {

            currentRecord.calId = resultString;

            LOG_PROCESSING.debug(currentRecord.concatHeader(0, "CalId: " + currentRecord.calId));

        }

        return r;
    }

    @Override
    public IRecord procErrorRecord(IRecord r) throws ProcessingException {
        return r;
    }

}
