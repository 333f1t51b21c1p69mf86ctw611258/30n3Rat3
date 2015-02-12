/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package eonerate.process;

import ElcRate.exception.InitializationException;
import ElcRate.exception.ProcessingException;
import ElcRate.lang.Counter;
import ElcRate.lang.CustProductInfo;
import ElcRate.lang.DiscountInformation;
import ElcRate.logging.ILogger;
import ElcRate.logging.LogUtil;
import ElcRate.process.AbstractBalanceHandlerPlugIn;
import ElcRate.record.IRecord;
import eonerate.entity.BalanceEi;
import eonerate.entity.OffBalAwd;
import eonerate.entity.OffBalMap;
import eonerate.entity.RatRec;
import eonerate.entity.TimeRange;
import eonerate.util.DatabaseUtil;
import eonerate.util.ElcRateUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author manucian86
 */
public class PrRat extends AbstractBalanceHandlerPlugIn {

	ILogger LOG_PROCESSING = LogUtil.getLogUtil().getLogger("Processing");
	//
	private static String OriginalPipelineName;
	private static String OriginalModuleName;
	private static String OriginalSymbolicName;
	//
	private static List<OffBalAwd> offerBalanceAwardDUR = null;
	private static List<OffBalAwd> offerBalanceAwardSMS = null;
	private static List<OffBalAwd> offerBalanceAwardMMS = null;
	private static List<OffBalAwd> offerBalanceAwardVOL = null;

	private static List<OffBalMap> offBalMaps = null;

	private static void initOfferBalanceAwardList() {
		if (offerBalanceAwardDUR == null) {
			offerBalanceAwardDUR = new ArrayList<OffBalAwd>();
		} else {
			offerBalanceAwardDUR.clear();
		}

		if (offerBalanceAwardSMS == null) {
			offerBalanceAwardSMS = new ArrayList<OffBalAwd>();
		} else {
			offerBalanceAwardSMS.clear();
		}

		if (offerBalanceAwardMMS == null) {
			offerBalanceAwardMMS = new ArrayList<OffBalAwd>();
		} else {
			offerBalanceAwardMMS.clear();
		}

		if (offerBalanceAwardVOL == null) {
			offerBalanceAwardVOL = new ArrayList<OffBalAwd>();
		} else {
			offerBalanceAwardVOL.clear();
		}
	}

	public static void InitCache() throws InitializationException {
		loadOffBalAwd();
		loadOffBalMap();
	}

