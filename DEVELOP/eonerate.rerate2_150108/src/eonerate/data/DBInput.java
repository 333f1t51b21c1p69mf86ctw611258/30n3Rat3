/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package eonerate.data;

import eonerate.entity.RatRec;
import ElcRate.adapter.jdbc.JDBCInputAdapter;
import ElcRate.record.DBRecord;
import ElcRate.record.IRecord;

/**
 * @class DBInput.java
 * @time Created on Nov 3, 2013, 2:06:11 PM
 * @author hinhnd
 */
public class DBInput extends JDBCInputAdapter {

	// This is the stream record number counter which tells us the number of
	// the compressed records
	private int StreamRecordNumber;
	// This is the object that is used to compress the records
	RatRec tmpDataRecord = null;

	public DBInput() {
		//Nothing
	}

	@Override
	public IRecord procHeader(IRecord r) {
		StreamRecordNumber = 0;
		return r;
	}

	@Override
	public IRecord procValidRecord(IRecord r) {
		String recordType;

		DBRecord originalRecord = (DBRecord) r;
		tmpDataRecord = new RatRec(originalRecord.getOriginalColumns());
		recordType = tmpDataRecord.getField(RatRec.IDX_CDR_TYPE);

		// Map the VNP detail record
		if (recordType.startsWith(RatRec.CDR_TYPE_VOICE)
				|| recordType.startsWith(RatRec.CDR_TYPE_SMS)
				|| recordType.startsWith(RatRec.CDR_TYPE_DATA)
				|| recordType.startsWith(RatRec.CDR_TYPE_MMS)) {

			tmpDataRecord.mapVNPRecord(recordType);

			// Return the created record
			StreamRecordNumber++;
			tmpDataRecord.RecordNumber = StreamRecordNumber;

			return tmpDataRecord;

		}
		return null;
	}

	@Override
	public IRecord procErrorRecord(IRecord r) {
		return r;
	}

	@Override
	public IRecord procTrailer(IRecord r) {
		/*TrailerRecord tmpTrailer;

		// set the trailer record count
		tmpTrailer = (TrailerRecord) r;
		tmpTrailer.setRecordCount(StreamRecordNumber);

		return (IRecord) tmpTrailer;*/
		return r;
	}
}
