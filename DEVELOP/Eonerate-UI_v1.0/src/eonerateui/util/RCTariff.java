package eonerateui.util;

public class RCTariff {
	
	private Integer id;
	private Integer day;
	private Integer productId;
	private String productName;
	private Integer typeId;
	private String typeName;
	private Integer statusId;
	private String statusName;
	private Integer value;
	private Integer fullCycle;
	
	public Integer getId() {
		return this.id;
	}

	public void setId(Integer _Id) {
		this.id = _Id;
	}
	
	public Integer getDay() {
		return this.day;
	}

	public void setDay(Integer _day) {
		this.day = _day;
	}

	public Integer getProductId() {
		return this.productId;
	}

	public void setProductId(Integer _productId) {
		this.productId = _productId;
	}
	

	public String getProductName() {
		return this.productName;
	}

	public void setProductName(String _productName) {
		this.productName = _productName;
	}
	
	
	public Integer getTypeId() {
		return this.typeId;
	}

	public void setTypeId(Integer _typeId) {
		this.typeId = _typeId;
	}
	
	public String getTypeName() {
		return this.typeName;
	}

	public void setTypeName(String _typeName) {
		this.typeName = _typeName;
	}
	
	
	public Integer getStatusId() {
		return this.statusId;
	}

	public void setStatusId(Integer _statusId) {
		this.statusId = _statusId;
	}
	
	public String getStatusName() {
		return this.statusName;
	}

	public void setStatusName(String _statusName) {
		this.statusName = _statusName;
	}
	
	
	public Integer getValue() {
		return this.value;
	}

	public void setValue(Integer _value) {
		this.value = _value;
	}
	
	
	public Integer getFullCycle() {
		return this.fullCycle;
	}

	public void setFullCycle(Integer _fullCycle) {
		this.fullCycle = _fullCycle;
	}
	
	public RCTariff(Integer day, Integer productId,String productName, Integer typeId,String typeName, Integer statusId,String statusName, Integer value,Integer fullCycle, Integer Id) {
		super();
		
		this.day = day;
		this.productId = productId;
		this.productName=productName;
		this.typeId = typeId;
		this.typeName=typeName;
		this.statusId = statusId;
		this.statusName=statusName;
		this.value = value;
		this.fullCycle = fullCycle;
		this.id=Id;
	}
	public RCTariff(Integer day, Integer productId, Integer typeId, Integer statusId, Integer value,Integer fullCycle) {
		super();
		
		this.day = day;
		this.productId = productId;
		this.typeId = typeId;
		this.statusId = statusId;
		this.value = value;
		this.fullCycle = fullCycle;
		
	}
	public RCTariff(Integer day, Integer productId, Integer typeId, Integer statusId, Integer value,Integer fullCycle,Integer Id) {
		super();
		
		this.day = day;
		this.productId = productId;
		this.typeId = typeId;
		this.statusId = statusId;
		this.value = value;
		this.fullCycle = fullCycle;
		this.id=Id;
		
	}
	public RCTariff() {
		super();
	}
	
}