	private static void loadOffBalMap() throws InitializationException {
		if (OriginalPipelineName == null
				|| OriginalModuleName == null
				|| OriginalSymbolicName == null) {

			return;
		}

		Connection connection = null;
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;

		offBalMaps = new ArrayList<OffBalMap>();

		try {
			connection = DatabaseUtil.getDatabaseConnection(OriginalPipelineName, OriginalModuleName);

			String selectQuery = DatabaseUtil.getDataStatements(OriginalPipelineName, OriginalModuleName, "OffBalMapSelectStatement");

			preparedStatement = DatabaseUtil.getPreparedStatement(connection, selectQuery);

			// Execute the query
			resultSet = preparedStatement.executeQuery();

			while (resultSet.next()) {

				OffBalMap aOffBalMap = new OffBalMap();
				aOffBalMap.balanceName = resultSet.getString("BALANCE_NAME");
				aOffBalMap.balanceId = resultSet.getInt("BALANCE_ID");
				aOffBalMap.offerName = resultSet.getString("OFFER_NAME");
				aOffBalMap.offerId = resultSet.getInt("OFFER_ID");
				aOffBalMap.resellerVersionId = resultSet.getInt("RESELLER_VERSION_ID");
				aOffBalMap.balanceOrder = resultSet.getInt("BALANCE_ORDER");
				aOffBalMap.isShadow = resultSet.getShort("IS_SHADOW");
				aOffBalMap.isCore = resultSet.getShort("IS_CORE");
				aOffBalMap.expirationDate = resultSet.getDate("EXPIRATION_DATE");
				aOffBalMap.minBalance = resultSet.getDouble("MIN_BALANCE");
				aOffBalMap.maxBalance = resultSet.getDouble("MAX_BALANCE");

				aOffBalMap.limitedConsumptionFlag = resultSet.getShort("LIMITED_CONSUMPTION_FLAG");
				aOffBalMap.limitedComsumptionAmount = resultSet.getDouble("LIMITED_CONSUMPTION_AMOUNT");

				aOffBalMap.expirationOption = resultSet.getString("EXPIRATION_OPTION");
				aOffBalMap.defaultExpirationOffset = resultSet.getInt("DEFAULT_EXPIRATION_OFFSET");
				aOffBalMap.isShared = resultSet.getShort("IS_SHARED");
				aOffBalMap.defaultLimitType = resultSet.getString("DEFAULT_LIMIT_TYPE");
				aOffBalMap.defaultLimitValue = resultSet.getDouble("DEFAULT_LIMIT_VALUE");
				aOffBalMap.defaultLimitPeriod = resultSet.getString("DEFAULT_LIMIT_PERIOD");

				Object tmp = resultSet.getObject("IS_INTERNAL");
				if (tmp != null && Integer.parseInt(tmp.toString()) == 1) {
					aOffBalMap.isInternal = true;
				} else {
					aOffBalMap.isInternal = false;
				}

				offBalMaps.add(aOffBalMap);

			}

		} catch (InitializationException ex) {
			throw new InitializationException("WHEN: Initialize OFFER_BALANCE_MAP ResultSet. Error: " + ex.toString(), ex, OriginalSymbolicName);
		} catch (SQLException ex) {
			throw new InitializationException("WHEN: Initialize OFFER_BALANCE_MAP ResultSet. Error: " + ex.toString(), ex, OriginalSymbolicName);
		} finally {
			if (resultSet != null) {
				try {
					resultSet.close();
				} catch (SQLException ex) {
					throw new InitializationException("WHEN: Close ResultSet. Error: " + ex.toString(), ex, OriginalSymbolicName);
				}
			}

			if (preparedStatement != null) {
				try {
					preparedStatement.close();
				} catch (SQLException ex) {
					throw new InitializationException("WHEN: Close PreparedStatement. Error: " + ex.toString(), ex, OriginalSymbolicName);
				}
			}

			if (connection != null) {
				try {
					connection.close();
				} catch (SQLException ex) {
					throw new InitializationException("WHEN: Close Connection. Error: " + ex.toString(), ex, OriginalSymbolicName);
				}
			}
		}
	}

