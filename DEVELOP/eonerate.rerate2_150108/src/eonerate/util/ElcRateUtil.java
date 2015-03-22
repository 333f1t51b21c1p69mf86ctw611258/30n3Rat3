/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package eonerate.util;

import ElcRate.record.IError;
import ElcRate.record.IRecord;
import ElcRate.utils.ConversionUtils;
import eonerate.entity.OffBalAwd;
import eonerate.entity.RatRec;
import eonerate.entity.TimeRange;
import java.util.List;
import org.apache.commons.lang.StringUtils;

/**
 *
 * @author manucian86
 */
public class ElcRateUtil {

    private static ConversionUtils conversionUtils = new ConversionUtils();

    public static TimeRange getTimeRange(String range, RatRec currentRecord) {
        TimeRange timeRange = new TimeRange();

        if (range.equalsIgnoreCase(OffBalAwd.TIME_PERIOD_MONTHLY)) {

            timeRange.StartTime = conversionUtils.getUTCMonthStart(currentRecord.EventStartDate);
            timeRange.EndTime = conversionUtils.getUTCMonthEnd(currentRecord.EventStartDate);

        } else if (range.equalsIgnoreCase(OffBalAwd.TIME_PERIOD_WEEKLY)) {

            timeRange.StartTime = conversionUtils.getUTCDayStart(currentRecord.EventStartDate);
            timeRange.EndTime = conversionUtils.getUTCDayEnd(currentRecord.EventStartDate, 6);

        } else if (range.equalsIgnoreCase(OffBalAwd.TIME_PERIOD_DAILY)) {

            timeRange.StartTime = conversionUtils.getUTCDayStart(currentRecord.EventStartDate);
            timeRange.EndTime = conversionUtils.getUTCDayEnd(currentRecord.EventStartDate);

        } else if (range.equalsIgnoreCase(OffBalAwd.TIME_PERIOD_CALL)) {

            timeRange.StartTime = currentRecord.UTCEventDate;
            timeRange.EndTime = currentRecord.UTCEventDate;

        }

        return timeRange;
    }

    public static String getErrorList(IRecord r) {
        String result = StringUtils.EMPTY;

        List<IError> listErrors = r.getErrors();
        for (IError error : listErrors) {
            result = result + error.getMessage() + ", ";
        }

        if (result.endsWith(", ")) {
            result = result.substring(0, result.length() - 2);
        }

        return result;
    }

}
