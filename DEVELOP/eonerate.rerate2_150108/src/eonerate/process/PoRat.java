/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package eonerate.process;

import ElcRate.exception.InitializationException;
import ElcRate.exception.ProcessingException;
import ElcRate.lang.Counter;
import ElcRate.lang.DiscountInformation;
import ElcRate.logging.ILogger;
import ElcRate.logging.LogUtil;
import ElcRate.record.ErrorType;
import ElcRate.record.IRecord;
import ElcRate.record.RecordError;
import eonerate.common.Constant;
import eonerate.entity.DiscountItem;
import eonerate.entity.PromoItem;
import eonerate.entity.RatRec;
import eonerate.entity.TimeRange;
import eonerate.util.DatabaseUtil;
import eonerate.util.ElcRateUtil;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author manucian86
 */
public class PoRat extends ElcRate.process.AbstractBalanceHandlerPlugIn {

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
    public IRecord procValidRecord(IRecord r) throws ProcessingException {
        RecordError recordError;
        RatRec currentRecord = (RatRec) r;
        Counter counter;
        DiscountInformation discountInfo;
        List<DiscountItem> items = null;

        try {

            if (currentRecord.hasOtherDiscount && currentRecord.ratedAmount > 0) {

                currentRecord.setRUMValue(Constant.RUM_ID_MONEY, currentRecord.ratedAmount);

                LOG_PROCESSING.debug(currentRecord.concatHeader(0, "Disc..."));
                for (PromoItem promoItem : currentRecord.PromoPlan) {
                    if (!promoItem.DiscountAccumulatorPeriod.equals(Constant.ACCUMULATOR_PERIOD_ACTIVITY_END)) {

                        if (items == null) {
                            items = new ArrayList<DiscountItem>();
                        } else {
                            items.clear();
                        }

                        for (DiscountItem discountItem : DiscountItems) {
                            if (discountItem.RUMId.equals(Constant.RUM_ID_MONEY)
                                    && promoItem.DiscountItemId.equals(discountItem.DiscountItemId.toString())
                                    && currentRecord.rvId.equals(discountItem.ResellerVersionId)
                                    && currentRecord.uaId.equals(discountItem.UsageActivityId.toString())) {

                                items.add(discountItem);

                            } else if (items.size() > 0) {
                                break;
                            }
                        }

                        if (items.size() > 0) {

                            LOG_PROCESSING.debug(currentRecord.concatHeader(1, promoItem.toString()));

                            TimeRange timeRange = ElcRateUtil.getTimeRange(promoItem.DiscountAccumulatorPeriod, currentRecord);

                            int counterId = Integer.valueOf(promoItem.DiscountItemId) * -1;

                            counter = checkCounterExists(currentRecord.BalanceGroup, counterId, currentRecord.UTCEventDate);

                            double oldBalance = 0;
                            if (counter != null) {
                                oldBalance = counter.CurrentBalance;
                            }

                            // Perform discount
                            discountInfo = discountAggregateRUM(
                                    currentRecord,
                                    String.format("%s_%s", promoItem.OfferId, promoItem.DiscountItemId),
                                    currentRecord.BalanceGroup,
                                    Constant.RUM_ID_MONEY,
                                    counterId,
                                    0,
                                    timeRange.StartTime,
                                    timeRange.EndTime);

                            //Get new Balance
                            double newBalance = discountInfo.getNewBalanceValue();
                            
                            LOG_PROCESSING.debug(currentRecord.concatHeader(2, "Old DisBln: " + oldBalance + "; New DisBln: " + newBalance));

                            if (discountInfo.isDiscountApplied()) {

                                double remain = newBalance;
                                double discountAmount = 0;
                                double discountPiece = 0;

                                for (int i = items.size() - 1; i >= 0; i--) {
                                    DiscountItem discountItem = items.get(i);

                                    if (remain >= discountItem.Threshold) {
                                        if (discountItem.Threshold > oldBalance) {
                                            discountPiece = remain - (discountItem.Threshold - 1);

                                            remain = discountItem.Threshold - 1;

                                            discountAmount += discountPiece * discountItem.Amount / 100;
                                        } else {
                                            discountPiece = remain - oldBalance;

//					    remain = oldBalance;
                                            discountAmount += discountPiece * discountItem.Amount / 100;

                                            break;
                                        }

                                    }
                                }

                                if (discountAmount > 0) {
                                    if (promoItem.IsInternal) {
                                        currentRecord.InternalCost += discountAmount;
                                    } else {
                                        currentRecord.OfferCost += discountAmount;
                                    }

                                    LOG_PROCESSING.debug(currentRecord.concatHeader(2, "DisAmnt: " + discountAmount));

                                    currentRecord.ratedAmount -= discountAmount;
                                }

                            }

                            currentRecord.setRUMValue(Constant.RUM_ID_MONEY, currentRecord.ratedAmount);

                        }

                    }

                }

            }

//            LOG_PROCESSING.debug(String.format("%s >>> %s => RatedAmount=%f", getSymbolicName(), currentRecord.toString(), currentRecord.RatedAmount));
        } catch (Exception ex) {
            currentRecord.ratedAmount = 0;

            recordError = new RecordError("ERR_RATE_LOOKUP: " + ex.toString(), ErrorType.SPECIAL);
            currentRecord.addError(recordError);

            LOG_PROCESSING.error(currentRecord.concatHeader(0, String.format("WHEN: Discount; ERROR: %s", ex.toString())));
        }

        return r;
    }

    @Override
    public IRecord procErrorRecord(IRecord r) throws ProcessingException {
        return r;
    }

}
