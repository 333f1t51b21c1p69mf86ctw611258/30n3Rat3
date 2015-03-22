/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package eonerate.process;

import ElcRate.exception.ProcessingException;
import ElcRate.lang.CustProductInfo;
import ElcRate.logging.ILogger;
import ElcRate.logging.LogUtil;
import ElcRate.process.AbstractRUMTimeMatch;
import ElcRate.record.ChargePacket;
import ElcRate.record.ErrorType;
import ElcRate.record.IRecord;
import ElcRate.record.RecordError;
import eonerate.entity.RatRec;
import java.util.ArrayList;

public class UpLookup extends ElcRate.process.AbstractRegexMatch {

	ILogger LOG_PROCESSING = LogUtil.getLogUtil().getLogger("Processing");

	@Override
	public IRecord procValidRecord(IRecord r) throws ProcessingException {
		RatRec currentRecord = (RatRec) r;
		String productId;
		ChargePacket aChargePacket;
		int iPOCount = 0;
		RecordError recordError;
		//        int iSOCount = 0;

		ArrayList<ChargePacket> aChargePacketList = new ArrayList<ChargePacket>();

		boolean existed = false;

		boolean existedTariffPlan = false;

		LOG_PROCESSING.info(currentRecord.concatHeader(0, "UP:"));
		for (CustProductInfo aCustProductInfo : currentRecord.RatePlans) {

			productId = aCustProductInfo.getProductID();
			aChargePacket = new ChargePacket();
			aChargePacket.timeSplitting = AbstractRUMTimeMatch.TIME_SPLITTING_NO_CHECK;
			aChargePacket.packetType = "R"; // Rating
			// ProductOfferId
			aChargePacket.ratePlanName = productId;
			// ServiceId
			aChargePacket.service = currentRecord.Service;
			if (!existed) {
				existed = this.enrichChargePacket(aChargePacket, currentRecord);
			} else {
				this.enrichChargePacket(aChargePacket, currentRecord);
			}
			//            // {{{ DIRTY: To ignore enrichChargePacket
			//            aChargePacket.zoneModel = currentRecord.UsageActivityId; 
			//            aChargePacket.timeModel = currentRecord.CalendarId;
			//            // }}} DIRTY
			aChargePacket.zoneInfo = currentRecord.ZoneGroupId;
			aChargePacket.zoneResult = currentRecord.uaId; // currentRecord.ZoneInfo;
			//            // Set zone,time to NONE for Data record
			//            // Rieng voi RecordType = 7 = DATA khong lookup theo ZoneModel va TimeModel
			//            if (currentRecord.RecordType.startsWith(RateRecord.CDR_TYPE_DATA)) {
			//                aChargePacket.zoneResult = "NONE";
			//                aChargePacket.timeResult = "NONE";
			//            }
			// Process PO/SO
			if (aChargePacket.ratingTypeDesc != null) {
				if (aChargePacket.ratingTypeDesc.endsWith(":" + RatRec.OFFER_TYPE_PO)) {

					iPOCount++;

					// Cho len dau cho de tim
					aChargePacketList.add(0, aChargePacket);

					if (iPOCount > 1) {
						LOG_PROCESSING.error(currentRecord.concatHeader(0, "More than 1 PO"));

						currentRecord.addError(new RecordError("ERR_MULTIPLE_PO_PRODUCTS", ErrorType.DATA_VALIDATION));
						return r;
					}

				} else if (aChargePacket.ratingTypeDesc.endsWith(":" + RatRec.OFFER_TYPE_SO)) {

					//                iSOCount++;
					aChargePacketList.add(aChargePacket);

					//                currentRecord.Options.add(aChargePacket.ratePlanName);
				}

				if (!existedTariffPlan && aChargePacket.ratingTypeDesc.startsWith(aChargePacket.priceGroup + ":")) {
					existedTariffPlan = true;
				}
			}
		}

		if (!existed) {
			LOG_PROCESSING.error(currentRecord.concatHeader(1, "=> No UP"));

			recordError = new RecordError("ERR_USAGE_PLAN_LOOKUP: No UsagePlan", ErrorType.SPECIAL, getSymbolicName());
			currentRecord.addError(recordError);

			return r;
		}

		if (!existedTariffPlan) {
			recordError = new RecordError("ERR_USAGE_PLAN_LOOKUP: Not existed TariffPlan: " + currentRecord.tpId, ErrorType.SPECIAL, getSymbolicName());
			currentRecord.addError(recordError);

			return r;
		}

		currentRecord.replaceChargePackets(aChargePacketList);

		//        if (iPOCount > 0) {
		//            for (ChargePacket chargePackage : aChargePacketList) {
		//                logString = getSymbolicName() + " [A_NUMBER: " + currentRecord.NumberA + "]-[CDR_TYPE: " + currentRecord.CDRType + "], ...Result: <ratePlanName: " + chargePackage.ratePlanName + ", service: " + chargePackage.service + ", zoneResult: " + chargePackage.zoneResult + ">";
		//                FWLog.debug(logString);
		//            }
		//            return r;
		//        } else if (iSOCount > 0) {
		//            //tmpChargePacket.ratePlanName = "Default";
		//            aChargePacketList.add(aChargePacket);
		//            currentRecord.replaceChargePackets(aChargePacketList);
		//        }
		LOG_PROCESSING.debug(currentRecord.concatHeader(0, "ChaPas:"));

		for (ChargePacket chargePackage : aChargePacketList) {
			LOG_PROCESSING.debug(currentRecord.concatHeader(
					1,
					String.format(
							"Plan: %s; RID: %s; PI: %s; ZO: %s; OT: %s",
							chargePackage.ratePlanName,
							chargePackage.rumName,
							chargePackage.priceGroup,
							chargePackage.zoneResult,
							chargePackage.ratingTypeDesc.endsWith(":" + RatRec.OFFER_TYPE_PO) ? "PO" : "SO")));
		}

		return r;
	}

