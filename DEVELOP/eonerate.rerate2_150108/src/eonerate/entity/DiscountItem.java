/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package eonerate.entity;

/**
 *
 * @author manucian86
 */
public class DiscountItem {
    
    public static final String FN_RESELLER_VERSION_ID = "RESELLER_VERSION_ID";
    public static final String FN_DISCOUNT_ITEM_ID = "DISCOUNT_ITEM_ID";
    public static final String FN_THRESHOLD = "THRESHOLD";
    public static final String FN_AMOUNT = "AMOUNT";
    public static final String FN_RUM_ID = "RUM_ID";
    public static final String FN_UA_ID = "UA_ID";
    public static final String FN_PERIOD = "PERIOD";
    //
    public Integer ResellerVersionId;
    public Integer DiscountItemId;
    public Integer Threshold;
    public Double Amount;
    public String RUMId;
    public Integer UsageActivityId;
    public String Period;
    //
    public Double MaxMoney;
    
}
