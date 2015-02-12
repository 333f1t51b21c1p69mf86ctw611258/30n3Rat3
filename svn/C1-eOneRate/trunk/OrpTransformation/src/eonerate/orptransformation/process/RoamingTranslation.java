/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package eonerate.orptransformation.process;

import ElcRate.exception.ProcessingException;
import ElcRate.process.AbstractRegexMatch;
import ElcRate.record.ErrorType;
import ElcRate.record.IRecord;
import ElcRate.record.RecordError;
import eonerate.orptransformation.ORPRecords.OrpRecord;
import java.util.ArrayList;

public class RoamingTranslation extends AbstractRegexMatch {

    String[] tmpSearchParameters = new String[1];

    @Override
    public IRecord procValidRecord(IRecord r) {
        String RegexGroup = null;
        String RegexResult;
        OrpRecord CurrentRecord;
        RecordError tmpError;

        CurrentRecord = (OrpRecord) r;
        if (CurrentRecord.RECORD_TYPE == OrpRecord.TAP_SMSMO || CurrentRecord.RECORD_TYPE == OrpRecord.TAP_MOC_QTE
                || CurrentRecord.RECORD_TYPE == OrpRecord.TAP_MOC_TNC || CurrentRecord.RECORD_TYPE == OrpRecord.TAP_MTC) {
            RegexGroup = "DEF";
            tmpSearchParameters[0] = CurrentRecord.PartnerCode;

            RegexResult = getRegexMatch(RegexGroup, tmpSearchParameters);

            if (isValidRegexMatchResult(RegexResult)) {
                String[] tmpstr = RegexResult.split("\\.");
                CurrentRecord.MSCID = tmpstr[0];
                CurrentRecord.CellID = tmpstr[1];
            }
            
             else {
                if (CurrentRecord.RECORD_TYPE==OrpRecord.TAP_SMSMO)
                {
                    CurrentRecord.addError(new RecordError("ROAMING SMS LOOKUP FAILED", ErrorType.LOOKUP_FAILED, getSymbolicName()));
                }
                else
                {
                    CurrentRecord.addError(new RecordError("ROAMING VOICE LOOKUP FAILED", ErrorType.LOOKUP_FAILED, getSymbolicName()));
                }
            }
        } else if (CurrentRecord.RECORD_TYPE == OrpRecord.TAP_GPRS) {
            RegexGroup = "DEF";
            tmpSearchParameters[0] = CurrentRecord.PartnerCode;

            RegexResult = getRegexMatch(RegexGroup, tmpSearchParameters);

            //System.out.println(RegexResult);
            if (isValidRegexMatchResult(RegexResult)) {
                String[] tmpstr = RegexResult.split("\\.");
                CurrentRecord.MSCID = tmpstr[0];
                CurrentRecord.SGSN = tmpstr[1];

            } 
            
            else {
                    CurrentRecord.addError(new RecordError("ROAMING_GPRS LOOK UP FAILED", ErrorType.LOOKUP_FAILED, getSymbolicName()));
            }
        }

        return r;
    }

    @Override
    public IRecord procErrorRecord(IRecord r) {
        return r;
    }

}
