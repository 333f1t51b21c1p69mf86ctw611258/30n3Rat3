/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package eonerate.hotexport.entity;

import java.util.ArrayList;

import ElcRate.logging.ILogger;
import ElcRate.logging.LogUtil;
import ElcRate.record.RatingRecord;

public class RateRecord extends RatingRecord {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	ILogger LOG_PROCESSING = LogUtil.getLogUtil().getLogger("Processing");

	public enum HrcColumn {
		A_NUMBER,
		CDR_TYPE,
		CREATED_TIME,
		CDR_START_TIME,
		DATA_PART,
		DURATION,
		TOTAL_USAGE,
		B_NUMBER,
		B_ZONE,
		NW_GROUP,
		SERVICE_FEE,
		SERVICE_FEE_ID,
		CHARGE_FEE,
		CHARGE_FEE_ID,
		LAC,
		CELL_ID,
		SUBSCRIBER_UNBILL,
		BU_ID,
		OLD_BU_ID,
		OFFER_COST,
		OFFER_FREE_BLOCK,
		INTERNAL_COST,
		INTERNAL_FREE_BLOCK,
		DIAL_DIGIT,
		CDR_RECORD_HEADER_ID,
		CDR_SEQUENCE_NUMBER,
		LOCATION_NO,
		MSC_ID,
		UNIT_TYPE_ID,
		PRIMARY_OFFER_ID,
		DISCOUNT_ITEM_ID,
		BALANCE_CHANGE,
		RERATE_FLAG,
		AUT_FINAL_ID,
		TARIFF_PLAN_ID,
		ERROR_CODE,
		PAYMENT_ID,
		SUBSCRIBER_NO,
		SUBSCRIBER_NO_RESETS,
		ACCOUNT_NO,
		PARENT_ACCOUNT_NO,
		INTL_ID,
		INTL_VND,
		CDR_CALL_TYPE,
		QOS;

		public int getIndex() {
			return ordinal(); // + 1;
		}
	}

	long seqNextVal = 0;

	public String A_NUMBER = null;
	public String CDR_TYPE = null;
	public String CREATED_TIME = null;
	public String CDR_START_TIME = null;
	public String DATA_PART = null;
	public String DURATION = null;
	public String TOTAL_USAGE = null;
	public String B_NUMBER = null;
	public String B_ZONE = null;
	public String NW_GROUP = null;
	public String SERVICE_FEE = null;
	public String SERVICE_FEE_ID = null;
	public String CHARGE_FEE = null;
	public String CHARGE_FEE_ID = null;
	public String LAC = null;
	public String CELL_ID = null;
	public String SUBSCRIBER_UNBILL = null;
	public String BU_ID = null;
	public String OLD_BU_ID = null;
	public String OFFER_COST = null;
	public String OFFER_FREE_BLOCK = null;
	public String INTERNAL_COST = null;
	public String INTERNAL_FREE_BLOCK = null;
	public String DIAL_DIGIT = null;
	public String CDR_RECORD_HEADER_ID = null;
	public String CDR_SEQUENCE_NUMBER = null;
	public String LOCATION_NO = null;
	public String MSC_ID = null;
	public String UNIT_TYPE_ID = null;
	public String PRIMARY_OFFER_ID = null;
	public String DISCOUNT_ITEM_ID = null;
	public String BALANCE_CHANGE = null;
	public String RERATE_FLAG = null;
	public String AUT_FINAL_ID = null;
	public String TARIFF_PLAN_ID = null;
	public String ERROR_CODE = null;
	public String PAYMENT_ID = null;
	public String SUBSCRIBER_NO = null;
	public String SUBSCRIBER_NO_RESETS = null;
	public String ACCOUNT_NO = null;
	public String PARENT_ACCOUNT_NO = null;
	public String INTL_ID = null;
	public String INTL_VND = null;
	public String CDR_CALL_TYPE = null;
	public String QOS = null;

	//Default constructor
	public RateRecord() {
		super();
	}

	/**
	 * Overloaded Constructor for RateRecord.
	 *
	 * @param OrginalData
	 */
	public RateRecord(String[] OrginalData) {
		this.fields = OrginalData;
	}

	private String getStringByFields() {

		String result = null;

		StringBuilder sb = new StringBuilder();

		for (String item : this.fields) {
			sb.append(item);
			sb.append("|");
		}

		result = sb.toString();

		result = result.substring(0, result.length() - 1);

		return result;

	}

