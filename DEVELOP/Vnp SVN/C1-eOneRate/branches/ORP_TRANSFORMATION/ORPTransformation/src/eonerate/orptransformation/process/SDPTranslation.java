/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package eonerate.orptransformation.process;

import ElcRate.process.AbstractRegexMatch;
import ElcRate.record.ErrorType;
import ElcRate.record.IRecord;
import ElcRate.record.RecordError;
import eonerate.orptransformation.ORPRecords.OrpRecord;



public class SDPTranslation extends AbstractRegexMatch {
    
    String[] tmpSearchParameters = new String[2];
    
    @Override
    public IRecord procValidRecord(IRecord r) {
        String RegexGroup;
        String RegexResult;
        OrpRecord CurrentRecord;
        RecordError tmpError;

       
        CurrentRecord = (OrpRecord) r;
        if (CurrentRecord.RECORD_TYPE == OrpRecord.SDP)
        {
        RegexGroup = "DEF";
        tmpSearchParameters[0] = CurrentRecord.SDPProductID;
        tmpSearchParameters[1] = CurrentRecord.SDPSPID;
        
        RegexResult = getRegexMatch(RegexGroup, tmpSearchParameters);
        
        if (isValidRegexMatchResult(RegexResult)) { 
           CurrentRecord.DialedDigit=RegexResult;
        }
        else 
        {
        CurrentRecord.addError(new RecordError("SDP LOOK UP FAILED", ErrorType.LOOKUP_FAILED, getSymbolicName()));

        }
        }

        return r;
    }

    @Override
    public IRecord procErrorRecord(IRecord r) {
        return r;
    }
    
}
