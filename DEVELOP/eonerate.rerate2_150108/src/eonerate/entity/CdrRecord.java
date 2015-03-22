/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package eonerate.entity;

import ElcRate.record.ErrorType;
import ElcRate.record.IError;
import ElcRate.record.RatingRecord;
import ElcRate.record.RecordError;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;

/**
 * @class CDRRecord.java
 * @time Created on Nov 16, 2013, 1:49:26 PM
 * @author hinhnd
 */
public class CdrRecord extends RatingRecord {

	//
	private static final String INPUT_DELIMITER = ",";
	private static final int INPUT_FIELD_COUNT = 31; // 17;
	//IDX fields CDR record

	public static final int IDX_A_NUMBER = 0;
	public static final int IDX_CDR_TYPE = 1;
	public static final int IDX_CREATED_TIME = 2;
	public static final int IDX_CDR_START_TIME = 3;
	public static final int IDX_DURATION = 4;
	public static final int IDX_TOTAL_USAGE = 5;
	public static final int IDX_B_NUMBER = 6;
	public static final int IDX_B_ZONE = 7;
	public static final int IDX_NW_GROUP = 8;
	public static final int IDX_SERVICE_FEE = 9;
	public static final int IDX_SERVICE_FEE_ID = 10;
	public static final int IDX_CHARGE_FEE = 11;
	public static final int IDX_CHARGE_FEE_ID = 12;
	public static final int IDX_LAC = 13;
	public static final int IDX_CELL_ID = 14;
	public static final int IDX_SUBSCRIBER_UNBILL = 15;
	public static final int IDX_BU_ID = 16;
	public static final int IDX_OLD_BU_ID = 17;
	public static final int IDX_OFFER_COST = 18;
	public static final int IDX_OFFER_FREE_BLOCK = 19;
	public static final int IDX_INTERNAL_COST = 20;
	public static final int IDX_INTERNAL_FREE_BLOCK = 21;
	public static final int IDX_DIAL_DIGIT = 22;
	public static final int IDX_CDR_RECORD_HEADER_ID = 23;
	public static final int IDX_CDR_SEQUENCE_NUMBER = 24;
	public static final int IDX_LOCATION_NO = 25;
	public static final int IDX_RERATE_FLAG = 26;
	public static final int IDX_CALL_TYPE_ID = 27;
	public static final int IDX_PAYMENT_ITEM_ID = 28;
	public static final int IDX_MSC_ID = 29;
	public static final int IDX_ERROR_MESSAGE = 30;
	//
	// Main Fields (New)
	public String ANumber = null;
	public byte CdrType;
	public Date CreatedTime = null;
	public Date CdrStartTime = null;
	public long Duration;
	public long TotalUsage;
	public String BNumber = null;
	public String BZone = null;
	public String NwGroup = null;
	public double ServiceFee;
	public int ServiceFeeId;
	public double ChargeFee;
	public int ChargeFeeId;
	public String Lac = null;
	public String CellId = null;
	public String SubscriberUnbill = null;
	public short BuId;
	public short OldBuId;
	public double OfferCost;
	public long OfferFreeBlock;
	public double InternalCost;
	public long InternalFreeBlock;
	public String DialDigit = null;
	public long CdrRecordHeaderId;
	public long CdrSequenceNumber;
	public String LocationNo = null;
	public byte RerateFlag;
	public byte CallTypeId;
	public short PaymentItemId;
	public String MscId = null;
	public String ErrorMessage = null;

	// Internal Management Fields
	public String GuidingKey = null;
	public Integer CustIDA = null;
	public Integer CustIDB = null;
	public int BalanceGroup = 0;
	public String UsedProduct = null;
	public String SubscriptionID = null;
	public String UsedDiscount = null;
	public String TimeZone = null;
	public String PriceModel = null;
	public boolean CUGFlag = false;
	public String CUGDiscount = null;
	public int CUGBalanceGroup = 0;
	public double CUGDiscAmt = 0;
	public String ProductList = null;
	public String MSN = null;

	public CdrRecord() {
		super();
	}

