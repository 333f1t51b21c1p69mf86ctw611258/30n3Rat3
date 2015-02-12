/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package eonerate.data;

import eonerate.entity.RatRec;
import ElcRate.adapter.jdbc.JDBCOutputAdapter;
import ElcRate.logging.ILogger;
import ElcRate.logging.LogUtil;
import ElcRate.record.DBRecord;
import ElcRate.record.IError;
import ElcRate.record.IRecord;
import ElcRate.record.RecordError;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;

/**
 * @class DBOutput.java
 * @time Created on Nov 3, 2013, 2:21:39 PM
 * @author hinhnd
 */
public class DBOutput extends JDBCOutputAdapter {

	ILogger LOG_PROCESSING = LogUtil.getLogUtil().getLogger("Processing");

	SimpleDateFormat sdfInput = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");

	/**
	 * Creates a new instance of DBOutput
	 */
	public DBOutput() {
		super();
	}

	@Override
	public Collection<IRecord> procValidRecord(IRecord r) {
		RatRec tmpInRecord;
		DBRecord tmpDataRecord;
		Collection<IRecord> Outbatch;

		Outbatch = new ArrayList<IRecord>();

		tmpInRecord = (RatRec) r;
		tmpDataRecord = new DBRecord();

		tmpDataRecord.setOutputColumnCount(33);
		tmpDataRecord.setOutputColumnString(0, tmpInRecord.NumberA);
		tmpDataRecord.setOutputColumnInt(1, Integer.parseInt(tmpInRecord.cdrType));
		//        tmpDataRecord.setOutputColumnString(2, sdfInput.format(tmpInRecord.CreateTime));
		//        tmpDataRecord.setOutputColumnString(2, sdfInput.format(tmpInRecord.CDRNativeDate));
		tmpDataRecord.setOutputColumnString(2, sdfInput.format(tmpInRecord.EventStartDate));
		tmpDataRecord.setOutputColumnDouble(3, tmpInRecord.duration);
		tmpDataRecord.setOutputColumnDouble(4, tmpInRecord.totalUsage);
		tmpDataRecord.setOutputColumnString(5, tmpInRecord.NumberB);
		tmpDataRecord.setOutputColumnString(6, tmpInRecord.ZoneB);
		tmpDataRecord.setOutputColumnString(7, tmpInRecord.NWGroup);
		tmpDataRecord.setOutputColumnDouble(8, tmpInRecord.ServiceFee);
		tmpDataRecord.setOutputColumnInt(9, tmpInRecord.ServiceFeeId);
		tmpDataRecord.setOutputColumnDouble(10, tmpInRecord.ChargeFee);
		tmpDataRecord.setOutputColumnInt(11, tmpInRecord.ChargeFeeId);
		tmpDataRecord.setOutputColumnString(12, tmpInRecord.Lac);
		tmpDataRecord.setOutputColumnString(13, tmpInRecord.CellId);
		tmpDataRecord.setOutputColumnString(14, tmpInRecord.SubscriberUnbill);
		tmpDataRecord.setOutputColumnString(15, tmpInRecord.BuId);
		tmpDataRecord.setOutputColumnString(16, tmpInRecord.OldBuId);
		tmpDataRecord.setOutputColumnDouble(17, tmpInRecord.OfferCost);
		tmpDataRecord.setOutputColumnDouble(18, tmpInRecord.OfferFreeBlock);
		tmpDataRecord.setOutputColumnDouble(19, tmpInRecord.InternalCost);
		tmpDataRecord.setOutputColumnDouble(20, tmpInRecord.InternalFreeBlock);
		tmpDataRecord.setOutputColumnString(21, tmpInRecord.DialDigit);
		tmpDataRecord.setOutputColumnLong(22, tmpInRecord.CdrHeaderRecordId);
		tmpDataRecord.setOutputColumnLong(23, tmpInRecord.CdrSeqNum);
		tmpDataRecord.setOutputColumnString(24, tmpInRecord.LocationNo);
		tmpDataRecord.setOutputColumnInt(25, 5); // SUCCESSFUL
		tmpDataRecord.setOutputColumnInt(26, Integer.valueOf(tmpInRecord.uaId));
		//        tmpDataRecord.setOutputColumnInt(26, (int) tmpInRecord.PaymentItemId);
		tmpDataRecord.setOutputColumnString(27, tmpInRecord.MscId);
		//tmpDataRecord.setOutputColumnString(30, tmpInRecord.Error_Message);
		tmpDataRecord.setOutputColumnInt(28, tmpInRecord.unitTypeId);
		tmpDataRecord.setOutputColumnInt(29, Integer.valueOf(tmpInRecord.tpId));
		tmpDataRecord.setOutputColumnString(30, tmpInRecord.ErrorMessage);
		tmpDataRecord.setOutputColumnInt(31, tmpInRecord.MapId);
		tmpDataRecord.setOutputColumnInt(32, tmpInRecord.dataPart);

		Outbatch.add((IRecord) tmpDataRecord);
		return Outbatch;

	}

