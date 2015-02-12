/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package eonerate.entity;

/**
 * @class RateRecord.java
 * @time Created on Nov 3, 2013, 11:36:05 AM
 * @author hinhnd
 */
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import org.apache.commons.lang.StringUtils;

import ElcRate.logging.ILogger;
import ElcRate.logging.LogUtil;
import ElcRate.record.ChargePacket;
import ElcRate.record.ErrorType;
import ElcRate.record.IError;
import ElcRate.record.RUMInfo;
import ElcRate.record.RatingRecord;
import ElcRate.record.RecordError;

public class RatRec extends RatingRecord {

	/**
	 * 
	 */
	private static final long serialVersionUID = 6078824253145941693L;

	ILogger LOG_PROCESSING = LogUtil.getLogUtil().getLogger("Processing");

	// These are the mappings to the fields for input CDR
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
	public static final int IDX_AUT_FINAL_ID = 27;
	//    public static final int IDX_PAYMENT_ITEM_ID = 28;
	public static final int IDX_MSC_ID = 28;
	public static final int IDX_UNIT_TYPE_ID = 29;
	public static final int IDX_TARIFF_PLAN_ID = 30;
	public static final int IDX_MAP_ID = 31;
	public static final int IDX_DATA_PART = 32;

	//    public static final Random seqRandom = new Random(8668);
	public static int seqNextVal = 0;

	//	/**
	//	 * TEMP_SERVICE For Regex
	//	 *
	//	 * Add by: manucian86
	//	 */
	//	public static final String SERVICE_TEMP = "TEMP_SERVICE";
	//
	// CDR_TYPE
	public static final String CDR_TYPE_VOICE = "1"; // VOICE
	public static final String CDR_TYPE_SMS = "4"; // SMS
	public static final String CDR_TYPE_DATA = "7"; // OSC
	public static final String CDR_TYPE_MMS = "5"; // GPRS
	// UNIT_TYPE_ID
	public static final int UNIT_TYPE_ID_SECONDS = 2;
	public static final int UNIT_TYPE_ID_OCTET = 3;
	public static final int UNIT_TYPE_ID_SMS = 4;
	public static final int UNIT_TYPE_ID_MMS = 5;
	// OFFER_TYPE
	public static final String OFFER_TYPE_PO = "PO"; // VOICE
	public static final String OFFER_TYPE_SO = "SO"; // SMS
	public static final String OFFER_TYPE_AO = "AO"; // OSC
	//
	// RUM_ID
	//    @Deprecated
	//    public static final String RUM_ID_EVT = "EVT";
	public static final String RUM_ID_MONEY = "MONEY";
	public static final String RUM_ID_VOL = "VOL";
	public static final String RUM_ID_DUR = "DUR";
	public static final String RUM_ID_SMS = "SMS";
	public static final String RUM_ID_MMS = "MMS";

	//    @Deprecated
	//    public static final String RUM_ID_MF = "MF";
	//
	//Default product for postpaid subsrciber
	public static final String PROD_DEFAULT = "POSTPAID";

	// 
	public Integer Seq = 0;

	//
	public String NumberA = null;
	public String ZoneA = null;

	//	public String CDR_Type = null;
	public Date CreateTime;
	//    public Date CDRStartTime;
	public double duration = 0;
	public double totalUsage;

	public String NumberB = null;
	public String ZoneB = null;

	public String NWGroup = null;

	//
	public double ServiceFee = 0;
	public int ServiceFeeId;
	public double ChargeFee = 0;
	public int ChargeFeeId;

	//
	public String Lac = null;
	public String CellId = null;

	public String SubscriberUnbill = null;

	//
	public String BuId;
	public String OldBuId;

	//
	public double OfferCost = 0;
	public double OfferFreeBlock = 0;
	public double InternalCost = 0;
	public double InternalFreeBlock = 0;

	public String DialDigit = null;
	public long CdrHeaderRecordId;
	public long CdrSeqNum;
	public String LocationNo = null;
	public int rerateFlag = 0;

	//    public int PaymentItemId;
	public String MscId = null;

	public Integer unitTypeId;

	public String ErrorMessage = null;

