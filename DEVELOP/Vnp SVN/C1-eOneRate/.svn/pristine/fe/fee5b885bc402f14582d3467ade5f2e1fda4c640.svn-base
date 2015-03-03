/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package eonerate.orptransformation.adapter;

import ElcRate.record.FlatRecord;
import ElcRate.record.IError;
import ElcRate.record.IRecord;
import ElcRate.record.RecordError;
import eonerate.orptransformation.ORPRecords.OrpRecord;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;

public class FileORPOutputAdapter extends MyFlatFileOutputAdapter
{

    public FileORPOutputAdapter()
    {
        super();

    }

    @Override
    public Collection<IRecord> procValidRecord(IRecord r)
    {
        FlatRecord tmpOutRecord;
        OrpRecord tmpInRecord;
        
        Collection<IRecord> Outbatch;
        Outbatch = new ArrayList<IRecord>();

        tmpOutRecord = new FlatRecord();
        tmpInRecord = (OrpRecord) r;
        tmpOutRecord.setData(tmpInRecord.unmapORPData(startCdrSeq + recordCount));

        Outbatch.add((IRecord) tmpOutRecord);

        return Outbatch;
    }

    @Override
    public Collection<IRecord> procErrorRecord(IRecord r)
    {
        FlatRecord tmpOutRecord;
        OrpRecord tmpInRecord;
        String errMessage="";

        Collection<IRecord> Outbatch;
        Outbatch = new ArrayList<IRecord>();

        tmpOutRecord = new FlatRecord();
        tmpInRecord = (OrpRecord) r;
        
        Collection<IError> errors = tmpInRecord.getErrors();
        Iterator<IError> iError = errors.iterator();
        while (iError.hasNext()) {
            RecordError tmpErr = (RecordError) iError.next();
            errMessage = tmpErr.getType() + " -> " + tmpErr.getMessage();
        }
        
        tmpOutRecord.setData(tmpInRecord.unmapOriginalData()+", -"+errMessage);

        Outbatch.add(tmpOutRecord);

        return Outbatch;
    }

}
