/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package eonerate.data;

import ElcRate.adapter.jdbc.JDBCInputAdapter;
import ElcRate.exception.ProcessingException;
import ElcRate.record.DBRecord;
import ElcRate.record.IRecord;
import eonerate.entity.RemoteRecord;

/**
 *
 * @author manucian86
 */
public class RemoteDBInput extends JDBCInputAdapter {

    @Override
    public IRecord procHeader(IRecord r) throws ProcessingException {
        return r;
    }

    @Override
    public IRecord procValidRecord(IRecord r) throws ProcessingException {
        DBRecord originalRecord = (DBRecord) r;

        RemoteRecord tmpDataRecord = new RemoteRecord(originalRecord.getOriginalColumns());
        tmpDataRecord.mapRemoteRecord();

        return tmpDataRecord;
    }

    @Override
    public IRecord procErrorRecord(IRecord r) throws ProcessingException {
        return r;
    }

    @Override
    public IRecord procTrailer(IRecord r) throws ProcessingException {
        return r;
    }

}
