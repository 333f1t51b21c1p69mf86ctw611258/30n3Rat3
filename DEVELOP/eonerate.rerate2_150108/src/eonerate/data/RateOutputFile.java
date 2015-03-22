/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package eonerate.data;

import eonerate.entity.RatRec;
import ElcRate.adapter.file.FlatFileOutputAdapter;
import ElcRate.record.FlatRecord;
import ElcRate.record.IRecord;
import java.util.ArrayList;
import java.util.Collection;

/**
 * @class RateOutputFile.java
 * @time Created on Nov 11, 2013, 9:39:36 AM
 * @author hinhnd
 */
public class RateOutputFile extends FlatFileOutputAdapter {

	public RateOutputFile() {
		super();
	}

	@Override
	public int startTransaction(int TransactionNumber) {
		return 0;
	}

	@Override
	public Collection<IRecord> procValidRecord(IRecord r) {
		FlatRecord tmpOutRecord;
		RatRec tmpInRecord;

		Collection<IRecord> Outbatch;
		Outbatch = new ArrayList<IRecord>();

		tmpOutRecord = new FlatRecord();
		tmpInRecord = (RatRec) r;
		tmpOutRecord.setData(tmpInRecord.unmapOriginalData());

		Outbatch.add((IRecord) tmpOutRecord);

		return Outbatch;
	}

	@Override
	public Collection<IRecord> procErrorRecord(IRecord r) {
		FlatRecord tmpOutRecord;
		RatRec tmpInRecord;

		Collection<IRecord> Outbatch;
		Outbatch = new ArrayList<IRecord>();

		tmpOutRecord = new FlatRecord();
		tmpInRecord = (RatRec) r;
		tmpOutRecord.setData(tmpInRecord.unmapOriginalData());

		Outbatch.add(tmpOutRecord);

		return Outbatch;
	}

}