	private static void loadOffBalAwd() throws InitializationException {

		if (OriginalPipelineName == null
				|| OriginalModuleName == null
				|| OriginalSymbolicName == null) {

			return;

		}

		Connection connection = null;
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;

		initOfferBalanceAwardList();

		try {
			connection = DatabaseUtil.getDatabaseConnection(OriginalPipelineName, OriginalModuleName);

			String selectQuery = DatabaseUtil.getDataStatements(OriginalPipelineName, OriginalModuleName, "SelectStatement");

			preparedStatement = DatabaseUtil.getPreparedStatement(connection, selectQuery);

			// Execute the query
			resultSet = preparedStatement.executeQuery();

			while (resultSet.next()) {

				OffBalAwd aOfferBalanceAward = new OffBalAwd();
				aOfferBalanceAward.OfferRCAwardMapId = resultSet.getInt("OFFER_RC_AWARD_MAP_ID");
				aOfferBalanceAward.ResellerVersionId = resultSet.getInt("RESELLER_VERSION_ID");
				aOfferBalanceAward.OfferId = resultSet.getInt("OFFER_ID");
				aOfferBalanceAward.RCTermId = resultSet.getInt("RC_TERM_ID");
				aOfferBalanceAward.TermFromDate = resultSet.getInt("TERM_FROM_DATE");
				aOfferBalanceAward.TermToDate = resultSet.getInt("TERM_TO_DATE");
				aOfferBalanceAward.TermLevelId = resultSet.getString("TERM_LEVEL_ID");
				aOfferBalanceAward.BalanceId = resultSet.getInt("BALANCE_ID");
				aOfferBalanceAward.Period = resultSet.getString("PERIOD");
				aOfferBalanceAward.Amount = resultSet.getDouble("AMOUNT");
				aOfferBalanceAward.CurrencyCode = resultSet.getInt("CURRENCY_CODE");
				aOfferBalanceAward.UnitTypeId = resultSet.getInt("UNIT_TYPE_ID");
				aOfferBalanceAward.RUMId = resultSet.getString("RUM_ID");

				Object tmp = resultSet.getObject("IS_INTERNAL");
				if (tmp != null && Integer.parseInt(tmp.toString()) == 1) {
					aOfferBalanceAward.IsInternal = true;
				} else {
					aOfferBalanceAward.IsInternal = false;
				}

				if (aOfferBalanceAward.RUMId.equalsIgnoreCase(RatRec.RUM_ID_DUR)) {

					offerBalanceAwardDUR.add(aOfferBalanceAward);

				} else if (aOfferBalanceAward.RUMId.equalsIgnoreCase(RatRec.RUM_ID_SMS)) {

					offerBalanceAwardSMS.add(aOfferBalanceAward);

				} else if (aOfferBalanceAward.RUMId.equalsIgnoreCase(RatRec.RUM_ID_MMS)) {

					offerBalanceAwardMMS.add(aOfferBalanceAward);

				} else if (aOfferBalanceAward.RUMId.equalsIgnoreCase(RatRec.RUM_ID_VOL)) {

					offerBalanceAwardVOL.add(aOfferBalanceAward);

				}
			}

		} catch (InitializationException ex) {
			throw new InitializationException("WHEN: Initialize OFFER_BALANCE_AWARD ResultSet. Error: " + ex.toString(), ex, OriginalSymbolicName);
		} catch (SQLException ex) {
			throw new InitializationException("WHEN: Initialize OFFER_BALANCE_AWARD ResultSet. Error: " + ex.toString(), ex, OriginalSymbolicName);
		} finally {
			if (resultSet != null) {
				try {
					resultSet.close();
				} catch (SQLException ex) {
					throw new InitializationException("WHEN: Close ResultSet. Error: " + ex.toString(), ex, OriginalSymbolicName);
				}
			}

			if (preparedStatement != null) {
				try {
					preparedStatement.close();
				} catch (SQLException ex) {
					throw new InitializationException("WHEN: Close PreparedStatement. Error: " + ex.toString(), ex, OriginalSymbolicName);
				}
			}

			if (connection != null) {
				try {
					connection.close();
				} catch (SQLException ex) {
					throw new InitializationException("WHEN: Close Connection. Error: " + ex.toString(), ex, OriginalSymbolicName);
				}
			}
		}

	}

	@Override
	public void init(String PipelineName, String ModuleName) throws InitializationException {
		OriginalPipelineName = PipelineName;
		OriginalModuleName = ModuleName;
		OriginalSymbolicName = getSymbolicName();

		super.init(PipelineName, ModuleName); //To change body of generated methods, choose Tools | Templates.        

		InitCache();
	}

