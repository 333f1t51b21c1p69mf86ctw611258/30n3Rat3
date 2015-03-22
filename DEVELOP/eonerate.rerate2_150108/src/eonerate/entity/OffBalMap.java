package eonerate.entity;

import java.util.Date;

public class OffBalMap {

	public String balanceName;
	public Integer balanceId;
	public String offerName;
	public Integer offerId;
	public Integer resellerVersionId;
	public Integer balanceOrder;
	public Short isShadow;
	public Short isCore;
	public Date expirationDate;
	public Double minBalance;
	public Double maxBalance;
	public Short limitedConsumptionFlag;
	public Double limitedComsumptionAmount;
	public String expirationOption;
	public Integer defaultExpirationOffset;
	public Short isShared;
	public String defaultLimitType;
	public Double defaultLimitValue;
	public String defaultLimitPeriod;
	
	public Boolean isInternal;
	
}