	public boolean MapMainRecord(String data) {

		this.OriginalData = data;
		this.fields = this.OriginalData.split(INPUT_DELIMITER);
		SimpleDateFormat sdfInput = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss.SSS");

		try {

			this.ANumber = fields[IDX_A_NUMBER];
			this.CdrType = Byte.parseByte(fields[IDX_CDR_TYPE]);
			this.CreatedTime = sdfInput.parse(fields[IDX_CREATED_TIME]);
			this.CdrStartTime = sdfInput.parse(fields[IDX_CDR_START_TIME]);
			this.Duration = Long.parseLong(fields[IDX_DURATION]);
			this.TotalUsage = Long.parseLong(fields[IDX_TOTAL_USAGE]);
			this.BNumber = fields[IDX_B_NUMBER];
			this.BZone = fields[IDX_B_ZONE];
			this.NwGroup = fields[IDX_NW_GROUP];
			this.ServiceFee = Double.parseDouble(fields[IDX_SERVICE_FEE]);
			this.ServiceFeeId = Integer.parseInt(fields[IDX_SERVICE_FEE_ID]);
			this.ChargeFee = Double.parseDouble(fields[IDX_CHARGE_FEE]);
			this.ChargeFeeId = Integer.parseInt(fields[IDX_CHARGE_FEE_ID]);
			this.Lac = fields[IDX_LAC];
			this.CellId = fields[IDX_CELL_ID];
			this.SubscriberUnbill = fields[IDX_SUBSCRIBER_UNBILL];
			this.BuId = Short.parseShort(fields[IDX_BU_ID]);
			this.OldBuId = Short.parseShort(fields[IDX_OLD_BU_ID]);
			this.OfferCost = Double.parseDouble(fields[IDX_OFFER_COST]);
			this.OfferFreeBlock = Long.parseLong(fields[IDX_OFFER_FREE_BLOCK]);
			this.InternalCost = Double.parseDouble(fields[IDX_INTERNAL_COST]);
			this.InternalFreeBlock = Long.parseLong(fields[IDX_INTERNAL_FREE_BLOCK]);
			this.DialDigit = fields[IDX_DIAL_DIGIT];
			this.CdrRecordHeaderId = Long.parseLong(fields[IDX_CDR_RECORD_HEADER_ID]);
			this.CdrSequenceNumber = Long.parseLong(fields[IDX_CDR_SEQUENCE_NUMBER]);
			this.LocationNo = fields[IDX_LOCATION_NO];
			this.RerateFlag = Byte.parseByte(fields[IDX_RERATE_FLAG]);
			this.CallTypeId = Byte.parseByte(fields[IDX_CALL_TYPE_ID]);
			this.PaymentItemId = Short.parseShort(fields[IDX_PAYMENT_ITEM_ID]);
			this.MscId = fields[IDX_MSC_ID];
			this.ErrorMessage = fields[IDX_ERROR_MESSAGE];

		} catch (NumberFormatException nfe) {
			this.addError(new RecordError("ERR_PARSE_RECORD", ErrorType.DATA_VALIDATION, "Error parsing record"));
			return false;
		} catch (ParseException pe) {
			this.addError(new RecordError("ERR_PARSE_RECORD", ErrorType.DATA_VALIDATION, "Error parsing record"));
			return false;
		}

		return true;
	}

	@Override
	public ArrayList<String> getDumpInfo() {
		ArrayList<String> tmpDumpList = null;
		tmpDumpList = new ArrayList<String>();

		// Format the fields
		tmpDumpList.add("============ BEGIN RECORD ============");
		tmpDumpList.add("  Record Number   = <" + this.RecordNumber + ">");
		tmpDumpList.add("  Output Streams  = <" + this.getOutputs() + ">");
		tmpDumpList.add("--------------------------------------");

		Iterator<IError> it = this.getErrors().iterator();
		while (it.hasNext()) {
			IError err = it.next();
			tmpDumpList.add("------------ Begin Error -------------");
			tmpDumpList.add("  Message:     " + err.getMessage());
			tmpDumpList.add("  Set by:      " + err.getModuleName());
			tmpDumpList.add("------------ End Error ---------------");
		}
		return tmpDumpList;

	}

}