	@Override
	public IRecord procValidRecord(IRecord r) throws ProcessingException {

		//	RatingControlItem tmpRatingControlItem;
		RatRec currentRecord = (RatRec) r;
		DiscountInformation discountInfo;
		//	BalanceImpact tmpBalImpact;
		Counter counter;

		double alpha;
		//        String[] discounts;

		// Used for balance creation
		//        long tmpStartDate = 0;
		//        long tmpEndDate = 0;
		//        //if no discount - return home
		//        if (currentRecord.UsedDiscount == null) {
		//            return r;
		//        }
		//        discounts = currentRecord.UsedDiscount.split(",");
		//
		currentRecord.OfferFreeBlock = 0;
		currentRecord.InternalFreeBlock = 0;
		//

		LOG_PROCESSING.debug(currentRecord.concatHeader(0, "Awd..."));

		double rumVol = currentRecord.getRUMValue(RatRec.RUM_ID_VOL);
		if (rumVol > 0) {
			List<OffBalAwd> lstOfferBalanceAwardVOL = getOfferBalanceAwards(RatRec.RUM_ID_VOL, currentRecord);

			for (OffBalAwd offerBalanceAward : lstOfferBalanceAwardVOL) {
				counter = checkCounterExists(currentRecord.BalanceGroup, offerBalanceAward.OfferRCAwardMapId, currentRecord.UTCEventDate);

				alpha = 0;

				if (counter == null || counter.CurrentBalance > 0) {

					TimeRange timeRange = ElcRateUtil.getTimeRange(offerBalanceAward.Period, currentRecord);

					// Consume nhe!!!
					discountInfo = discountConsumeRUM(
							currentRecord,
							String.format("%s_%s", offerBalanceAward.OfferId, offerBalanceAward.BalanceId),
							currentRecord.BalanceGroup,
							RatRec.RUM_ID_VOL,
							offerBalanceAward.OfferRCAwardMapId, // CounterId,
							offerBalanceAward.Amount, // Threshold,
							timeRange.StartTime,
							timeRange.EndTime);

					double rumVolNew = currentRecord.getRUMValue(RatRec.RUM_ID_VOL);

					//Get discount values
					if (discountInfo.isDiscountApplied()) {
						currentRecord.discount += discountInfo.getDiscountedValue();

						alpha = rumVol - rumVolNew;

						if (offerBalanceAward.IsInternal) {
							//                                    CurrentRecord.InternalCost = discountInfo.getDiscountedValue();
							currentRecord.InternalFreeBlock += alpha;
						} else {
							//                                    CurrentRecord.OfferCost = discountInfo.getDiscountedValue();
							currentRecord.OfferFreeBlock += alpha;
						}

						rumVol = rumVolNew;
					}

				}

				LOG_PROCESSING.debug(currentRecord.concatHeader(1, "OAwMap: " + offerBalanceAward.OfferRCAwardMapId + " => Alpha: " + alpha));

				if (rumVol == 0) {
					break;
				}
			}
		}

		double rumSms = currentRecord.getRUMValue(RatRec.RUM_ID_SMS);
		if (rumSms > 0) {
			List<OffBalAwd> lstOfferBalanceAwardSMS = getOfferBalanceAwards(RatRec.RUM_ID_SMS, currentRecord);

			for (OffBalAwd offerBalanceAward : lstOfferBalanceAwardSMS) {
				counter = checkCounterExists(currentRecord.BalanceGroup, offerBalanceAward.OfferRCAwardMapId, currentRecord.UTCEventDate);

				alpha = 0;

				if (counter == null || counter.CurrentBalance > 0) {

					TimeRange timeRange = ElcRateUtil.getTimeRange(offerBalanceAward.Period, currentRecord);

					// Consume nhe!!!
					discountInfo = discountConsumeRUM(
							currentRecord,
							String.format("%s_%s", offerBalanceAward.OfferId, offerBalanceAward.BalanceId),
							currentRecord.BalanceGroup,
							RatRec.RUM_ID_SMS,
							offerBalanceAward.OfferRCAwardMapId, // CounterId,
							offerBalanceAward.Amount, // Threshold,
							timeRange.StartTime,
							timeRange.EndTime);

					double rumSmsNew = currentRecord.getRUMValue(RatRec.RUM_ID_SMS);

					//Get discount values
					if (discountInfo.isDiscountApplied()) {
						currentRecord.discount += discountInfo.getDiscountedValue();

						alpha = rumSms - rumSmsNew;

						if (offerBalanceAward.IsInternal) {
							//                                    CurrentRecord.InternalCost = discountInfo.getDiscountedValue();
							currentRecord.InternalFreeBlock += alpha;
						} else {
							//                                    CurrentRecord.OfferCost = discountInfo.getDiscountedValue();
							currentRecord.OfferFreeBlock += alpha;
						}

						rumSms = rumSmsNew;
					}
				}

				LOG_PROCESSING.debug(currentRecord.concatHeader(1, "OAwMap: " + offerBalanceAward.OfferRCAwardMapId + " => Alpha: " + alpha));

				if (rumSms == 0) {
					break;
				}
			}
		}

		double rumMms = currentRecord.getRUMValue(RatRec.RUM_ID_MMS);
		if (rumMms > 0) {
			List<OffBalAwd> lstOfferBalanceAwardMMS = getOfferBalanceAwards(RatRec.RUM_ID_MMS, currentRecord);

			for (OffBalAwd offerBalanceAward : lstOfferBalanceAwardMMS) {
				counter = checkCounterExists(currentRecord.BalanceGroup, offerBalanceAward.OfferRCAwardMapId, currentRecord.UTCEventDate);

				alpha = 0;

				if (counter == null || counter.CurrentBalance > 0) {

					TimeRange timeRange = ElcRateUtil.getTimeRange(offerBalanceAward.Period, currentRecord);

					// Consume nhe!!!
					discountInfo = discountConsumeRUM(
							currentRecord,
							String.format("%s_%s", offerBalanceAward.OfferId, offerBalanceAward.BalanceId),
							currentRecord.BalanceGroup,
							RatRec.RUM_ID_MMS,
							offerBalanceAward.OfferRCAwardMapId, // CounterId,
							offerBalanceAward.Amount, // Threshold,
							timeRange.StartTime,
							timeRange.EndTime);

					double rumMmsNew = currentRecord.getRUMValue(RatRec.RUM_ID_MMS);

					//Get discount values
					if (discountInfo.isDiscountApplied()) {
						currentRecord.discount += discountInfo.getDiscountedValue();

						alpha = rumMms - rumMmsNew;

						if (offerBalanceAward.IsInternal) {
							//                                    CurrentRecord.InternalCost = discountInfo.getDiscountedValue();
							currentRecord.InternalFreeBlock += alpha;
						} else {
							//                                    CurrentRecord.OfferCost = discountInfo.getDiscountedValue();
							currentRecord.OfferFreeBlock += alpha;
						}

						rumMms = rumMmsNew;
					}
				}

				LOG_PROCESSING.debug(currentRecord.concatHeader(2, "OAwMap: " + offerBalanceAward.OfferRCAwardMapId + " => Alpha: " + alpha));

				if (rumMms == 0) {
					break;
				}
			}
		}

		double rumDur = currentRecord.getRUMValue(RatRec.RUM_ID_DUR);
		if (rumDur > 0) {

			// chua award
			if (rumDur == doAloAward(currentRecord, rumDur)) {

				List<OffBalAwd> lstOfferBalanceAwardDUR = getOfferBalanceAwards(RatRec.RUM_ID_DUR, currentRecord);

				for (OffBalAwd offerBalanceAward : lstOfferBalanceAwardDUR) {
					counter = checkCounterExists(currentRecord.BalanceGroup, offerBalanceAward.OfferRCAwardMapId, currentRecord.UTCEventDate);

					alpha = 0;

					if (counter == null || counter.CurrentBalance > 0) {

						TimeRange timeRange = ElcRateUtil.getTimeRange(offerBalanceAward.Period, currentRecord);

						// Consume nhe!!!
						discountInfo = discountConsumeRUM(
								currentRecord,
								String.format("%s_%s", offerBalanceAward.OfferId, offerBalanceAward.BalanceId),
								currentRecord.BalanceGroup,
								RatRec.RUM_ID_DUR,
								offerBalanceAward.OfferRCAwardMapId, // CounterId,
								offerBalanceAward.Amount, // Threshold,
								timeRange.StartTime,
								timeRange.EndTime);

						double rumDurNew = currentRecord.getRUMValue(RatRec.RUM_ID_DUR);

						//Get discount values
						if (discountInfo.isDiscountApplied()) {
							currentRecord.discount += discountInfo.getDiscountedValue();

							alpha = rumDur - rumDurNew;

							if (offerBalanceAward.IsInternal) {
								//                                    CurrentRecord.InternalCost = discountInfo.getDiscountedValue();
								currentRecord.InternalFreeBlock += alpha;
							} else {
								//                                    CurrentRecord.OfferCost = discountInfo.getDiscountedValue();
								currentRecord.OfferFreeBlock += alpha;
							}

							rumDur = rumDurNew;
						}
					}

					LOG_PROCESSING.debug(currentRecord.concatHeader(1, "OAwMap: " + offerBalanceAward.OfferRCAwardMapId + " => Alpha: " + alpha));

					if (rumDur == 0) {
						break;
					}
				}
			}
		}

		return r;
	}

