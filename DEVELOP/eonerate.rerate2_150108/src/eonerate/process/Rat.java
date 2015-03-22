/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package eonerate.process;

import ElcRate.exception.InitializationException;
import ElcRate.logging.ILogger;
import ElcRate.logging.LogUtil;
import ElcRate.process.AbstractRUMRateCalc;
import ElcRate.record.ErrorType;
import ElcRate.record.IRecord;
import ElcRate.record.RecordError;
import eonerate.entity.RatRec;
import eonerate.entity.DiscountItem;
import eonerate.entity.PromoItem;
import eonerate.util.DatabaseUtil;
import java.util.ArrayList;
import java.util.List;

public class Rat extends AbstractRUMRateCalc {

	ILogger LOG_PROCESSING = LogUtil.getLogUtil().getLogger("Processing");
	//
	private static String OriginalPipelineName;
	private static String OriginalModuleName;
	private static String OriginalSymbolicName;
	//
	private static List<DiscountItem> DiscountItems = null;

	public static void InitCache() throws InitializationException {
		if (OriginalPipelineName == null
				|| OriginalModuleName == null
				|| OriginalSymbolicName == null) {
			return;
		}

		DiscountItems = DatabaseUtil.InitDiscountData(OriginalPipelineName, OriginalModuleName);
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
	public IRecord procValidRecord(IRecord r) {
		RecordError recordError;
		RatRec currentRecord = (RatRec) r;

		try {

			boolean discounted = false;

			if (currentRecord.hasActivityEndDiscount) {

				for (PromoItem promoItem : currentRecord.PromoPlan) {
					if (promoItem.DiscountAccumulatorPeriod.equals("A")) {

						List<DiscountItem> items = new ArrayList<DiscountItem>();

						for (DiscountItem discountItem : DiscountItems) {
							if (promoItem.DiscountItemId.equals(discountItem.DiscountItemId.toString())
									&& currentRecord.rvId.equals(discountItem.ResellerVersionId)
									&& currentRecord.uaId.equals(discountItem.UsageActivityId.toString())
									&& currentRecord.getRUMValue(discountItem.RUMId) > 0) {

								items.add(discountItem);

							} else if (items.size() > 0) {
								break;
							}
						}

						double maxUnit;
						if (items.size() > 0) {

							// Ok, dieu kien can de ActivityEnd Discount,
							// nhung chua chac da la dieu kien du nhe cu?ng
							if (currentRecord.RUMs.size() > 1) {
								throw new UnsupportedOperationException("ActivityEnd Discount: RUM Count > 1");
							}

							String rumId = items.get(0).RUMId;
							double originalRUMValue = currentRecord.getRUMValue(rumId);

							PerformRating(currentRecord);
							double originalPrice = currentRecord.getTotalImpact("DONG");

							double calculated = 0;
							double realPrice = 0;
							double pricePiece;

							if (items.get(0).Threshold > 0) {

								currentRecord.renewChargePacket(rumId, items.get(0).Threshold - 1);
								PerformRating(currentRecord);

								pricePiece = currentRecord.getTotalImpact("DONG");

								realPrice = pricePiece; // Discount 0%, :))

								calculated = pricePiece;
							}

							for (int i = 0; i < items.size(); i++) {
								DiscountItem discountItem = items.get(i);

								if (i < items.size() - 1) {
									maxUnit = items.get(i + 1).Threshold - 1;

									currentRecord.renewChargePacket(rumId, maxUnit);
									PerformRating(currentRecord);
									discountItem.MaxMoney = currentRecord.getTotalImpact("DONG");
								} else {

									discountItem.MaxMoney = Double.MAX_VALUE;

								}

								if (originalPrice > discountItem.MaxMoney) {
									pricePiece = discountItem.MaxMoney - calculated;

									realPrice += pricePiece - (pricePiece * discountItem.Amount / 100);

									calculated = discountItem.MaxMoney;
								} else {
									pricePiece = originalPrice - calculated;

									realPrice += pricePiece - (pricePiece * discountItem.Amount / 100);

									calculated = originalPrice;

									break;
								}
							}

							// Tra lai real value cho em
							currentRecord.renewChargePacket(rumId, originalRUMValue);
							//			    PerformRating(currentRecord);

							currentRecord.ratedAmount = realPrice;

							if (promoItem.IsInternal) {
								currentRecord.InternalCost += originalPrice - currentRecord.ratedAmount;
							} else {
								currentRecord.OfferCost += originalPrice - currentRecord.ratedAmount;
							}

							discounted = true;

							// Chi chap nhat mot ActivityEnd duy nhat nhe cu?ng
							break;
						}
					}
				}
			}

			if (!discounted) {
				PerformRating(currentRecord);
				currentRecord.ratedAmount = currentRecord.getTotalImpact("DONG");
			}

			LOG_PROCESSING.debug(currentRecord.concatHeader(0, String.format("RatAmnt=%f", currentRecord.ratedAmount)));

			if (discounted) {
				LOG_PROCESSING.debug(currentRecord.concatHeader(1, String.format("ActEnd DisAmnt=%f", currentRecord.InternalCost + currentRecord.OfferCost)));
			}

		} catch (Exception ex) {
			currentRecord.ratedAmount = 0;

			recordError = new RecordError("ERR_RATE_LOOKUP: " + ex.toString(), ErrorType.SPECIAL);
			currentRecord.addError(recordError);

			LOG_PROCESSING.error(currentRecord.concatHeader(0, String.format("WHEN: Rate; ERROR: %s", ex.toString())));
		}

		return r;
	}

	@Override
	public IRecord procErrorRecord(IRecord r) {
		return r;
	}
}