	/**
	 * Utilities functions to map Main record
	 *
	 * @param recordType The OrginalData to map
	 */
	public void mapVNPRecord() {

		if (seqNextVal < Integer.MAX_VALUE) {
			++seqNextVal;
		} else {
			seqNextVal = 0;
		}

		this.A_NUMBER = getField(HrcColumn.A_NUMBER.getIndex());
		this.CDR_TYPE = getField(HrcColumn.CDR_TYPE.getIndex());
		this.CREATED_TIME = getField(HrcColumn.CREATED_TIME.getIndex());
		this.CDR_START_TIME = getField(HrcColumn.CDR_START_TIME.getIndex());
		this.DATA_PART = getField(HrcColumn.DATA_PART.getIndex());
		this.DURATION = getField(HrcColumn.DURATION.getIndex());
		this.TOTAL_USAGE = getField(HrcColumn.TOTAL_USAGE.getIndex());
		this.B_NUMBER = getField(HrcColumn.B_NUMBER.getIndex());
		this.B_ZONE = getField(HrcColumn.B_ZONE.getIndex());
		this.NW_GROUP = getField(HrcColumn.NW_GROUP.getIndex());
		this.SERVICE_FEE = getField(HrcColumn.SERVICE_FEE.getIndex());
		this.SERVICE_FEE_ID = getField(HrcColumn.SERVICE_FEE_ID.getIndex());
		this.CHARGE_FEE = getField(HrcColumn.CHARGE_FEE.getIndex());
		this.CHARGE_FEE_ID = getField(HrcColumn.CHARGE_FEE_ID.getIndex());
		this.LAC = getField(HrcColumn.LAC.getIndex());
		this.CELL_ID = getField(HrcColumn.CELL_ID.getIndex());
		this.SUBSCRIBER_UNBILL = getField(HrcColumn.SUBSCRIBER_UNBILL.getIndex());
		this.BU_ID = getField(HrcColumn.BU_ID.getIndex());
		this.OLD_BU_ID = getField(HrcColumn.OLD_BU_ID.getIndex());
		this.OFFER_COST = getField(HrcColumn.OFFER_COST.getIndex());
		this.OFFER_FREE_BLOCK = getField(HrcColumn.OFFER_FREE_BLOCK.getIndex());
		this.INTERNAL_COST = getField(HrcColumn.INTERNAL_COST.getIndex());
		this.INTERNAL_FREE_BLOCK = getField(HrcColumn.INTERNAL_FREE_BLOCK.getIndex());
		this.DIAL_DIGIT = getField(HrcColumn.DIAL_DIGIT.getIndex());
		this.CDR_RECORD_HEADER_ID = getField(HrcColumn.CDR_RECORD_HEADER_ID.getIndex());
		this.CDR_SEQUENCE_NUMBER = getField(HrcColumn.CDR_SEQUENCE_NUMBER.getIndex());
		this.LOCATION_NO = getField(HrcColumn.LOCATION_NO.getIndex());
		this.MSC_ID = getField(HrcColumn.MSC_ID.getIndex());
		this.UNIT_TYPE_ID = getField(HrcColumn.UNIT_TYPE_ID.getIndex());
		this.PRIMARY_OFFER_ID = getField(HrcColumn.PRIMARY_OFFER_ID.getIndex());
		this.DISCOUNT_ITEM_ID = getField(HrcColumn.DISCOUNT_ITEM_ID.getIndex());
		this.BALANCE_CHANGE = getField(HrcColumn.BALANCE_CHANGE.getIndex());
		this.RERATE_FLAG = getField(HrcColumn.RERATE_FLAG.getIndex());
		this.AUT_FINAL_ID = getField(HrcColumn.AUT_FINAL_ID.getIndex());
		this.TARIFF_PLAN_ID = getField(HrcColumn.TARIFF_PLAN_ID.getIndex());
		this.ERROR_CODE = getField(HrcColumn.ERROR_CODE.getIndex());
		this.PAYMENT_ID = getField(HrcColumn.PAYMENT_ID.getIndex());
		this.SUBSCRIBER_NO = getField(HrcColumn.SUBSCRIBER_NO.getIndex());
		this.SUBSCRIBER_NO_RESETS = getField(HrcColumn.SUBSCRIBER_NO_RESETS.getIndex());
		this.ACCOUNT_NO = getField(HrcColumn.ACCOUNT_NO.getIndex());
		this.PARENT_ACCOUNT_NO = getField(HrcColumn.PARENT_ACCOUNT_NO.getIndex());
		this.INTL_ID = getField(HrcColumn.INTL_ID.getIndex());
		this.INTL_VND = getField(HrcColumn.INTL_VND.getIndex());
		this.CDR_CALL_TYPE = getField(HrcColumn.CDR_CALL_TYPE.getIndex());
		this.QOS = getField(HrcColumn.QOS.getIndex());

		//		LOG_PROCESSING.debug("DONE: Map InputRecord to object (" +
		//				this.seqNextVal + ";" + this.CDR_RECORD_HEADER_ID + "): " +
		//				getStringByFields());

	}