	private double doAloAward(RatRec currentRecord, double rumDur) {
		OffBalMap aOffBalMap = getAloBalMap(currentRecord);

		double newRumDur = 0;

		if (aOffBalMap != null) {

			if (aOffBalMap.limitedComsumptionAmount < rumDur) {
				newRumDur = rumDur - aOffBalMap.limitedComsumptionAmount;
			}
			//			else {
			//				newRumDur = 0;
			//			}

			currentRecord.assignRUMValue(RatRec.RUM_ID_DUR, newRumDur);

			if (aOffBalMap.isInternal) {
				currentRecord.InternalFreeBlock = rumDur - newRumDur;

				LOG_PROCESSING.debug(currentRecord.concatHeader(1,
						"Blo Awd: " + currentRecord.InternalFreeBlock +
								" => new DUR Rum: " + newRumDur));
			} else {
				currentRecord.OfferFreeBlock = rumDur - newRumDur;

				LOG_PROCESSING.debug(currentRecord.concatHeader(1,
						"Blo Awd: " + currentRecord.OfferFreeBlock +
								" => new DUR Rum: " + newRumDur));
			}

		} else {
			// not change
			newRumDur = rumDur;
		}

		return newRumDur;
	}

	private OffBalMap getAloBalMap(RatRec currentRecord) {

		for (CustProductInfo aCustProductInfo : currentRecord.RatePlans) {
			for (OffBalMap aOffBalMap : offBalMaps) {
				if (aCustProductInfo.getProductID().equals(aOffBalMap.offerId.toString())) {

					return aOffBalMap;

				}
			}
		}

		return null;

	}

