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

public class GPRSTranslation extends AbstractRegexMatch
{

    String[] tmpSearchParameters = new String[2];

    public GPRSTranslation()
    {
        super();
    }

    @Override
    public IRecord procValidRecord(IRecord r)
    {
        String RegexGroup;
        String RegexResult;
        OrpRecord CurrentRecord;

        CurrentRecord = (OrpRecord) r;
        if (CurrentRecord.RECORD_TYPE == OrpRecord.GPRS)
        {
            RegexGroup = "DEF";
            tmpSearchParameters[0] = CurrentRecord.APN;
            tmpSearchParameters[1] = CurrentRecord.QOS;
            RegexResult = getRegexMatch(RegexGroup, tmpSearchParameters);
            if (isValidRegexMatchResult(RegexResult))
            {
                String[] tmpstr = RegexResult.split("\\.");
                CurrentRecord.ApplicationType = tmpstr[0];
                CurrentRecord.Subtype = tmpstr[1];
                CurrentRecord.InitialAUT = tmpstr[2];
            }
            else
            {
                CurrentRecord.addError(new RecordError("GPRS LOOK FAILED", ErrorType.LOOKUP_FAILED, getSymbolicName()));
            }
        }

        return r;
    }

    @Override
    public IRecord procErrorRecord(IRecord r)
    {
        return r;
    }

}
