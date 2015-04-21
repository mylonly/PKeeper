package com.cheng.pkeeper.data.response;

public class CopyOfReportInfoResp extends BasicResponse {
	
	private Boolean flag;
	private String str;
	private int im;
	
	public CopyOfReportInfoResp(){
		
	}
	
	public CopyOfReportInfoResp(Boolean flag) {
		
		this.flag = flag;
	}
	public Boolean getFlag() {
		return flag;
	}
	public void setFlag(Boolean flag) {
		this.flag = flag;
	}

	public String getStr() {
		return str;
	}

	public void setStr(String str) {
		this.str = str;
	}

	public int getIm() {
		return im;
	}

	public void setIm(int im) {
		this.im = im;
	}

	

}