	// B Location
	//    @Deprecated
	//    public String ZoneInfo = null;
	//

	// ---
	//    @Deprecated
	//    public int AutFinalId;
	public String uaId;
	public String tpId;

	public String uaGroupId;

	public String calId;

	public String UAInitialId;

	//    public Integer ApplicationId;
	//    public Integer SubTypeId;
	//    public Integer UnitTypeId;
	public String ZoneGroupId;

	public String AccountGroupId;
	public String SubsGroupId;
	public String MarketGroupId;
	public String AccessMethodGroupId;
	public String SpecialFeatureGroupId;
	public String OfflineGroupId;
	// ---

	// ---
	public List<Integer> offIdBs;
	public List<Integer> offIdTs;
	public List<Integer> offIdDs;
	// ---

	// ---
	public List<BalanceEi> balEiIncls;
	public List<BalanceEi> balEiExcls;
	// ---

	public Integer rvId = null;
	public Integer svId = null;

	public String IMSI = null;
	public double ratedAmount = 0;
	public String streamName = null;
	public double discount = 0;
	public String discountRule = StringUtils.EMPTY;
	//    @Deprecated
	//    public long CDRDate;
	//    @Deprecated
	//    public Date CDRNativeDate;

	public long CdrStartTimeInSecond;

	public long CDRCycleEnd;
	public double totalBalance = 0;
	public double ALOBalance = 0;
	public double ALODiscount = 0;
	public double ITouchDiscount = 0;

	//    public double ITouchPPP = 0;
	// Added field for output (+ UsedProduct)
	public String PriceUnit = null;
	public long validityPeriodStart;
	public long validityPeriodEnd;
	// Internal Management Fields
	public String GuidingKey = null;
	public Integer CustIDA = null;
	public Integer CustIDB = null;

	// AccountVersionId
	public int BalanceGroup = 0;

	public String UsedProduct = null;

	public String SubscriptionID = null;

	// BONUS & DISCOUNT
	// OLD
	//    @Deprecated
	//    public String UsedDiscount = null;
	//
	// NEW
	public ArrayList<PromoItem> PromoPlan = new ArrayList<PromoItem>();
	/**
	 * Co ap dung ActivityEnd Discount hay khong?
	 */
	public boolean hasActivityEndDiscount = false;
	public boolean hasOtherDiscount = false;

	//    public String UsedPrePromo = null;
	//    public String UsedPostPromo = null;
	public String TimeZone = null;
	public String PriceModel = null;
	public boolean CUGFlag = false;
	public String CUGDiscount = null;
	public int CUGBalanceGroup = 0;
	public double CUGDiscAmt = 0;

	//    @Deprecated
	//    public String ProductList = null;
	public String MSN = null;

	// For ALO+ITOUCH promotion
	// the promotions in force at the time of the partial

	//    @Deprecated
	//    public ProductList Products = new ProductList();
	// This holds the priority order of the products
	//    @Deprecated
	//    public Vector<Integer> ProductPriority = new Vector<Integer>();
	//This holds discounts name
	//    @Deprecated
	//    public Vector<String> Options = new Vector<String>();
	// Add for test 06Nov
	public String cdrType;
	public String cdrTypeName;

	public String Direction;

	public int MapId;

	public int dataPart;

	//Default constructor
	public RatRec() {
		super();
	}

	/**
	 * Overloaded Constructor for RateRecord.
	 *
	 * @param OrginalData
	 */
	public RatRec(String[] OrginalData) {
		this.fields = OrginalData;
	}

