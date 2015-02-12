/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package eonerate.data;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;

import ElcRate.adapter.jdbc.JDBCOutputAdapter;
import ElcRate.record.DBRecord;
import ElcRate.record.IRecord;
import eonerate.entity.CdrRecord;

/**
 * @class CDROutputAdapter.java
 * @time Created on Nov 16, 2013, 1:31:41 PM
 * @author Admin
 */
public class CdrOutputAdapter extends JDBCOutputAdapter{

    SimpleDateFormat sdfInput = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");

    /** Creates a new instance of DBOutput */
    public CdrOutputAdapter() {
        super();
    }

    @Override
    public Collection<IRecord> procValidRecord(IRecord r) {
       
        CdrRecord tmpInRecord;
        DBRecord tmpDataRecord;
        Collection<IRecord> Outbatch;

        Outbatch = new ArrayList<IRecord>();

        tmpInRecord = (CdrRecord) r;
        tmpDataRecord = new DBRecord();

        tmpDataRecord.setOutputColumnCount(31);
        tmpDataRecord.setOutputColumnString(0, tmpInRecord.ANumber);
        tmpDataRecord.setOutputColumnInt(1, (int)tmpInRecord.CdrType);
        tmpDataRecord.setOutputColumnString(2, sdfInput.format(tmpInRecord.CreatedTime));
        tmpDataRecord.setOutputColumnString(3, sdfInput.format(tmpInRecord.CdrStartTime));
        tmpDataRecord.setOutputColumnLong(4, tmpInRecord.Duration);
        tmpDataRecord.setOutputColumnLong(5, tmpInRecord.TotalUsage);
        tmpDataRecord.setOutputColumnString(6, tmpInRecord.BNumber);
        tmpDataRecord.setOutputColumnString(7, tmpInRecord.BZone);
        tmpDataRecord.setOutputColumnString(8, tmpInRecord.NwGroup);
        tmpDataRecord.setOutputColumnDouble(9, tmpInRecord.ServiceFee);
        tmpDataRecord.setOutputColumnInt(10, tmpInRecord.ServiceFeeId);
        tmpDataRecord.setOutputColumnDouble(11, tmpInRecord.ChargeFee);
        tmpDataRecord.setOutputColumnInt(12, tmpInRecord.ChargeFeeId);
        tmpDataRecord.setOutputColumnString(13, tmpInRecord.Lac);
        tmpDataRecord.setOutputColumnString(14,tmpInRecord.CellId);
        tmpDataRecord.setOutputColumnString(15, tmpInRecord.SubscriberUnbill);
        tmpDataRecord.setOutputColumnInt(16, (int)tmpInRecord.BuId);
        tmpDataRecord.setOutputColumnInt(17, (int)tmpInRecord.OldBuId);
        tmpDataRecord.setOutputColumnDouble(18, tmpInRecord.OfferCost);
        tmpDataRecord.setOutputColumnLong(19, tmpInRecord.OfferFreeBlock);
        tmpDataRecord.setOutputColumnDouble(20, tmpInRecord.InternalCost);
        tmpDataRecord.setOutputColumnLong(21, tmpInRecord.InternalFreeBlock);
        tmpDataRecord.setOutputColumnString(22, tmpInRecord.DialDigit);
        tmpDataRecord.setOutputColumnLong(23, tmpInRecord.CdrRecordHeaderId);
        tmpDataRecord.setOutputColumnLong(24, tmpInRecord.CdrSequenceNumber);
        tmpDataRecord.setOutputColumnString(25, tmpInRecord.LocationNo);
        tmpDataRecord.setOutputColumnInt(26, (int)tmpInRecord.RerateFlag);
        tmpDataRecord.setOutputColumnInt(27, (int)tmpInRecord.CallTypeId);
        tmpDataRecord.setOutputColumnInt(28, (int) tmpInRecord.PaymentItemId);
        tmpDataRecord.setOutputColumnString(29, tmpInRecord.MscId);
        tmpDataRecord.setOutputColumnString(30, tmpInRecord.ErrorMessage);
        

        Outbatch.add((IRecord) tmpDataRecord);
        return Outbatch;

    }

    @Override
    public Collection<IRecord> procErrorRecord(IRecord r) {
        CdrRecord tmpInRecord;
        DBRecord tmpDataRecord;
        String err_message="";

        Collection<IRecord> Outbatch;
        Outbatch = new ArrayList<IRecord>();
        tmpInRecord = (CdrRecord) r;

        tmpDataRecord = new DBRecord();
        tmpDataRecord.setOutputColumnCount(31);
        tmpDataRecord.setOutputColumnString(0, tmpInRecord.ANumber);
        tmpDataRecord.setOutputColumnInt(1, (int)tmpInRecord.CdrType);
        tmpDataRecord.setOutputColumnString(2, sdfInput.format(tmpInRecord.CreatedTime));
        tmpDataRecord.setOutputColumnString(3, sdfInput.format(tmpInRecord.CdrStartTime));
        tmpDataRecord.setOutputColumnLong(4, tmpInRecord.Duration);
        tmpDataRecord.setOutputColumnLong(5, tmpInRecord.TotalUsage);
        tmpDataRecord.setOutputColumnString(6, tmpInRecord.BNumber);
        tmpDataRecord.setOutputColumnString(7, tmpInRecord.BZone);
        tmpDataRecord.setOutputColumnString(8, tmpInRecord.NwGroup);
        tmpDataRecord.setOutputColumnDouble(9, tmpInRecord.ServiceFee);
        tmpDataRecord.setOutputColumnInt(10, tmpInRecord.ServiceFeeId);
        tmpDataRecord.setOutputColumnDouble(11, tmpInRecord.ChargeFee);
        tmpDataRecord.setOutputColumnInt(12, tmpInRecord.ChargeFeeId);
        tmpDataRecord.setOutputColumnString(13, tmpInRecord.Lac);
        tmpDataRecord.setOutputColumnString(14,tmpInRecord.CellId);
        tmpDataRecord.setOutputColumnString(15, tmpInRecord.SubscriberUnbill);
        tmpDataRecord.setOutputColumnInt(16, (int)tmpInRecord.BuId);
        tmpDataRecord.setOutputColumnInt(17, (int)tmpInRecord.OldBuId);
        tmpDataRecord.setOutputColumnDouble(18, tmpInRecord.OfferCost);
        tmpDataRecord.setOutputColumnLong(19, tmpInRecord.OfferFreeBlock);
        tmpDataRecord.setOutputColumnDouble(20, tmpInRecord.InternalCost);
        tmpDataRecord.setOutputColumnLong(21, tmpInRecord.InternalFreeBlock);
        tmpDataRecord.setOutputColumnString(22, tmpInRecord.DialDigit);
        tmpDataRecord.setOutputColumnLong(23, tmpInRecord.CdrRecordHeaderId);
        tmpDataRecord.setOutputColumnLong(24, tmpInRecord.CdrSequenceNumber);
        tmpDataRecord.setOutputColumnString(25, tmpInRecord.LocationNo);
        tmpDataRecord.setOutputColumnInt(26, (int)tmpInRecord.RerateFlag);
        tmpDataRecord.setOutputColumnInt(27, (int)tmpInRecord.CallTypeId);
        tmpDataRecord.setOutputColumnInt(28, (int) tmpInRecord.PaymentItemId);
        tmpDataRecord.setOutputColumnString(29, tmpInRecord.MscId);
        tmpDataRecord.setOutputColumnString(30, tmpInRecord.ErrorMessage);

        Outbatch.add((IRecord) tmpDataRecord);

        return Outbatch;
    }

}
