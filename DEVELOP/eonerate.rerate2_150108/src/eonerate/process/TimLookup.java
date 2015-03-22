/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package eonerate.process;

import ElcRate.exception.ProcessingException;
import ElcRate.logging.ILogger;
import ElcRate.logging.LogUtil;
import ElcRate.process.AbstractRUMTimeMatch;
import ElcRate.record.ChargePacket;
import ElcRate.record.ErrorType;
import ElcRate.record.IRecord;
import ElcRate.record.RecordError;
import eonerate.entity.RatRec;
import java.text.SimpleDateFormat;

/**
 * @class TimeLookup.java
 * @time Created on Nov 7, 2013, 3:06:03 PM
 * @author hinhnd
 */
public class TimLookup extends AbstractRUMTimeMatch {

    ILogger LOG_PROCESSING = LogUtil.getLogUtil().getLogger("Processing");

    @Override
    public IRecord procValidRecord(IRecord r) {

        String logString;
        RatRec currentRecord = (RatRec) r;

        try {
            if (currentRecord.getChargePacketCount() > 0 && currentRecord.getChargePacket(0).timeModel != null) {

                performRUMTimeMatch(currentRecord);

            } else {

                currentRecord.addError(new RecordError("ERR_TIME_LOOKUP", ErrorType.DATA_NOT_FOUND, getSymbolicName()));

            }
        } catch (ProcessingException pe) {

            currentRecord.addError(new RecordError("ERR_TIME_LOOKUP", ErrorType.DATA_NOT_FOUND, getSymbolicName()));

        }

//	logString = getSymbolicName()
//		+ " [A_NUMBER: " + currentRecord.NumberA
//		+ ", EventStartDate: " + currentRecord.EventStartDate
//		+ ", EventEndDate: " + currentRecord.EventEndDate + "]";
//
//	LOG_PROCESSING.debug(logString);
        SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
        LOG_PROCESSING.debug(currentRecord.concatHeader(0, "TimRslts:"));
        for (ChargePacket chargePacket : currentRecord.getChargePackets()) {
            LOG_PROCESSING.debug(currentRecord.concatHeader(1, String.format("%s; %s -> %s", chargePacket.ratePlanName, dateFormat.format(currentRecord.EventStartDate), chargePacket.timeResult)));
        }

        return r;

    }

    @Override
    public IRecord procErrorRecord(IRecord r) {
        return r;
    }

}