	/**
	 * Utilities functions to map Main record
	 *
	 * @param OrginalData The OrginalData to map
	 */
	public void mapVNPRecord(String OrginalData) {
		RecordError tmpError;
		SimpleDateFormat sdfInput = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");

		if (seqNextVal < Integer.MAX_VALUE) {
			++seqNextVal;
		} else {
			seqNextVal = 0;
		}
		this.Seq = seqNextVal;

		//Set Orginal Data for Dump
		this.OriginalData = OrginalData;

		//Category the CDR type for processing , 1 is VoiceCall, 4 is SMS, ..
		this.cdrType = getField(IDX_CDR_TYPE);
		this.unitTypeId = Integer.valueOf(getField(IDX_UNIT_TYPE_ID));

		//Pull A_number, B_number form input record
		NumberA = getField(IDX_A_NUMBER);
		NumberB = getField(IDX_B_NUMBER);

		//        //Reformat B_number
		//        if (B_Number != null) {
		//            if (B_Number.startsWith("1") || B_Number.startsWith("9")) {
		//                B_Number = '0' + B_Number;
		//            } else if (B_Number.startsWith("84")) {
		//                B_Number = '0' + B_Number.substring(2);
		//            }
		//        }

		//Parse duration
		try {

			String tmpDur = getField(IDX_DURATION);

			if (tmpDur == null) {
				duration = 0;
			} else {
				duration = Double.parseDouble(tmpDur);
			}

		} catch (NumberFormatException nfe) {
			duration = 0;
			tmpError = new RecordError("ERR_DURATION_INVALID", ErrorType.DATA_VALIDATION);
			this.addError(tmpError);
		}

		//Parse Total Usage
		try {
			String tmpTotalUsage = getField(IDX_TOTAL_USAGE);

			if (tmpTotalUsage == null) {
				totalUsage = 0;
			} else {
				totalUsage = Double.parseDouble(tmpTotalUsage);
			}
		} catch (NumberFormatException nfe) {
			totalUsage = 0;
			tmpError = new RecordError("ERR_TOTAL_USAGE_INVALID", ErrorType.DATA_VALIDATION);
			this.addError(tmpError);
		}

		//Parse CDR date
		try {

			//            this.CDRNativeDate = sdfInput.parse(getField(IDX_CDR_START_TIME));
			//            this.CDRDate = CDRNativeDate.getTime() / 1000; // Miliseconds -> Seconds
			//            super.EventStartDate = this.CDRNativeDate;            
			super.EventStartDate = sdfInput.parse(getField(IDX_CDR_START_TIME)); // this.CDRNativeDate;

			this.CdrStartTimeInSecond = super.EventStartDate.getTime() / 1000;

			//            super.EventEndDate = new Date((long) (this.CDRDate + this.Duration) * 1000);            
			super.EventEndDate = new Date((long) (this.CdrStartTimeInSecond + this.duration) * 1000);

			//            super.UTCEventDate = this.CDRDate; // Seconds
			super.UTCEventDate = this.CdrStartTimeInSecond;

		} catch (ParseException pe) {
			tmpError = new RecordError("ERR_DATE_INVALID", ErrorType.DATA_VALIDATION);
			this.addError(tmpError);
		}

		// Set the guiding key
		this.GuidingKey = NumberA;

		//Mapping specific values
		//		if (cdrType.startsWith(CDR_TYPE_VOICE)) {
		if (this.unitTypeId == UNIT_TYPE_ID_SECONDS) {
			// set the RUM values
			cdrTypeName = "Voice";
			super.setRUMValue(RUM_ID_DUR, this.duration);

			//For direction worker
			this.Service = "2"; // "MOB";

			// add by manucian86
			//			this.UnitTypeId = 2; // SECONDS

			//		} else if (cdrType.startsWith(CDR_TYPE_SMS)) {
		} else if (this.unitTypeId == UNIT_TYPE_ID_SMS) {

			// set the RUM values
			cdrTypeName = "SMS";
			super.setRUMValue(RUM_ID_SMS, 1);

			//For direction worker
			this.Service = "1"; // "SMS";

			// add by manucian86
			//			this.UnitTypeId = 4; // SMS

			//		} else if (cdrType.startsWith(CDR_TYPE_DATA)) {
		} else if (this.unitTypeId == UNIT_TYPE_ID_OCTET) {
			// set the RUM values
			cdrTypeName = "DATA";
			super.setRUMValue(RUM_ID_VOL, this.totalUsage);

			//            //Set time, zone to NONE
			//            this.ZoneInfo = "NONE";
			//For direction worker
			this.Service = "3"; // "DATA";

			// add by manucian86
			//			this.UnitTypeId = 3; // OCTET

			//		} else if (cdrType.startsWith(CDR_TYPE_MMS)) {
		} else if (this.unitTypeId == UNIT_TYPE_ID_MMS) {
			// set the RUM values
			cdrTypeName = "MMS";
			super.setRUMValue(RUM_ID_MMS, 1);

			//For direction worker
			this.Service = "4"; // "SMS";

			// add by manucian86
			//			this.UnitTypeId = 5; // MMS

		}

		// Create a charge packet
		ChargePacket tmpCP = new ChargePacket();
		tmpCP.service = Service;
		tmpCP.packetType = "R";
		tmpCP.ratePlanName = UsedProduct;
		tmpCP.zoneModel = Service;
		tmpCP.timeModel = UsedProduct;

		this.addChargePacket(tmpCP);

		//Mapping others data
		//Parse Create time
		try {
			String tmpStr = getField(IDX_CREATED_TIME);
			if (tmpStr != null && !tmpStr.equals(StringUtils.EMPTY)) {
				this.CreateTime = sdfInput.parse(getField(IDX_CREATED_TIME));
			}

		} catch (ParseException pe) {
			tmpError = new RecordError("ERR_CREATE_TIME_INVALID", ErrorType.DATA_VALIDATION);
			this.addError(tmpError);
		}

		this.ZoneB = getField(IDX_B_ZONE);
		this.NWGroup = getField(IDX_NW_GROUP);

		//Parse Service Fee
		try {
			String tmpStr = getField(IDX_SERVICE_FEE);

			if (tmpStr == null) {
				ServiceFee = 0;
			} else {
				ServiceFee = Double.parseDouble(tmpStr);
			}
		} catch (NumberFormatException nfe) {
			ServiceFee = 0;
			tmpError = new RecordError("ERR_SERVICE_FEE_INVALID", ErrorType.DATA_VALIDATION);
			this.addError(tmpError);
		}

		//Parse Service Fee ID
		try {
			String tmpStr = getField(IDX_SERVICE_FEE_ID);

			if (tmpStr != null) {
				ServiceFeeId = Integer.parseInt(tmpStr);
			}

		} catch (NumberFormatException nfe) {
			tmpError = new RecordError("ERR_SERVICE_FEE_INVALID", ErrorType.DATA_VALIDATION);
			this.addError(tmpError);
		}

		//Parse Charge Fee
		try {
			String tmpStr = getField(IDX_CHARGE_FEE);

			if (tmpStr == null) {
				ChargeFee = 0;
			} else {
				ChargeFee = Double.parseDouble(tmpStr);
			}

		} catch (NumberFormatException nfe) {
			ChargeFee = 0;
			tmpError = new RecordError("ERR_CHARGE_FEE_INVALID", ErrorType.DATA_VALIDATION);
			this.addError(tmpError);
		}

		//Parse Charge Fee Id
		try {
			String tmpStr = getField(IDX_CHARGE_FEE_ID);

			if (tmpStr != null) {
				ChargeFeeId = Integer.parseInt(tmpStr);
			}

		} catch (NumberFormatException nfe) {
			tmpError = new RecordError("ERR_CHARGE_FEE_ID_INVALID", ErrorType.DATA_VALIDATION);
			this.addError(tmpError);
		}

		this.Lac = getField(IDX_LAC);
		this.CellId = getField(IDX_CELL_ID);
		this.SubscriberUnbill = getField(IDX_SUBSCRIBER_UNBILL);

		//Parse Bu_ID
		this.BuId = getField(IDX_BU_ID);
		//		try {
		//			String tmpStr = getField(IDX_BU_ID);
		//
		//			if (tmpStr != null) {
		//				this.BuId = Integer.parseInt(tmpStr);
		//			}
		//		} catch (NumberFormatException nfe) {
		//			tmpError = new RecordError("ERR_BU_ID_INVALID", ErrorType.DATA_VALIDATION);
		//			this.addError(tmpError);
		//		}

		//Parse Old_Bu_ID
		this.OldBuId = getField(IDX_OLD_BU_ID);
		//		try {
		//			String tmpStr = getField(IDX_OLD_BU_ID);
		//
		//			if (tmpStr != null) {
		//				this.OldBuId = Integer.parseInt(tmpStr);
		//			}
		//		} catch (NumberFormatException nfe) {
		//			tmpError = new RecordError("ERR_OLD_BU_ID_INVALID", ErrorType.DATA_VALIDATION);
		//			this.addError(tmpError);
		//		}

		//Parse Offer Cost
		try {
			String tmpStr = getField(IDX_OFFER_COST);

			if (tmpStr != null) {
				this.OfferCost = Integer.parseInt(tmpStr);
			} else {
				this.OfferCost = 0;
			}
		} catch (NumberFormatException nfe) {
			this.OfferCost = 0;
			tmpError = new RecordError("ERR_OFFER_COST_INVALID", ErrorType.DATA_VALIDATION);
			this.addError(tmpError);
		}

		//Parse Offer free block
		try {
			String tmpStr = getField(IDX_OFFER_FREE_BLOCK);

			if (tmpStr != null) {
				this.OfferFreeBlock = Integer.parseInt(tmpStr);
			} else {
				this.OfferFreeBlock = 0;
			}
		} catch (NumberFormatException nfe) {
			this.OfferFreeBlock = 0;
			tmpError = new RecordError("ERR_OFFER_FREE_BLOCK_INVALID", ErrorType.DATA_VALIDATION);
			this.addError(tmpError);
		}

		//Parse Internal Cost
		try {
			String tmpStr = getField(IDX_INTERNAL_COST);

			if (tmpStr != null) {
				this.InternalCost = Integer.parseInt(tmpStr);
			} else {
				this.InternalCost = 0;
			}
		} catch (NumberFormatException nfe) {
			this.InternalCost = 0;
			tmpError = new RecordError("ERR_INTERNAL_COST_INVALID", ErrorType.DATA_VALIDATION);
			this.addError(tmpError);
		}

		//Parse Internal Free Block
		try {
			String tmpStr = getField(IDX_INTERNAL_FREE_BLOCK);

			if (tmpStr != null) {
				this.InternalFreeBlock = Integer.parseInt(tmpStr);
			} else {
				this.InternalFreeBlock = 0;
			}
		} catch (NumberFormatException nfe) {
			this.InternalFreeBlock = 0;
			tmpError = new RecordError("ERR_INTERNAL_FREE_BLOCK_INVALID", ErrorType.DATA_VALIDATION);
			this.addError(tmpError);
		}

		this.DialDigit = getField(IDX_DIAL_DIGIT);

		//Parse Record header
		try {
			String tmpStr = getField(IDX_CDR_RECORD_HEADER_ID);

			if (tmpStr != null) {
				this.CdrHeaderRecordId = Integer.parseInt(tmpStr);
			}
		} catch (NumberFormatException nfe) {
			tmpError = new RecordError("ERR_CDR_HEADER_RECORD_ID_INVALID", ErrorType.DATA_VALIDATION);
			this.addError(tmpError);
		}

		//Parse CDR sequence
		try {
			String tmpStr = getField(IDX_CDR_SEQUENCE_NUMBER);

			if (tmpStr != null) {
				this.CdrSeqNum = Integer.parseInt(tmpStr);
			}
		} catch (NumberFormatException nfe) {
			tmpError = new RecordError("ERR_CDR_SEQUENCE_INVALID", ErrorType.DATA_VALIDATION);
			this.addError(tmpError);
		}

		this.LocationNo = getField(IDX_LOCATION_NO);

		//Parse Call type id
		try {
			String tmpStr = getField(IDX_AUT_FINAL_ID);

			if (tmpStr != null) {
				//                this.CallTypeId = Integer.parseInt(tmpStr);
				this.uaId = tmpStr;
			}
		} catch (NumberFormatException nfe) {
			tmpError = new RecordError("ERR_CALL_TYPE_ID_INVALID", ErrorType.DATA_VALIDATION);
			this.addError(tmpError);
		}

		//        //Payment item id
		//        try {
		//            String tmpStr = getField(IDX_PAYMENT_ITEM_ID);
		//
		//            if (tmpStr != null) {
		//                this.PaymentItemId = Integer.parseInt(tmpStr);
		//            }
		//        } catch (NumberFormatException nfe) {
		//            tmpError = new RecordError("ERR_PAYMENT_ITEM_ID_INVALID", ErrorType.DATA_VALIDATION);
		//            this.addError(tmpError);
		//        }
		this.MscId = getField(IDX_MSC_ID);

		this.tpId = getField(IDX_TARIFF_PLAN_ID);

		this.MapId = Integer.parseInt(getField(IDX_MAP_ID));

		this.dataPart = Integer.parseInt(getField(IDX_DATA_PART));

		LOG_PROCESSING.debug(this.concatHeader(0, "UtId: " + this.unitTypeId + "; Du:" + this.duration + "; Tu: " + this.totalUsage));

	}

