/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package eonerate.data;

import ElcRate.adapter.jdbc.JDBCOutputAdapter;
import ElcRate.record.DBRecord;
import ElcRate.record.FlatRecord;
import ElcRate.record.IRecord;
import java.util.ArrayList;
import java.util.Collection;

/**
 * @class BalDBOutput.java
 * @time Created on Nov 17, 2013, 5:44:10 PM
 * @author hinhnd
 */
public class BalDBOutput extends JDBCOutputAdapter {

    public BalDBOutput() {
	super();
    }

    @Override
    public Collection<IRecord> procValidRecord(IRecord r) {
	String[] Fields;
	DBRecord tmpDataRecord;
	FlatRecord tmpInRecord = null;

	Collection<IRecord> Outbatch;
	Outbatch = new ArrayList<IRecord>();

	// we have to make a conversion from the flat record to our format
	// which allows the flat file input adapter to do its work without us
	// having to know too much about it.
	tmpInRecord = (FlatRecord) r;
	Fields = tmpInRecord.getData().split(";");
	tmpDataRecord = new DBRecord();
	tmpDataRecord.setOutputColumnCount(6);
	tmpDataRecord.setOutputColumnString(0, Fields[0]);
	tmpDataRecord.setOutputColumnString(1, Fields[1]);
	tmpDataRecord.setOutputColumnString(2, Fields[2]);
	tmpDataRecord.setOutputColumnString(3, Fields[4]);
	tmpDataRecord.setOutputColumnString(4, Fields[5]);
	tmpDataRecord.setOutputColumnString(5, Fields[3]);

	Outbatch.add(tmpDataRecord);

	return Outbatch;
    }

    @Override
    public Collection<IRecord> procErrorRecord(IRecord r) {
	return null;
    }
}
