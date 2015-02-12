/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package eonerate.data;

import ElcRate.adapter.file.FlatFileInputAdapter;
import ElcRate.record.FlatRecord;
import ElcRate.record.IRecord;
import eonerate.entity.CdrRecord;

/**
 * @class CdrInputAdapter.java
 * @time Created on Nov 16, 2013, 11:53:52 AM
 * @author hinhnd
 */
public class CdrInputAdapter extends FlatFileInputAdapter {

    private int StreamRecordNumber;
    CdrRecord tempRecord;

    public CdrInputAdapter(){

        super();
    }

    @Override
    public IRecord procHeader(IRecord r) {

        StreamRecordNumber=0;
        return r;
    }

    @Override
    public IRecord procValidRecord(IRecord r) {

        String OriginalData;
        tempRecord=new CdrRecord();

        FlatRecord originalRecord = (FlatRecord) r;
        OriginalData = originalRecord.getData();
        tempRecord.MapMainRecord(OriginalData);
        
        return tempRecord;
    }

    @Override
    public IRecord procErrorRecord(IRecord r){
        return r;
    }

    @Override
    public IRecord procTrailer(IRecord r) {
        
        StreamRecordNumber=0;
        return r;
    }

}
