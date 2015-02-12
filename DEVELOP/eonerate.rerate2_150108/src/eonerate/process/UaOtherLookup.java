/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package eonerate.process;

import ElcRate.exception.ProcessingException;
import ElcRate.logging.ILogger;
import ElcRate.logging.LogUtil;
import ElcRate.process.AbstractRegexMatch;
import ElcRate.record.ErrorType;
import ElcRate.record.IRecord;
import ElcRate.record.RecordError;
import eonerate.entity.RatRec;

/**
 *
 * @author manucian86
 */
public class UaOtherLookup extends AbstractRegexMatch {

    ILogger LOG_PROCESSING = LogUtil.getLogUtil().getLogger("Processing");

    @Override
    public IRecord procValidRecord(IRecord r) throws ProcessingException {

        String logString = null;
        RecordError recordError;
        RatRec currentRecord = (RatRec) r;

        if (currentRecord.cdrType.equalsIgnoreCase(RatRec.CDR_TYPE_DATA)) {
            //to do nothing
            return r;
        }

        String regexGroup = currentRecord.rvId.toString();

        String[] tmpSearchParameters = new String[1];

        tmpSearchParameters[0] = currentRecord.UAInitialId;

        String regexResult = getRegexMatch(regexGroup, tmpSearchParameters);

        if (regexResult.equals("NOMATCH")) {
            recordError = new RecordError("ERR_USAGE_ACTIVITY_OTHER_NOT_FOUND", ErrorType.SPECIAL);
            currentRecord.addError(recordError);
        } else {
            currentRecord.uaId = regexResult;
        }

        return r;
    }

    @Override
    public IRecord procErrorRecord(IRecord r) throws ProcessingException {

        return r;

    }

}
