package com.cheng.pkeeper.data.response;

public class HadKeepResp extends BasicResponse {
	private boolean isSubmit;
	public HadKeepResp(){
		
	}
	public boolean isSubmit() {
		return isSubmit;
	}
	public void setSubmit(boolean isSubmit) {
		this.isSubmit = isSubmit;
	}
}