	public String unmapOriginalData() {

		String outFields[] = new String[32];
		int NumberOfFields;
		String errMessage = null;
		int i;
		StringBuilder tmpReassemble;
		SimpleDateFormat sdfInput = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss.SSS");

		//Get error message
		Collection<IError> errors = this.getErrors();
		Iterator<IError> iError = errors.iterator();
		while (iError.hasNext()) {
			RecordError tmpErr = (RecordError) iError.next();
			errMessage = tmpErr.getType() + " -> " + tmpErr.getMessage();
		}

		//Set output data
		outFields[0] = NumberA;
		outFields[1] = cdrType;
		outFields[2] = sdfInput.format(CreateTime);
		//        outFields[3] = sdfInput.format(CDRNativeDate);
		outFields[3] = sdfInput.format(super.EventStartDate);
		outFields[4] = String.valueOf(duration);
		outFields[5] = String.valueOf(totalUsage);
		outFields[6] = NumberB;
		outFields[7] = ZoneB;
		outFields[8] = NWGroup;
		outFields[9] = String.valueOf(ServiceFee);
		outFields[10] = String.valueOf(ServiceFeeId);
		outFields[11] = String.valueOf(ChargeFee);
		outFields[12] = String.valueOf(ChargeFeeId);
		outFields[13] = Lac;
		outFields[14] = CellId;
		outFields[15] = SubscriberUnbill;
		outFields[16] = String.valueOf(BuId);
		outFields[17] = String.valueOf(OldBuId);
		outFields[18] = String.valueOf(OfferCost);
		outFields[19] = String.valueOf(OfferFreeBlock);
		outFields[20] = String.valueOf(InternalCost);
		outFields[21] = String.valueOf(InternalFreeBlock);
		outFields[22] = DialDigit;
		outFields[23] = String.valueOf(CdrHeaderRecordId);
		outFields[24] = String.valueOf(CdrSeqNum);
		outFields[25] = LocationNo;
		outFields[26] = "2"; // Rerated
		outFields[27] = uaId;
		//        outFields[28] = String.valueOf(PaymentItemId);
		outFields[28] = MscId;
		outFields[29] = unitTypeId.toString();
		outFields[30] = tpId;
		outFields[31] = errMessage;

		tmpReassemble = new StringBuilder(1024);

		NumberOfFields = outFields.length;

		for (i = 0; i < NumberOfFields; i++) {
			if (i == 0) {
				tmpReassemble.append(outFields[i]);
			} else {
				tmpReassemble.append(",");
				tmpReassemble.append(outFields[i]);
			}
		}

		// return the re-assembled string
		return tmpReassemble.toString();

	}

