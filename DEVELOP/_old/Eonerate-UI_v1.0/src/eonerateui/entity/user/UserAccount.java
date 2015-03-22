package eonerateui.entity.user;

import java.util.Date;

public class UserAccount {
	private String username;
	private String password;
	private int role;
	private String createdBy;
	private Date updateTime;
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public int getRole() {
		return role;
	}
	public void setRole(int role) {
		this.role = role;
	}
	public String getCreatedBy() {
		return createdBy;
	}
	public void setCreatedBy(String createdBy) {
		this.createdBy = createdBy;
	}
	public Date getUpdateTime() {
		return updateTime;
	}
	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}
	public UserAccount(String username, String password, int role,
			String createdBy, Date updateTime) {
		super();
		this.username = username;
		this.password = password;
		this.role = role;
		this.createdBy = createdBy;
		this.updateTime = updateTime;
	}
	public UserAccount() {
		super();
	}
	
}