	@Override
	public IRecord procErrorRecord(IRecord r) throws ProcessingException {
		return r;
	}

	/**
	 * Enriches the charge packet with the information that will be needed in
	 * the rest of the rating process. (priority, Time Model, Zone Model);
	 */
	private boolean enrichChargePacket(ChargePacket tmpChargePacket, RatRec currentRecord) {
		//	RecordError tmpError;
		String resultString;
		//        String[] regexResults;
		String regexGroup = null;

		String[] regexParams = new String[3];

		// Get the rate plan meta data for this rate plan/charge packet type
		regexParams[0] = tmpChargePacket.packetType;
		regexParams[1] = tmpChargePacket.ratePlanName;
		//		regexParams[2] = currentRecord.rvId.toString(); // CurrentRecord.Service;
		regexParams[2] = currentRecord.uaId;

		//		if (currentRecord.RecordType.startsWith(RateRecord.CDR_TYPE_VOICE)) {
		//			regexGroup = "UsagePlan_SECONDS";
		//		} else if (currentRecord.RecordType.startsWith(RateRecord.CDR_TYPE_SMS)) {
		//			regexGroup = "UsagePlan_SMS";
		//		} else if (currentRecord.RecordType.startsWith(RateRecord.CDR_TYPE_DATA)) {
		//			regexGroup = "UsagePlan_OCTET";
		//		} else if (currentRecord.RecordType.startsWith(RateRecord.CDR_TYPE_MMS)) {
		//			regexGroup = "UsagePlan_MMS";
		//		}

		regexGroup = currentRecord.rvId.toString();

		resultString = getRegexMatch(regexGroup, regexParams);

		LOG_PROCESSING.info(currentRecord.concatHeader(1, String.format("O: %s; UaId: %s => %s",
				regexParams[1],
				regexParams[2],
				resultString)));

		boolean existed = false;

		if (isValidRegexMatchResult(resultString) == false) {

			// error detected, add an error to the record
			//            tmpError = new RecordError("ERR_RATEPLAN_LOOKUP" + tmpChargePacket.packetType + tmpChargePacket.ratePlanName + CurrentRecord.Service, ErrorType.SPECIAL, getSymbolicName());
			//            CurrentRecord.addError(tmpError);
			tmpChargePacket.Valid = false;

		} else {

			existed = true;

			//            regexResults = resultString.split(":");
			for (int i = 0; i < currentRecord.offIdTs.size(); i++) {
				Integer offerId = currentRecord.offIdTs.get(i);

				if (offerId.toString().equals(tmpChargePacket.ratePlanName)) {
					tmpChargePacket.priority = currentRecord.offIdTs.size() - 1 - i;
				}
			}

			//            tmpChargePacket.priority = Integer.parseInt(regexResults[0]);
			//            tmpChargePacket.zoneModel = currentRecord.UsageActivityId; // regexResults[0]; // = USAGE_ACTIVITY_ID = zoneResult
			//            tmpChargePacket.priceGroup = regexResults[0];
			//	    tmpChargePacket.zoneResult = SplitResults[1];
			tmpChargePacket.timeModel = currentRecord.calId; // regexResults[1];
			//
			tmpChargePacket.priceGroup = String.format("%s_%s", currentRecord.rvId, currentRecord.tpId);
			//			tmpChargePacket.priceGroup = currentRecord.tpId;
			//	    tmpChargePacket.timeResult = SplitResults[2];
			//Add 20 Feb 14
			tmpChargePacket.ratingTypeDesc = resultString; // regexResults[2];

		}

		return existed;
	}

}
