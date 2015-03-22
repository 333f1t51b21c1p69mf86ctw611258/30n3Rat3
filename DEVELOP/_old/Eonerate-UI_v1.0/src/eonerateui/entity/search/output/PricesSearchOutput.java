package eonerateui.entity.search.output;

public class PricesSearchOutput {

	private String priceModel;
	private String step;
	private String tierFrom;
	private String tierTo;
	private String beat;
	private String factor;
	private String chargeBase;
	public String getPriceModel() {
		return priceModel;
	}
	public String getStep() {
		return step;
	}
	public String getTierFrom() {
		return tierFrom;
	}
	public String getTierTo() {
		return tierTo;
	}
	public String getBeat() {
		return beat;
	}
	public String getFactor() {
		return factor;
	}
	public String getChargeBase() {
		return chargeBase;
	}
	public void setPriceModel(String priceModel) {
		this.priceModel = priceModel;
	}
	public void setStep(String step) {
		this.step = step;
	}
	public void setTierFrom(String tierFrom) {
		this.tierFrom = tierFrom;
	}
	public void setTierTo(String tierTo) {
		this.tierTo = tierTo;
	}
	public void setBeat(String beat) {
		this.beat = beat;
	}
	public void setFactor(String factor) {
		this.factor = factor;
	}
	public void setChargeBase(String chargeBase) {
		this.chargeBase = chargeBase;
	}
	public PricesSearchOutput(String priceModel, String step, String tierFrom,
			String tierTo, String beat, String factor, String chargeBase) {
		super();
		this.priceModel = priceModel;
		this.step = step;
		this.tierFrom = tierFrom;
		this.tierTo = tierTo;
		this.beat = beat;
		this.factor = factor;
		this.chargeBase = chargeBase;
	}
	public PricesSearchOutput() {
		super();
	}
	
}
