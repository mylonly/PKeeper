package com.cheng.pkeeper.data.request;


public class SaveFirstStageReq {
	private int cid;
	private String batchnum;
	private String daycontent;
	private String pic;
	private int day;
	public int getCid() {
		return cid;
	}
	public void setCid(int cid) {
		this.cid = cid;
	}
	public String getBatchnum() {
		return batchnum;
	}
	public void setBatchnum(String batchnum) {
		this.batchnum = batchnum;
	}
	public String getDaycontent() {
		return daycontent;
	}
	public void setDaycontent(String daycontent) {
		this.daycontent = daycontent;
	}
	public String getPic() {
		return pic;
	}
	public void setPic(String pic) {
		this.pic = pic;
	}
	public int getDay() {
		return day;
	}
	public void setDay(int day) {
		this.day = day;
	}
	
}
