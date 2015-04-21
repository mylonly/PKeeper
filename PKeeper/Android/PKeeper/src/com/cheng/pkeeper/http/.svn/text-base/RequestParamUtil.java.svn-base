package com.cheng.pkeeper.http;

import java.util.List;
import java.util.Map;

import com.cheng.pkeeper.AppConfig;
import com.cheng.pkeeper.data.CFactoryData;
import com.cheng.pkeeper.data.FirstStageData;
import com.cheng.pkeeper.data.request.BusinessInfoReq;
import com.cheng.pkeeper.data.request.CFactoryAddReq;
import com.cheng.pkeeper.data.request.FirstStageReq;
import com.cheng.pkeeper.data.request.HadKeepReq;
import com.cheng.pkeeper.data.request.HadReadReq;
import com.cheng.pkeeper.data.request.KeepTagReq;
import com.cheng.pkeeper.data.request.LoginReq;
import com.cheng.pkeeper.data.request.OnlyIdReq;
import com.cheng.pkeeper.data.request.RegisterReq;
import com.cheng.pkeeper.data.request.ReportInfoAddReq;
import com.cheng.pkeeper.data.request.ReportInfoReq;
import com.cheng.pkeeper.data.request.SaveFirstStageReq;
import com.cheng.pkeeper.data.request.SaveSecondStageReq;
import com.cheng.pkeeper.data.request.SaveThirdStageReq;
import com.cheng.pkeeper.data.request.UpyunDownloadReq;
import com.cheng.pkeeper.data.request.UserInfoReq;
import com.cheng.pkeeper.util.JsonUtil;


public class RequestParamUtil {

	public static Map getLoginRequestParam(String username, String password){
		LoginReq  reqData = new LoginReq(username,password);
		return JsonUtil.toMap(reqData);
	}
	
	public static Map getRegisterRequestParam(String username, String password){
		RegisterReq  reqData = new RegisterReq(username,password);
		return JsonUtil.toMap(reqData);
	}
	
	public static Map getUserInfoRequestParam(int userid, List<String> list, String path){
		UserInfoReq reqData = new UserInfoReq();
		reqData.setUserId(userid);
		reqData.setRealName(list.get(0));
		reqData.setGender(list.get(1));
		reqData.setAge(Integer.parseInt(list.get(2)));
		reqData.setMobile(list.get(3));
		reqData.setQq(list.get(4));
		reqData.setEmail(list.get(5));
		reqData.setAddress(list.get(7));
		reqData.setWorkyear(Integer.parseInt(list.get(8)));
		if (path !=""){
			reqData.setPicAddress(path);
		}
		if (list.get(6).contains(" ")) {
			String[] str = list.get(6).split(" ");
			reqData.setCity(str[1].replace("\0", ""));
			reqData.setProvince(str[0].replace("\0", ""));
		} else {
			reqData.setProvince(list.get(6).replace("\0", ""));
			reqData.setCity("");
		}
		return JsonUtil.toMap(reqData);
	}

	public static Map getCFactoryRequestParam(int factoryid, List<String> list){
		if (factoryid == -1) {
			CFactoryAddReq reqData = new CFactoryAddReq();
			reqData.setUserid(AppConfig.userid);
			reqData.setCfactoryName(list.get(0));
			reqData.setCfactoryAddress(list.get(1));
			reqData.setCfactoryScale(Integer.parseInt(list.get(2)));
			reqData.setCbuildTime(list.get(3));
			reqData.setCfactoryType(Integer.parseInt(list.get(4)));
			reqData.setCfactoryMode(Integer.parseInt(list.get(5)));
			reqData.setCroomType(Integer.parseInt(list.get(6)));
			reqData.setCwaterSupply(Integer.parseInt(list.get(7)));
			reqData.setCfoodSupply(Integer.parseInt(list.get(8)));
			reqData.setClearExcrement(Integer.parseInt(list.get(9)));
			reqData.setCgroupStyle(Integer.parseInt(list.get(10)));
			reqData.setPicnames(list.get(11));
			return JsonUtil.toMap(reqData);
		} else {
			CFactoryData reqData = new CFactoryData();
			reqData.setCfactoryId(factoryid);
			reqData.setCfactoryName(list.get(0));
			reqData.setCfactoryAddress(list.get(1));
			reqData.setCfactoryScale(Integer.parseInt(list.get(2)));
			reqData.setCbuildTime(list.get(3));
			reqData.setCfactoryType(Integer.parseInt(list.get(4)));
			reqData.setCfactoryMode(Integer.parseInt(list.get(5)));
			reqData.setCroomType(Integer.parseInt(list.get(6)));
			reqData.setCwaterSupply(Integer.parseInt(list.get(7)));
			reqData.setCfoodSupply(Integer.parseInt(list.get(8)));
			reqData.setClearExcrement(Integer.parseInt(list.get(9)));
			reqData.setCgroupStyle(Integer.parseInt(list.get(10)));
			reqData.setPicnames(list.get(11));
			return JsonUtil.toMap(reqData);
		}
		
		
	}
	public static Map getUpyunDownloadParam() {
		UpyunDownloadReq  reqData = new UpyunDownloadReq();
		reqData.set_id_(AppConfig.userid);
		return JsonUtil.toMap(reqData);
	}
	