	public String unmapOriginalData() {

		String outFields[] = new String[45];
		int numberOfFields;
		int i;
		StringBuilder tmpReassemble;

		outFields[HrcColumn.A_NUMBER.getIndex()] = A_NUMBER;
		outFields[HrcColumn.CDR_TYPE.getIndex()] = CDR_TYPE;
		outFields[HrcColumn.CREATED_TIME.getIndex()] = CREATED_TIME;
		outFields[HrcColumn.CDR_START_TIME.getIndex()] = CDR_START_TIME;
		outFields[HrcColumn.DATA_PART.getIndex()] = DATA_PART;
		outFields[HrcColumn.DURATION.getIndex()] = DURATION;
		outFields[HrcColumn.TOTAL_USAGE.getIndex()] = TOTAL_USAGE;
		outFields[HrcColumn.B_NUMBER.getIndex()] = B_NUMBER;
		outFields[HrcColumn.B_ZONE.getIndex()] = B_ZONE;
		outFields[HrcColumn.NW_GROUP.getIndex()] = NW_GROUP;
		outFields[HrcColumn.SERVICE_FEE.getIndex()] = SERVICE_FEE;
		outFields[HrcColumn.SERVICE_FEE_ID.getIndex()] = SERVICE_FEE_ID;
		outFields[HrcColumn.CHARGE_FEE.getIndex()] = CHARGE_FEE;
		outFields[HrcColumn.CHARGE_FEE_ID.getIndex()] = CHARGE_FEE_ID;
		outFields[HrcColumn.LAC.getIndex()] = LAC;
		outFields[HrcColumn.CELL_ID.getIndex()] = CELL_ID;
		outFields[HrcColumn.SUBSCRIBER_UNBILL.getIndex()] = SUBSCRIBER_UNBILL;
		outFields[HrcColumn.BU_ID.getIndex()] = BU_ID;
		outFields[HrcColumn.OLD_BU_ID.getIndex()] = OLD_BU_ID;
		outFields[HrcColumn.OFFER_COST.getIndex()] = OFFER_COST;
		outFields[HrcColumn.OFFER_FREE_BLOCK.getIndex()] = OFFER_FREE_BLOCK;
		outFields[HrcColumn.INTERNAL_COST.getIndex()] = INTERNAL_COST;
		outFields[HrcColumn.INTERNAL_FREE_BLOCK.getIndex()] = INTERNAL_FREE_BLOCK;
		outFields[HrcColumn.DIAL_DIGIT.getIndex()] = DIAL_DIGIT;
		outFields[HrcColumn.CDR_RECORD_HEADER_ID.getIndex()] = CDR_RECORD_HEADER_ID;
		outFields[HrcColumn.CDR_SEQUENCE_NUMBER.getIndex()] = CDR_SEQUENCE_NUMBER;
		outFields[HrcColumn.LOCATION_NO.getIndex()] = LOCATION_NO;
		outFields[HrcColumn.MSC_ID.getIndex()] = MSC_ID;
		outFields[HrcColumn.UNIT_TYPE_ID.getIndex()] = UNIT_TYPE_ID;
		outFields[HrcColumn.PRIMARY_OFFER_ID.getIndex()] = PRIMARY_OFFER_ID;
		outFields[HrcColumn.DISCOUNT_ITEM_ID.getIndex()] = DISCOUNT_ITEM_ID;
		outFields[HrcColumn.BALANCE_CHANGE.getIndex()] = BALANCE_CHANGE;
		outFields[HrcColumn.RERATE_FLAG.getIndex()] = "13"; // RERATE_FLAG;
		outFields[HrcColumn.AUT_FINAL_ID.getIndex()] = AUT_FINAL_ID;
		outFields[HrcColumn.TARIFF_PLAN_ID.getIndex()] = TARIFF_PLAN_ID;
		outFields[HrcColumn.ERROR_CODE.getIndex()] = ERROR_CODE;
		outFields[HrcColumn.PAYMENT_ID.getIndex()] = PAYMENT_ID;
		outFields[HrcColumn.SUBSCRIBER_NO.getIndex()] = SUBSCRIBER_NO;
		outFields[HrcColumn.SUBSCRIBER_NO_RESETS.getIndex()] = SUBSCRIBER_NO_RESETS;
		outFields[HrcColumn.ACCOUNT_NO.getIndex()] = ACCOUNT_NO;
		outFields[HrcColumn.PARENT_ACCOUNT_NO.getIndex()] = PARENT_ACCOUNT_NO;
		outFields[HrcColumn.INTL_ID.getIndex()] = INTL_ID;
		outFields[HrcColumn.INTL_VND.getIndex()] = INTL_VND;
		outFields[HrcColumn.CDR_CALL_TYPE.getIndex()] = CDR_CALL_TYPE;
		outFields[HrcColumn.QOS.getIndex()] = QOS;

		tmpReassemble = new StringBuilder(1024);

		numberOfFields = outFields.length;

		for (i = 0; i < numberOfFields; i++) {
			if (i == 0) {
				tmpReassemble.append(outFields[i]);
			} else {
				tmpReassemble.append(",");
				tmpReassemble.append(outFields[i]);
			}
		}

		String tmp = tmpReassemble.toString();

		LOG_PROCESSING.debug("DONE: Unmap Object to String (" +
				this.seqNextVal + ";" + this.CDR_RECORD_HEADER_ID + "): " +
				tmp);

		// return the re-assembled string
		return tmp;

	}

	@Override
	public ArrayList<String> getDumpInfo() {
		// TODO Auto-generated method stub
		return null;
	}

}
