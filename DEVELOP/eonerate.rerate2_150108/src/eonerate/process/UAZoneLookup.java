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
public class UAZoneLookup extends AbstractRegexMatch{

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
        

//        tmpSearchParameters[0] = CurrentRecord.ZoneA;
//        tmpSearchParameters[1] = CurrentRecord.ZoneB;
        String regexGroup = currentRecord.rvId.toString();
        
        String[] tmpSearchParameters = new String[2];

        tmpSearchParameters[0] = currentRecord.unitTypeId.toString();
        tmpSearchParameters[1] = currentRecord.ZoneGroupId;

        String regexResult = getRegexMatch(regexGroup, tmpSearchParameters);

        if (regexResult.equals("NOMATCH")) {
            recordError = new RecordError("ERR_USAGE_ACTIVITY_ZONE_NOT_FOUND", ErrorType.SPECIAL);
            currentRecord.addError(recordError);
        } else {
            String[] regexResults = regexResult.split(":");

            currentRecord.uaId = regexResults[0];
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
