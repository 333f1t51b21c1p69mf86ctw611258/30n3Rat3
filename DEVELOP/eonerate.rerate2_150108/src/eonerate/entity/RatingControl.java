/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package eonerate.entity;

import java.util.List;
import java.util.Map;

/**
 *
 * @author manucian86
 */
public class RatingControl {

    public String ProductID;
    public int CounterId;
    public double Threshold;
    public double ConsumeValue;
    public String Period;
    public int Priority;
    public boolean IsInternal;

    public static void addRatingControlToMap(List<RatingControl> map, String tmpProduct, int CounterId, double Threshold, double ConsumeValue, String Period, int Priority, boolean isInternal) {
        RatingControl tmpRatingControlItem;

        tmpRatingControlItem = new RatingControl();
        tmpRatingControlItem.ProductID = tmpProduct;
        tmpRatingControlItem.CounterId = CounterId;
        tmpRatingControlItem.Threshold = Threshold;
        tmpRatingControlItem.ConsumeValue = ConsumeValue;
        tmpRatingControlItem.Period = Period;
        tmpRatingControlItem.Priority = Priority;
        tmpRatingControlItem.IsInternal = isInternal;
        map.add(tmpRatingControlItem);
    }
}
