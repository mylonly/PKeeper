package com.cheng.pkeeper.data;

import java.io.Serializable;

public class FirstStageData implements Serializable{
	private int age;
	private int chickenbatchid;
	private int day;
	private int vaccine;
	private String daycontent;
	private int deadcount;
	private int disinfect;
	private float eachweight;
	private float eatfood;
	private int healthcare;
	private float humidity;
	private int id;
	private int outinsect;
	private String pic;
	
	private String recordtime;
	private int stage;
	private int sunning;
	private float temperature;
	private int weedout;
	
	private String vacname;
	private String vetdrug;
	private String disoutectdesc;
	private float eatwater;
	
	
	public String getVacname() {
		return vacname;
	}
	public void setVacname(String vacname) {
		this.vacname = vacname;
	}
	public String getVetdrug() {
		return vetdrug;
	}
	public void setVetdrug(String vetdrug) {
		this.vetdrug = vetdrug;
	}
	public String getDisoutectdesc() {
		return disoutectdesc;
	}
	public void setDisoutectdesc(String disoutectdesc) {
		this.disoutectdesc = disoutectdesc;
	}
	public float getEatwater() {
		return eatwater;
	}
	public void setEatwater(float eatwater) {
		this.eatwater = eatwater;
	}
	public String getRecordtime() {
		return recordtime;
	}
	public void setRecordtime(String recordtime) {
		this.recordtime = recordtime;
	}
	public int getStage() {
		return stage;
	}
	public void setStage(int stage) {
		this.stage = stage;
	}
	public int getSunning() {
		return sunning;
	}
	public void setSunning(int sunning) {
		this.sunning = sunning;
	}
	public float getTemperature() {
		return temperature;
	}
	public void setTemperature(float temperature) {
		this.temperature = temperature;
	}
	public int getWeedout() {
		return weedout;
	}
	public void setWeedout(int weedout) {
		this.weedout = weedout;
	}
	
	public int getChickenbatchid() {
		return chickenbatchid;
	}
	public void setChickenbatchid(int chickenbatchid) {
		this.chickenbatchid = chickenbatchid;
	}
	public int getDay() {
		return day;
	}
	public void setDay(int day) {
		this.day = day;
	}
	public String getDaycontent() {
		return daycontent;
	}
	public void setDaycontent(String daycontent) {
		this.daycontent = daycontent;
	}
	public int getDeadcount() {
		return deadcount;
	}
	public void setDeadcount(int deadcount) {
		this.deadcount = deadcount;
	}
	public int getDisinfect() {
		return disinfect;
	}
	public void setDisinfect(int disinfect) {
		this.disinfect = disinfect;
	}
	public float getEachweight() {
		return eachweight;
	}
	public void setEachweight(float eachweight) {
		this.eachweight = eachweight;
	}
	public float getEatfood() {
		return eatfood;
	}
	public void setEatfood(float eatfood) {
		this.eatfood = eatfood;
	}
	public int getHealthcare() {
		return healthcare;
	}
	public void setHealthcare(int healthcare) {
		this.healthcare = healthcare;
	}
	public float getHumidity() {
		return humidity;
	}
	public void setHumidity(float humidity) {
		this.humidity = humidity;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getOutinsect() {
		return outinsect;
	}
	public void setOutinsect(int outinsect) {
		this.outinsect = outinsect;
	}
	public String getPic() {
		return pic;
	}
	public void setPic(String pic) {
		this.pic = pic;
	}
	
	public int getAge() {
		return age;
	}
	public void setAge(int age) {
		this.age = age;
	}
	public int getVaccine() {
		return vaccine;
	}
	public void setVaccine(int vaccine) {
		this.vaccine = vaccine;
	}
}
