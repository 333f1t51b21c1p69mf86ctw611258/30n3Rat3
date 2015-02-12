package eonerateui.gui.menu.configuration;

public class ProcessConfig {

	private String name;
	private Boolean isActive;
	public String getName() {
		return name;
	}
	public Boolean getIsActive() {
		return isActive;
	}
	public void setName(String name) {
		this.name = name;
	}
	public void setIsActive(Boolean isActive) {
		this.isActive = isActive;
	}
	public void setIsActive(String isActive) {
		if("true".equalsIgnoreCase(isActive)){
			this.isActive = true;
		}else 
			this.isActive = false;
	}
	
	public ProcessConfig(){};
	public ProcessConfig(String name, Boolean isActive) {
		super();
		this.name = name;
		this.isActive = isActive;
	}
	
	
	
	
}
