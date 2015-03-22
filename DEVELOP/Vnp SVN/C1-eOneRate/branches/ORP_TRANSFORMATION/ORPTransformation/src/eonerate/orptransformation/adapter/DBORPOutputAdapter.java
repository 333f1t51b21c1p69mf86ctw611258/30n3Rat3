/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package eonerate.orptransformation.adapter;

import ElcRate.adapter.jdbc.JDBCOutputAdapter;
import ElcRate.exception.ProcessingException;
import ElcRate.record.DBRecord;
import ElcRate.record.HeaderRecord;
import ElcRate.record.IRecord;
import java.util.ArrayList;
import java.util.Collection;

/**
 *
 * @author TayDo
 */
public class DBORPOutputAdapter extends JDBCOutputAdapter {

    public DBORPOutputAdapter() {
        super();
    }
    
    @Override
    public Collection<IRecord> procValidRecord(IRecord ir) {
        return null;
    }

    @Override
    public Collection<IRecord> procErrorRecord(IRecord r)
    {
      return null;
    }
    
    @Override
    public IRecord procHeader(IRecord r){
        HeaderRecord tmpHeader;
        DBRecord tmpDataRecord;
        ArrayList<IRecord> Outbatch = new ArrayList<IRecord>();
        
        tmpHeader = (HeaderRecord) r;
        tmpDataRecord = new DBRecord();
        
        tmpHeader = new HeaderRecord();
        
        tmpDataRecord.setOutputColumnCount(1);
        tmpDataRecord.setOutputColumnString(0,tmpHeader.getStreamName());
        try{
            super.procHeader((IRecord)tmpDataRecord);
        }catch (ProcessingException ex){
            return null;
        }
        return (IRecord)tmpDataRecord;
    }
    
}