	@Override
	public ArrayList<String> getDumpInfo() {
		ArrayList<String> tmpDumpList = null;
		tmpDumpList = new ArrayList<String>();

		// Format the fields
		tmpDumpList.add("============ DETAIL RECORD ============");
		tmpDumpList.add("  Record Number   = <" + this.RecordNumber + ">");
		tmpDumpList.add("  original record = <" + this.OriginalData + ">");
		tmpDumpList.add("  Service         = <" + this.Service + ">");
		tmpDumpList.add("  A Number        = <" + this.NumberA + ">");
		tmpDumpList.add("  B Number        = <" + this.NumberB + ">");
		//        tmpDumpList.add("  CDR Start Date  = <" + this.CDRDate + ">");
		tmpDumpList.add("  CDR Start Date  = <" + this.CdrStartTimeInSecond + ">");
		tmpDumpList.add("  Duration        = <" + this.duration + ">");
		tmpDumpList.add("  IMSI            = <" + this.IMSI + ">");
		tmpDumpList.add("       --- Customer Attributes ---");
		tmpDumpList.add("  Guiding Key     = <" + this.GuidingKey + ">");
		tmpDumpList.add("  Customer ID A   = <" + this.CustIDA + ">");
		tmpDumpList.add("  Customer ID B   = <" + this.CustIDB + ">");
		tmpDumpList.add("  CUG Flag        = <" + this.CUGFlag + ">");
		tmpDumpList.add("  CUG Discount    = <" + this.CUGDiscount + ">");
		tmpDumpList.add("  CUG Balance Grp = <" + this.CUGBalanceGroup + ">");
		tmpDumpList.add("  CUG Disc Amount = <" + this.CUGDiscAmt + ">");
		tmpDumpList.add("       --- Rating Attributes ---");
		tmpDumpList.add("  Product Used    = <" + this.UsedProduct + ">");
		tmpDumpList.add("  SubscriptionID  = <" + this.SubscriptionID + ">");
		//        tmpDumpList.add("  Zone            = <" + this.ZoneInfo + ">");
		tmpDumpList.add("  Time Zone       = <" + this.TimeZone + ">");
		tmpDumpList.add("  Price Model     = <" + this.PriceModel + ">");
		tmpDumpList.add("  Rated Amount    = <" + this.ratedAmount + ">");
		//        tmpDumpList.add("  Discount Used   = <" + this.UsedDiscount + ">");
		tmpDumpList.add("  Discount Amount = <" + this.discount + ">");
		tmpDumpList.add("  Discount Rule   = <" + this.discountRule + ">");
		tmpDumpList.add("  Output Stream   = <" + this.streamName + ">");

		// Add Charge Packets
		tmpDumpList.addAll(getChargePacketsDump());

		// Add Balance Impacts
		tmpDumpList.addAll(getBalanceImpactsDump());

		tmpDumpList.add("       --- Extra Attributes ---");
		tmpDumpList.add("  Subscription id = <" + this.SubscriptionID + ">");
		tmpDumpList.add("  price unit = <" + this.PriceUnit + ">");
		tmpDumpList.add("  validity period start = <" + this.validityPeriodStart + ">");
		tmpDumpList.add("  validity period end = <" + this.validityPeriodEnd + ">");

		// Add Errors
		tmpDumpList.addAll(getErrorDump());

		return tmpDumpList;
	}

