package com.cheng.pkeeper.data.response;

public class BasicResponse {

	private boolean result;

	/*返回码描述*/
	private String info;
	
	public BasicResponse() {
		
	}

	public BasicResponse(boolean result, String info) {
		this.result = result;
		this.info = info;
	}

	public boolean getResult() {
		return result;
	}

	public void setResult(boolean result) {
		this.result = result;
	}

	public String getInfo() {
		return info;
	}

	public void setInfo(String info) {
		this.info = info;
	}
}