	public static Map getBatchNumParam() {
		OnlyIdReq  reqData = new OnlyIdReq();
		reqData.setUserid(AppConfig.userid);
		return JsonUtil.toMap(reqData);
	}
	public static Map getFirstStageParam(String num,int page,int pagenum) {
		FirstStageReq reqData = new FirstStageReq();
		reqData.setPage(page);
		reqData.setPagenum(pagenum);
		reqData.setBatchnum(num);
		return JsonUtil.toMap(reqData);
	}
	public static Map getSaveFirstStageParam(String batchnum, String content, String pic, int day) {
		SaveFirstStageReq reqData = new SaveFirstStageReq();
		reqData.setCid(AppConfig.cfactoryid);
		reqData.setBatchnum(batchnum);
		reqData.setDaycontent(content);
		reqData.setPic(pic);
		reqData.setDay(day);
		return JsonUtil.toMap(reqData);
	}
	public static Map getSaveSecondStageParam(String batchnum, FirstStageData data) {
		SaveSecondStageReq reqData = new SaveSecondStageReq();
		reqData.setCid(AppConfig.cfactoryid);
		reqData.setBatchnum(batchnum);
		reqData.setDaycontent(data.getDaycontent());
		reqData.setPic(data.getPic());
		
		reqData.setVaccine(data.getVaccine());
		reqData.setHealthcare(data.getHealthcare());
		reqData.setDisinfect(data.getDisinfect());
		reqData.setOutinsect(data.getOutinsect());
		
		reqData.setEatfood(data.getEatfood());
		reqData.setEachweight(data.getEachweight());
		reqData.setDeadcount(data.getDeadcount());
		reqData.setWeedout(data.getWeedout());
		reqData.setTemperature(data.getTemperature());
		reqData.setHumidity(data.getHumidity());
		reqData.setSunning(data.getSunning());
		reqData.setAge(data.getAge());
		reqData.setDay(data.getDay());
		reqData.setEatwater(data.getEatwater());
		reqData.setVacname(data.getVacname());
		reqData.setVetdrug(data.getVetdrug());
		reqData.setDisoutectdesc(data.getDisoutectdesc());
		return JsonUtil.toMap(reqData);
	}
	public static Map getSaveThirdStageParam(String batchnum, FirstStageData data) {
		SaveThirdStageReq reqData = new SaveThirdStageReq();
		reqData.setCid(AppConfig.cfactoryid);
		reqData.setBatchnum(batchnum);
		reqData.setDaycontent(data.getDaycontent());
		reqData.setPic(data.getPic());
		
		reqData.setVaccine(data.getVaccine());
		reqData.setHealthcare(data.getHealthcare());
		reqData.setDisinfect(data.getDisinfect());
		reqData.setOutinsect(data.getOutinsect());
		reqData.setRecordtime(data.getRecordtime());
		return JsonUtil.toMap(reqData);
	}
	public static Map getScheduleParam(int stage,int day) {
		KeepTagReq reqData = new KeepTagReq();
		reqData.setStage(stage);
		reqData.setDay(day);
		return JsonUtil.toMap(reqData);
	}
	public static Map getHadKeepRequestParam(String batchnum) {
		HadKeepReq reqData = new HadKeepReq();
		reqData.setBatchnum(batchnum);
		return JsonUtil.toMap(reqData);
	}
	
	public static Map getNewReportRequestParam() {
		OnlyIdReq reqData = new OnlyIdReq();
		reqData.setUserid(AppConfig.userid);
		return JsonUtil.toMap(reqData);
	}
	
	public static Map getReportInfoRequestParam(int page,int pagenum) {
		ReportInfoReq reqData = new ReportInfoReq();
		reqData.setUserid(AppConfig.userid);
		reqData.setPage(page);
		reqData.setPagenum(pagenum);
		return JsonUtil.toMap(reqData);
	}

	public static Map getReportInfoAddRequestParam(String title,
			String detail, String file) {
		ReportInfoAddReq reqData = new ReportInfoAddReq();
		reqData.setUserid(AppConfig.userid);
		reqData.setTitle(title);
		reqData.setDesc(detail);
		reqData.setPic(file);
		return JsonUtil.toMap(reqData);
	}
	
	public static Map getHadReadRequestParam(int id) {
		HadReadReq reqData = new HadReadReq();
		reqData.setIllreportid(id);
		return JsonUtil.toMap(reqData);
	}
	
	public static Map getBusinessInfoRequestParam(int type,int page) {
		BusinessInfoReq reqData = new BusinessInfoReq();
		reqData.setType(type);
		reqData.setPage(page);
		reqData.setPagenum(10);
		return JsonUtil.toMap(reqData);
	}
}
