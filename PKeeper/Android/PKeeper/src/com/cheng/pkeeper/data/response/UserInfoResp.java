package com.cheng.pkeeper.data.response;

import com.cheng.pkeeper.data.UserData;

public class UserInfoResp extends BasicResponse {
	
	private UserData data;
	public UserInfoResp(){
		
	}
	public UserData getData() {
		return data;
	}
	public void setData(UserData data) {
		this.data = data;
	}
	
}