	@Override
	public IRecord procErrorRecord(IRecord r) throws ProcessingException {
		return r;
	}

	private List<OffBalAwd> getOfferBalanceAwards(String rumId, RatRec currentRecord) {
		List<OffBalAwd> result = new ArrayList<OffBalAwd>();

		List<OffBalAwd> usedOfferBalanceAward = null;

		if (rumId.equals(RatRec.RUM_ID_VOL)) {
			usedOfferBalanceAward = offerBalanceAwardVOL;
		} else if (rumId.equals(RatRec.RUM_ID_DUR)) {
			usedOfferBalanceAward = offerBalanceAwardDUR;
		} else if (rumId.equals(RatRec.RUM_ID_SMS)) {
			usedOfferBalanceAward = offerBalanceAwardSMS;
		} else if (rumId.equals(RatRec.RUM_ID_MMS)) {
			usedOfferBalanceAward = offerBalanceAwardMMS;
		}

		for (Integer aOfferId : currentRecord.offIdBs) {
			for (OffBalAwd offerBalanceAward : usedOfferBalanceAward) {
				if (offerBalanceAward.ResellerVersionId.equals(currentRecord.rvId)
						//
						&& offerBalanceAward.OfferId.equals(aOfferId)
						//
						&& offerBalanceAward.TermFromDate <= currentRecord.UTCEventDate
						//
						&& (offerBalanceAward.TermToDate == null
								|| offerBalanceAward.TermToDate == 0
								|| offerBalanceAward.TermToDate > currentRecord.UTCEventDate)) {

					// Co Bal la Awd
					for (BalanceEi balanceEi : currentRecord.balEiIncls) {
						if (balanceEi.BalanceId.equals(offerBalanceAward.BalanceId)) {
							result.add(offerBalanceAward);
							break;
						}
					}
				}
			}
		}

		//	for (ChargePacket aChargePackage : currentRecord.getChargePackets()) {
		//
		//	    boolean existed = false;
		//
		//	    // Co cau hinh trong UpsellTemplate
		//	    for (OfferBalanceAward offerBalanceAward : usedOfferBalanceAward) {
		//		if (poChargePacket.ratePlanName.equals(offerBalanceAward.POOfferId.toString())
		//			&& aChargePackage.ratePlanName.equals(offerBalanceAward.UpsellTmpOfferId.toString())) {
		//
		//		    result.add(offerBalanceAward);
		//
		//		    existed = true;
		//
		//		    break;
		//
		//		}
		//	    }
		//
		//	    // Khong cau hinh trong UpsellTemplate
		//	    if (!existed) {
		//		for (OfferBalanceAward offerBalanceAward : usedOfferBalanceAward) {
		//		    if (aChargePackage.ratePlanName.equals(offerBalanceAward.POOfferId.toString())
		//			    && aChargePackage.ratePlanName.equals(offerBalanceAward.UpsellTmpOfferId.toString())) {
		//
		//			result.add(offerBalanceAward);
		//
		//			break;
		//
		//		    }
		//		}
		//	    }
		//	}
		//
		//	// PriorityValue cang lon thi Priority cang cao
		//	for (int i = 0; i < result.size() - 1; i++) {
		//	    OfferBalanceAward item1 = result.get(i);
		//
		//	    for (int j = i + 1; j < result.size(); j++) {
		//		OfferBalanceAward item2 = result.get(j);
		//
		//		if (item1.BalancePriority < item2.BalancePriority) {
		//		    result.set(i, item2);
		//		    result.set(j, item1);
		//		}
		//	    }
		//	}
		return result;
	}

}
