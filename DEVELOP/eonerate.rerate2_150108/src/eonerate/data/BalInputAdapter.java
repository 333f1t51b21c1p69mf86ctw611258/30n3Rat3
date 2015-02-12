/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package eonerate.data;

import eonerate.entity.RatRec;
import ElcRate.adapter.file.FlatFileInputAdapter;
import ElcRate.exception.ProcessingException;
import ElcRate.record.IRecord;

/**
 * @class BalInputAdapter.java
 * @time Created on Nov 10, 2013, 11:49:49 AM
 * @author hinhnd
 */
public class BalInputAdapter extends FlatFileInputAdapter {

    RatRec tmpDataRecord = null;

    public BalInputAdapter() {
        super();
    }

    @Override
    public IRecord procHeader(IRecord r) throws ProcessingException {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public IRecord procValidRecord(IRecord r) throws ProcessingException {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public IRecord procErrorRecord(IRecord r) throws ProcessingException {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public IRecord procTrailer(IRecord r) throws ProcessingException {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

}
