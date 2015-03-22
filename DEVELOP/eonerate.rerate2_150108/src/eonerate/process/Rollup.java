/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package eonerate.process;

import ElcRate.logging.ILogger;
import ElcRate.logging.LogUtil;
import ElcRate.process.AbstractStubPlugIn;
import ElcRate.record.IRecord;
import eonerate.entity.RatRec;

/**
 * @class Rollup.java
 * @time Created on Mar 4, 2014, 4:35:02 PM
 * @author Admin
 */
public class Rollup extends AbstractStubPlugIn {

	ILogger LOG_PROCESSING = LogUtil.getLogUtil().getLogger("Processing");

	@Override
	public IRecord procValidRecord(IRecord r) {

		RatRec currentRecord;
		currentRecord = (RatRec) r;

		if (currentRecord.ServiceFeeId == 0) {
			currentRecord.ChargeFee = currentRecord.ratedAmount;
			LOG_PROCESSING.debug(currentRecord.concatHeader(0, String.format("SvFeId == 0 => ChargFe=%f", currentRecord.ChargeFee)));
		} else {
			currentRecord.ServiceFee = currentRecord.ratedAmount;
			LOG_PROCESSING.debug(currentRecord.concatHeader(0, String.format("SvFeId == 0 => SvFe=%f", currentRecord.ServiceFee)));
		}
		return r;
	}

	@Override
	public IRecord procErrorRecord(IRecord r) {
		return r;
	}

}
