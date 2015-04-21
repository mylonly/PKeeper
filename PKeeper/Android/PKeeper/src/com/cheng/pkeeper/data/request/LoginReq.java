package com.cheng.pkeeper.data.request;

public class LoginReq {
	/** 用户 */
	private String username;
	
	/** 密码 */
	private String password;
	
	public LoginReq(){
		
	}
	
	public LoginReq(String user, String password){
		this.username = user;
		this.password = password; 
	}
	
	
	
	public String getUsername() {
		return username;
	}

	public void setUsername(String user) {
		this.username = user;
	}
	
	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}
	
}