	@Override
	public Collection<IRecord> procErrorRecord(IRecord r) {

		RatRec tmpInRecord;
		DBRecord tmpDataRecord;
		String errMessage = null;

		Collection<IRecord> Outbatch;
		Outbatch = new ArrayList<IRecord>();
		tmpInRecord = (RatRec) r;
		//For debug

		Collection<IError> errors = tmpInRecord.getErrors();
		Iterator<IError> iError = errors.iterator();
		while (iError.hasNext()) {
			RecordError tmpErr = (RecordError) iError.next();
			errMessage = tmpErr.getType() + " -> " + tmpErr.getMessage();
		}
		tmpInRecord.ErrorMessage = errMessage;

		tmpDataRecord = new DBRecord();

		tmpDataRecord.setOutputColumnCount(33);
		tmpDataRecord.setOutputColumnString(0, tmpInRecord.NumberA);
		tmpDataRecord.setOutputColumnInt(1, Integer.parseInt(tmpInRecord.cdrType));
		//	tmpDataRecord.setOutputColumnString(2, sdfInput.format(tmpInRecord.CreateTime));
		//        tmpDataRecord.setOutputColumnString(2, sdfInput.format(tmpInRecord.CDRNativeDate));
		tmpDataRecord.setOutputColumnString(2, sdfInput.format(tmpInRecord.EventStartDate));
		tmpDataRecord.setOutputColumnDouble(3, tmpInRecord.duration);
		tmpDataRecord.setOutputColumnDouble(4, tmpInRecord.totalUsage);
		tmpDataRecord.setOutputColumnString(5, tmpInRecord.NumberB);
		tmpDataRecord.setOutputColumnString(6, tmpInRecord.ZoneB);
		tmpDataRecord.setOutputColumnString(7, tmpInRecord.NWGroup);
		tmpDataRecord.setOutputColumnDouble(8, tmpInRecord.ServiceFee);
		tmpDataRecord.setOutputColumnInt(9, tmpInRecord.ServiceFeeId);
		tmpDataRecord.setOutputColumnDouble(10, tmpInRecord.ChargeFee);
		tmpDataRecord.setOutputColumnInt(11, tmpInRecord.ChargeFeeId);
		tmpDataRecord.setOutputColumnString(12, tmpInRecord.Lac);
		tmpDataRecord.setOutputColumnString(13, tmpInRecord.CellId);
		tmpDataRecord.setOutputColumnString(14, tmpInRecord.SubscriberUnbill);
		tmpDataRecord.setOutputColumnString(15, tmpInRecord.BuId);
		tmpDataRecord.setOutputColumnString(16, tmpInRecord.OldBuId);
		tmpDataRecord.setOutputColumnDouble(17, tmpInRecord.OfferCost);
		tmpDataRecord.setOutputColumnDouble(18, tmpInRecord.OfferFreeBlock);
		tmpDataRecord.setOutputColumnDouble(19, tmpInRecord.InternalCost);
		tmpDataRecord.setOutputColumnDouble(20, tmpInRecord.InternalFreeBlock);
		tmpDataRecord.setOutputColumnString(21, tmpInRecord.DialDigit);
		tmpDataRecord.setOutputColumnLong(22, tmpInRecord.CdrHeaderRecordId);
		tmpDataRecord.setOutputColumnLong(23, tmpInRecord.CdrSeqNum);
		tmpDataRecord.setOutputColumnString(24, tmpInRecord.LocationNo);
		tmpDataRecord.setOutputColumnInt(25, 4); // F
		tmpDataRecord.setOutputColumnInt(26, Integer.valueOf(tmpInRecord.uaId));
		//        tmpDataRecord.setOutputColumnInt(26, (int) tmpInRecord.PaymentItemId);
		tmpDataRecord.setOutputColumnString(27, tmpInRecord.MscId);
		//tmpDataRecord.setOutputColumnString(30, tmpInRecord.Error_Message);
		tmpDataRecord.setOutputColumnInt(28, tmpInRecord.unitTypeId);
		tmpDataRecord.setOutputColumnInt(29, Integer.valueOf(tmpInRecord.tpId));
		tmpDataRecord.setOutputColumnString(30, tmpInRecord.ErrorMessage);
		tmpDataRecord.setOutputColumnInt(31, tmpInRecord.MapId);
		tmpDataRecord.setOutputColumnInt(32, tmpInRecord.dataPart);

		Outbatch.add((IRecord) tmpDataRecord);

		return Outbatch;
	}
}
