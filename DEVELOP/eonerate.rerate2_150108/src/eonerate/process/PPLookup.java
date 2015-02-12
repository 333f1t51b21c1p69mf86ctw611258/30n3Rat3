/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package eonerate.process;

import ElcRate.lang.CustProductInfo;
import ElcRate.logging.ILogger;
import ElcRate.logging.LogUtil;
import ElcRate.process.AbstractRegexMatch;
import ElcRate.record.IRecord;
import eonerate.common.Constant;
import eonerate.entity.PromoItem;
import eonerate.entity.RatRec;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author manucian86
 */
public class PPLookup extends AbstractRegexMatch {

	ILogger LOG_PROCESSING = LogUtil.getLogUtil().getLogger("Processing");

	@Override
	public IRecord procValidRecord(IRecord r) {
		RatRec currentRecord;
		String regexGroup;
		//	String RegexResult;
		currentRecord = (RatRec) r;
		//        currentRecord.UsedDiscount = StringUtils.EMPTY;

		String[] regexParams = new String[1];

		List<PromoItem> tmpPromoItems = new ArrayList<PromoItem>();

		for (CustProductInfo custProductInfo : currentRecord.RatePlans) {
			regexGroup = currentRecord.rvId.toString(); // CurrentRecord.Service;
			regexParams[0] = custProductInfo.getProductID();
			//            tmpSearchParameters[1] = CurrentRecord.ZoneInfo;

			// Look up the rate model to use
			//            RegexResult = getRegexMatch(RegexGroup, tmpSearchParameters);
			//            if (!RegexResult.equalsIgnoreCase("nomatch")) {
			//                CurrentRecord.UsedDiscount = CurrentRecord.UsedDiscount + RegexResult + ",";
			//            }
			// Danh sách các Discount sử dụng Regex
			ArrayList<String> regexResults = getAllEntries(regexGroup, regexParams);

			// Chuỗi Discount
			PromoItem promoItem;

			if (regexResults != null && regexResults.size() > 0) {
				for (String aRegexResult : regexResults) {
					//                    currentRecord.UsedDiscount = currentRecord.UsedDiscount + aRegexResult + ",";

					String[] items = aRegexResult.split(":", -1);

					promoItem = new PromoItem();
					promoItem.OfferId = custProductInfo.getProductID();
					promoItem.IsInternal = items[0].equals("1");
					promoItem.BonusItemId = items[1];
					promoItem.DiscountItemId = items[2];
					promoItem.DiscountAccumulatorPeriod = items[3];

					if (!currentRecord.hasActivityEndDiscount
							&& promoItem.DiscountAccumulatorPeriod.equals(Constant.ACCUMULATOR_PERIOD_ACTIVITY_END)) {

						currentRecord.hasActivityEndDiscount = true;
					}

					if (!currentRecord.hasOtherDiscount
							&& !promoItem.DiscountAccumulatorPeriod.equals(Constant.ACCUMULATOR_PERIOD_ACTIVITY_END)) {

						currentRecord.hasOtherDiscount = true;
					}

					tmpPromoItems.add(promoItem);

					//		    if (tmps[0].contains(Constant.PROMOTION_WHEN_RATING_PRE)) {
					//			CurrentRecord.UsedPrePromo += tmps[1] + ",";
					//		    } else if (tmps[0].contains(Constant.PROMOTION_WHEN_RATING_POST)) {
					//			CurrentRecord.UsedPostPromo += tmps[1] + ",";
					//		    }
				}

				//                logString = getSymbolicName() + " [A_NUMBER: " + currentRecord.NumberA + ", CDR_TYPE: " + currentRecord.CDRType + "]...Result: <UsedDiscount: " + currentRecord.UsedDiscount + ">";
				//                LOG_PROCESSING.debug(logString);
			}
		}

		LOG_PROCESSING.debug(currentRecord.concatHeader(0, "Proms:"));
		for (Integer aOfferId : currentRecord.offIdDs) {
			for (PromoItem aPromoItem : tmpPromoItems) {
				if (aOfferId.toString().equals(aPromoItem.OfferId)) {
					currentRecord.PromoPlan.add(aPromoItem);

					LOG_PROCESSING.debug(currentRecord.concatHeader(1, aPromoItem.toString()));

					break;
				}
			}
		}

		//        for (CustProductInfo tmpPCI : currentRecord.RatePlans) {
		//
		//	    ///
		//            
		//        }
		//        if (StringUtils.endsWith(currentRecord.UsedDiscount, ",")) {
		//            currentRecord.UsedDiscount = StringUtils.chomp(currentRecord.UsedDiscount, ",");
		//        }
		//	if (StringUtils.endsWith(CurrentRecord.UsedPrePromo, ",")) {
		//	    CurrentRecord.UsedPrePromo = StringUtils.chomp(CurrentRecord.UsedPrePromo, ",");
		//	}
		//
		//	if (StringUtils.endsWith(CurrentRecord.UsedPostPromo, ",")) {
		//	    CurrentRecord.UsedPostPromo = StringUtils.chomp(CurrentRecord.UsedPostPromo, ",");
		//	}
		return r;
	}

	@Override
	public IRecord procErrorRecord(IRecord r) {
		return r;
	}
}