	@Override
	public String toString() {
		return concatHeader(0,
				String.format("[B=%s;CDR=%s;FAUT=%s;TP=%s]",
						this.NumberB,
						this.cdrTypeName,
						this.uaId,
						this.tpId));
	}

	public String concatHeader(int tabNum, String text) {
		String result = null;

		if (tabNum == 0) {
			result = String.format("[SEQ:%d;A:%s] > %s", Seq, NumberA, text);
		} else if (tabNum == 1) {
			result = String.format("[SEQ:%d;A:%s] > \t%s", Seq, NumberA, text);
		} else if (tabNum == 2) {
			result = String.format("[SEQ:%d;A:%s] > \t\t%s", Seq, NumberA, text);
		} else if (tabNum == 3) {
			result = String.format("[SEQ:%d;A:%s] > \t\t\t%s", Seq, NumberA, text);
		}

		return result;
	}

	public boolean assignRUMValue(String RUM, double NewValue) {
		RUMInfo tmpRUM;
		int Index;

		for (Index = 0; Index < RUMs.size(); Index++) {
			tmpRUM = RUMs.get(Index);

			if (tmpRUM.RUMName.equals(RUM)) {
				tmpRUM.RUMQuantity = NewValue;
				return true;
			}
		}

		return false;
	}

	public void renewChargePacket(String rumName, double newRUMValue) {
		for (ChargePacket chargePacket : getChargePackets()) {
			if (chargePacket.rumName.equals(rumName)) {
				chargePacket.chargedValue = 0;
			}
		}

		assignRUMValue(rumName, newRUMValue);
	}

}
