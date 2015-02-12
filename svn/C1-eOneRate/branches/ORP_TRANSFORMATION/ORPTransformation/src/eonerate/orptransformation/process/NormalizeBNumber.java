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
import java.util.ArrayList;

public class NormalizeBNumber extends AbstractRegexMatch
{
    String[] tmpSearchParameters = new String[1];
    public static final String SPACE="^\\s+$";

    @Override
    public IRecord procValidRecord(IRecord r) {
        RecordError tmpError;
        String RegexGroup;
        OrpRecord CurrentRecord = (OrpRecord) r;
        ArrayList<String> Results;
        
        if (CurrentRecord.DialedDigit==null||("").equals(CurrentRecord.DialedDigit)|| CurrentRecord.DialedDigit.matches(SPACE)){
            return r;
        }
  
        tmpSearchParameters[0] = CurrentRecord.DialedDigit;

        RegexGroup = "Default";

        Results = getRegexMatchWithChildData(RegexGroup, tmpSearchParameters);

        // Check we have some results
        try {
            if ((Results != null) & (Results.size() > 1)) {
                if (!Results.get(0).equalsIgnoreCase("nomatch")) {
                    if (Results.get(0).trim().isEmpty()) {
                        // just add the prefix
                        CurrentRecord.BNumber = Results.get(1) + CurrentRecord.DialedDigit;
                    } else {
                        // remove an old prefix and add the new prefix
                        CurrentRecord.BNumber = CurrentRecord.DialedDigit.replaceAll(Results.get(0), Results.get(1));
                    }
                } else {
                    tmpError = new RecordError("ERR_NORMALISATION_LOOKUP", ErrorType.SPECIAL);
                    CurrentRecord.addError(tmpError);
                }
            } else {
                tmpError = new RecordError("ERR_NORMALISATION_LOOKUP", ErrorType.SPECIAL);
                CurrentRecord.addError(tmpError);
            }
        } catch (Exception e) {
            tmpError = new RecordError("ERR_NORMALISATION_LOOKUP", ErrorType.SPECIAL);
            CurrentRecord.addError(tmpError);
        }
        return r;

    }


    @Override
    public IRecord procErrorRecord(IRecord r)
    {
        return r;
    }

}
