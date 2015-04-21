package com.cheng.pkeeper.http;

public class RequestAddress {

	public enum Address {
		LOGIN,
		REGISTER,
		SAVECFACTORY,
		UPDATECFACTORY,
		
		BATCHNUM,
		TAG,
		FIRSTSTAGE,
		SECONDSTAGE,
		THIRDSTAGE,
		SAVEFIRSTSTAGE,
		SAVESECONDSTAG,
		SAVETHIRDSTAG,
		SCHEDULE,
		
		REPORTINFO,
		SAVEREPORTINFO,
		NEWREPORT,
		HADREAD,
		
		HADKEEP,
		
		USERINFO,
		UD,
		BUSINESSINFO
	}

	public static String getBaseUrl() {
		StringBuffer sb = new StringBuffer();
		sb.append("http://121.43.225.133:8080/");
		return sb.toString();
	}

	private static String getAddress(Address addressName) {
		String result = "";

		switch (addressName) {
		case LOGIN:
			result = "chkplatform/front/logindao.do";
			break;
		case REGISTER:
			result = "chkplatform/page/system/register.do";
			break;
		case SAVECFACTORY:
			result = "chkplatform/chickenfactroycontroller/saveChickenFactroyInfo.do";
			break;
		case UPDATECFACTORY:
			result = "chkplatform/chickenfactroycontroller/updateCfactoryInfo.do";
			break;	
		case BATCHNUM:
			result = "chkplatform/chickenbatchnum/saveChickenBatchNum.do";
			break;
		case TAG:
			result = "chkplatform/chickenbatchnum/getstagebybatchnum.do";
			break;
		case SCHEDULE:
			result = "chkplatform/standarflow/getStandarByStageAndDay.do";
			break;
		case FIRSTSTAGE:
			result = "chkplatform/everydayrecord/getFirstStageRecord.do";
			break;
		case SECONDSTAGE:
			result = "chkplatform/everydayrecord/getSecondStageRecord.do";
			break;
		case THIRDSTAGE:
			result = "chkplatform/everydayrecord/getThirdStageRecord.do";
			break;
			
		case SAVEFIRSTSTAGE:
			result = "chkplatform/everydayrecord/saveFirstStageDayRecord.do";
			break;
		case SAVESECONDSTAG:
			result = "chkplatform/everydayrecord/saveSecondStageDayRecord.do";
			break;
		case SAVETHIRDSTAG:
			result = "chkplatform/everydayrecord/saveThirdStageDayRecord.do";
			break;
			
		case REPORTINFO:
			result = "chkplatform/illreport/getIllReport.do";
			break;
		case SAVEREPORTINFO:
			result = "chkplatform/illreport/saveIllReport.do";
			break;
		case NEWREPORT:
			result = "chkplatform/illreport/getNewReplyIllReportCount.do";
			break;
		case HADREAD:
			result = "chkplatform/illreport/readIllReport.do";
			break;
			
		case HADKEEP:
			result = "chkplatform/everydayrecord/validRecordSubmit.do";
			break;	
			
		case USERINFO:
			result = "chkplatform/page/system/updateUser.do";
			break;
		case UD:
			result = "http://pk-image.b0.upaiyun.com";
			break;
		case BUSINESSINFO:
			result = "chkplatform/page/manager/getDocuments.do";
			break;	
			
		default:
			break;
		}
 
		return result;
	}
	public static String getLoginCodeUrl() 
	{
		StringBuffer sb = new StringBuffer();
		sb.append(getBaseUrl()).append(getAddress(Address.LOGIN));
		return sb.toString();
	}
	public static String getRegisterCodeUrl()
	{
		StringBuffer sb = new StringBuffer();
		sb.append(getBaseUrl()).append(getAddress(Address.REGISTER));
		return sb.toString();
	}
	public static String getUserInfoCodeUrl()
	{
		StringBuffer sb = new StringBuffer();
		sb.append(getBaseUrl()).append(getAddress(Address.USERINFO));
		return sb.toString();
	}
	public static String getSaveCFactoryCodeUrl()
	{
		StringBuffer sb = new StringBuffer();
		sb.append(getBaseUrl()).append(getAddress(Address.SAVECFACTORY));
		return sb.toString();
	}
	public static String getUpdateCFactoryCodeUrl()
	{
		StringBuffer sb = new StringBuffer();
		sb.append(getBaseUrl()).append(getAddress(Address.UPDATECFACTORY));
		return sb.toString();
	}
	
	
	public static String getUpyunDownloadUrl() 
	{
		StringBuffer sb = new StringBuffer();
		sb.append(getAddress(Address.UD));
		return sb.toString();
	}
	public static String getBatchNumUrl() 
	{
		StringBuffer sb = new StringBuffer();
		sb.append(getBaseUrl()).append(getAddress(Address.BATCHNUM));
		return sb.toString();
	}
	public static String getTagUrl() 
	{
		StringBuffer sb = new StringBuffer();
		sb.append(getBaseUrl()).append(getAddress(Address.TAG));
		return sb.toString();
	}
	public static String getFirstStageUrl() 
	{
		StringBuffer sb = new StringBuffer();
		sb.append(getBaseUrl()).append(getAddress(Address.FIRSTSTAGE));
		return sb.toString();
	}
	public static String getSecondStageUrl() {
		StringBuffer sb = new StringBuffer();
		sb.append(getBaseUrl()).append(getAddress(Address.SECONDSTAGE));
		return sb.toString();
	}
	public static String getThirdStageUrl() {
		StringBuffer sb = new StringBuffer();
		sb.append(getBaseUrl()).append(getAddress(Address.THIRDSTAGE));
		return sb.toString();
	}
	public static String getSaveFirstStageUrl() 
	{
		StringBuffer sb = new StringBuffer();
		sb.append(getBaseUrl()).append(getAddress(Address.SAVEFIRSTSTAGE));
		return sb.toString();
	}
	public static String getSaveSecondStageUrl() 
	{
		StringBuffer sb = new StringBuffer();
		sb.append(getBaseUrl()).append(getAddress(Address.SAVESECONDSTAG));
		return sb.toString();
	}
	public static String getSaveThirdStageUrl() 
	{
		StringBuffer sb = new StringBuffer();
		sb.append(getBaseUrl()).append(getAddress(Address.SAVETHIRDSTAG));
		return sb.toString();
	}
	public static String getScheduleUrl() 
	{
		StringBuffer sb = new StringBuffer();
		sb.append(getBaseUrl()).append(getAddress(Address.SCHEDULE));
		return sb.toString();
	}
	
	
	public static String getReportInfoUrl() 
	{
		StringBuffer sb = new StringBuffer();
		sb.append(getBaseUrl()).append(getAddress(Address.REPORTINFO));
		return sb.toString();
	}
	
	public static String getSaveReportinfoUrl() 
	{
		StringBuffer sb = new StringBuffer();
		sb.append(getBaseUrl()).append(getAddress(Address.SAVEREPORTINFO));
		return sb.toString();
	}
	public static String getNewReportUrl() 
	{
		StringBuffer sb = new StringBuffer();
		sb.append(getBaseUrl()).append(getAddress(Address.NEWREPORT));
		return sb.toString();
	}
	public static String getHadReadUrl() 
	{
		StringBuffer sb = new StringBuffer();
		sb.append(getBaseUrl()).append(getAddress(Address.HADREAD));
		return sb.toString();
	}
	
	public static String getHadKeepCodeUrl() 
	{
		StringBuffer sb = new StringBuffer();
		sb.append(getBaseUrl()).append(getAddress(Address.HADKEEP));
		return sb.toString();
	}
	
	public static String getBusinessInfoUrl() 
	{
		StringBuffer sb = new StringBuffer();
		sb.append(getBaseUrl()).append(getAddress(Address.BUSINESSINFO));
		return sb.toString();
	}
}
