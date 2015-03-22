/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package eonerate.entity;

import java.util.List;

/**
 *
 * @author manucian86
 */
public class OffBalAwd {

    public static final String TIME_PERIOD_MONTHLY = "M";
    public static final String TIME_PERIOD_WEEKLY = "W";
    public static final String TIME_PERIOD_DAILY = "D";
    public static final String TIME_PERIOD_CALL = "C";
    //

    public Integer OfferRCAwardMapId;
    public Integer ResellerVersionId;
    public Integer OfferId;
    public Integer RCTermId;
    public Integer TermFromDate;
    public Integer TermToDate;
    public String TermLevelId;
    public Integer BalanceId;
    public String Period;
    public Double Amount;
    public Integer CurrencyCode;
    public Integer UnitTypeId;
    public String RUMId;
    public Boolean IsInternal;

    public static void addOfferBalanceAwardToMap(
	    List<OffBalAwd> map,
	    Integer OfferRCAwardMapId,
	    Integer ResellerVersionId,
	    Integer OfferId,
	    Integer RCTermId,
	    Integer TermFromDate,
	    Integer TermToDate,
	    String TermLevelId,
	    Integer BalanceId,
	    String Period,
	    Double Amount,
	    Integer CurrencyCode,
	    Integer UnitTypeId,
	    String RUMId,
	    Boolean IsInternal) {

	OffBalAwd aOfferBalanceAward = new OffBalAwd();

	aOfferBalanceAward.OfferRCAwardMapId = OfferRCAwardMapId;
	aOfferBalanceAward.ResellerVersionId = ResellerVersionId;
	aOfferBalanceAward.OfferId = OfferId;
	aOfferBalanceAward.RCTermId = RCTermId;
	aOfferBalanceAward.TermFromDate = TermFromDate;
	aOfferBalanceAward.TermToDate = TermToDate;
	aOfferBalanceAward.TermLevelId = TermLevelId;
	aOfferBalanceAward.BalanceId = BalanceId;
	aOfferBalanceAward.Period = Period;
	aOfferBalanceAward.Amount = Amount;
	aOfferBalanceAward.CurrencyCode = CurrencyCode;
	aOfferBalanceAward.UnitTypeId = UnitTypeId;
	aOfferBalanceAward.RUMId = RUMId;
	aOfferBalanceAward.IsInternal = IsInternal;

	map.add(aOfferBalanceAward);
    }

}
