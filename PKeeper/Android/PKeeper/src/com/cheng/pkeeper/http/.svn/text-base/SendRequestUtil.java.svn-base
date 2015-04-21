package com.cheng.pkeeper.http;

import java.util.List;

import com.android.volley.Request;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.cheng.pkeeper.PKeeperApplication;
import com.cheng.pkeeper.data.CFactoryData;
import com.cheng.pkeeper.data.FirstStageData;
import com.cheng.pkeeper.data.request.SaveFirstStageReq;
import com.cheng.pkeeper.data.response.BasicResponse;
import com.cheng.pkeeper.data.response.BatchNumResp;
import com.cheng.pkeeper.data.response.BusinessInfoResp;
import com.cheng.pkeeper.data.response.CFactoryInfoResp;
import com.cheng.pkeeper.data.response.FirstStageResp;
import com.cheng.pkeeper.data.response.HadKeepResp;
import com.cheng.pkeeper.data.response.HadReadResp;
import com.cheng.pkeeper.data.response.LoginResp;
import com.cheng.pkeeper.data.response.NewReportResp;
import com.cheng.pkeeper.data.response.RegisterResp;
import com.cheng.pkeeper.data.response.ReportInfoResp;
import com.cheng.pkeeper.data.response.ScheduleResp;
import com.cheng.pkeeper.data.response.UserInfoResp;

import android.net.Uri;
import android.os.Handler;
import android.util.Log;

public class SendRequestUtil {
	public static final String TAG = "SendRequestUtil";

	/**
	 * 以下是所有请求对应的TAG
	 */
	
	public static final String TAG_LOGINREQUEST_REQUEST = "loginRequest";
	public static final String TAG_USERINFO_REQUEST = "userinfoRequest";
	public static final String TAG_KEEPINFO_REQUEST = "keepinfoRequest";
	public static final String TAG_CFACTORYINFO_REQUEST = "cfactoryinfoRequest";
	public static final String TAG_MAIN_REQUEST = "mainRequest";
	public static final String TAG_SAVEKEEPINFO_REQUEST = "savekeepinfoRequest";
	public static final String TAG_REPORTINFO_REQUEST = "reportinfoRequest";
	public static final String TAG_REMEND_REQUEST = "remendRequest";
	public static final String TAG_REPORTINFOADD_REQUEST = "reportinfoaddRequest";
	public static final String TAG_REPORTREAD_REQUEST = "reportreadRequest";
	public static final String TAG_BUSINESSINFO_REQUEST = "businessinfoRequest";
	
	public static final int HTTP_REQUEST = 0x100;
	public static final int HTTP_REQUEST_FAIL = 0x200;
	
	public static final int HTTP_REGISTER_REQUEST = 0x101;
	public static final int HTTP_REGISTER_REQUEST_FAIL = 0x202;
	
	public static final int HTTP_REGISTER_REQUEST_UPDATEUSER = 0x111;
	public static final int HTTP_REGISTER_REQUEST_UPDATEHOUSE = 0x121;
	
	public static final int HTTP_IMAGE_REQUEST = 0x131;
	public static final int HTTP_IMAGE_REQUEST_FAIL = 0x141;
	
	public static final int HTTP_BATCHNUM_REQUEST = 0x151;
//	public static final int HTTP_TAGNUM_REQUEST = 0x161;
	public static final int HTTP_FIRSTSTAGE_REQUEST = 0x171;
	public static final int HTTP_SECONDSTAGE_REQUEST = 0x181;
	public static final int HTTP_THIRDSTAGE_REQUEST = 0x191;
	public static final int HTTP_SCHEDULE_REQUEST = 0x211;

	public static final int HTTP_REMEND_KEEP_REQUEST = 0x221;
	public static final int HTTP_REMEND_NEWS_REQUEST = 0x231;

	

	
	
	private static String TEMPERATURE = "1";
	private static String HUMIDITY = "2";
	private static String CONTAMINATION = "3";
	
	
	/*private static FastJsonRequest<GpsInfoResp> gpsInfoRequest;

	private static FastJsonRequest<SmokesensorResp> smokesensorRequest;

	private static FastJsonRequest<HomepageResp> homepageRequest;

	private static FastJsonRequest<VoiceResp> voiceRequest;
	private static FastJsonRequest<DeviceControlResp> deviceControlRequest;
	private static FastJsonRequest<DeviceControlInfoResp> deviceControlInfoRequest;
	private static FastJsonRequest<EnvironmentOverviewResp> environmentOverviewRequest;
	private static FastJsonRequest<EntranceguardResp> entranceguardRequest;*/
	private static FastJsonRequest<LoginResp> loginRequest;
	private static FastJsonRequest<RegisterResp> registerRequest;
	private static FastJsonRequest<UserInfoResp> userinfoRequest;
	private static FastJsonRequest<CFactoryInfoResp> cfactoryRequest;
	private static FastJsonRequest<BatchNumResp> keepinfobatchRequest;
	private static FastJsonRequest<ScheduleResp> keepinfotagRequest;
	private static FastJsonRequest<FirstStageResp> firststageRequest;
	private static FastJsonRequest<BasicResponse> savefirststageRequest;
	private static FastJsonRequest<HadKeepResp> hadkeepRespRequest;
	private static FastJsonRequest<NewReportResp> newreportRespRequest;
	private static FastJsonRequest<ReportInfoResp> reportinfotagRequest;
	private static FastJsonRequest<BasicResponse> reportinfoaddRequest;
	private static FastJsonRequest<HadReadResp> reportreadRequest;
	private static FastJsonRequest<BusinessInfoResp> businessinfoRequest;
	
	public static Handler mainHandler;
	public static Handler userinfoHandler;
	public static Handler loginHandler;
	public static Handler cfactoryHandler;
	public static Handler keepinfoHandler;
	public static Handler savekeepinfoHandler;
	public static Handler reportinfoHandler;
	public static Handler reportinfoaddHandler;
	public static Handler reportreadHandler;
	public static Handler businessinfoHandler;


	
	public static void makeLoginRequest(String userNameValue, String passWordValue) {
		String url = RequestAddress.getLoginCodeUrl();
		Uri.Builder builder = Uri.parse(url).buildUpon();
//		builder.appendQueryParameter("username", userNameValue);
//		builder.appendQueryParameter("password", passWordValue);
		Log.i(TAG, "获取登入请求:" + RequestParamUtil.getLoginRequestParam(userNameValue, passWordValue));
		loginRequest = new FastJsonRequest<LoginResp>(
				Request.Method.POST,
				builder.toString(),
				LoginResp.class,
				RequestParamUtil.getLoginRequestParam(userNameValue, passWordValue),
				new Response.Listener<LoginResp>() {
					@Override
					public void onResponse(LoginResp response) {
						Log.i(TAG, "登入请求...... ok...");
						loginHandler.sendMessage(loginHandler.obtainMessage(HTTP_REQUEST,response));
					}
				},
				new Response.ErrorListener() {
					@Override
					public void onErrorResponse(VolleyError error) {
						Log.i(TAG, "登入请求:" + error.getMessage());
						loginHandler.sendMessage(loginHandler.obtainMessage(HTTP_REQUEST_FAIL,null));
					}
				});
		PKeeperApplication.getInstance().addRequestQueue(loginRequest,
				TAG_LOGINREQUEST_REQUEST);

	}

	
	public static void makeRegisterRequest(String userNameValue, String passWordValue) {
		String url = RequestAddress.getRegisterCodeUrl();
		Uri.Builder builder = Uri.parse(url).buildUpon();
		
//		builder.appendQueryParameter("username", userNameValue);
//		builder.appendQueryParameter("password", passWordValue);
		Log.i(TAG, "获取注册请求:" + RequestParamUtil.getRegisterRequestParam(userNameValue, passWordValue));
		registerRequest = new FastJsonRequest<RegisterResp>(
				Request.Method.POST,
				builder.toString(),
				RegisterResp.class,
				RequestParamUtil.getRegisterRequestParam(userNameValue, passWordValue),
				new Response.Listener<RegisterResp>() {
					@Override
					public void onResponse(RegisterResp response) {
						Log.i(TAG, "注册请求...... ok...");
						loginHandler.sendMessage(loginHandler.obtainMessage(HTTP_REGISTER_REQUEST,response));
					}
				},
				new Response.ErrorListener() {
					@Override
					public void onErrorResponse(VolleyError error) {
						Log.i(TAG, "注册请求:" + error.getMessage());
						loginHandler.sendMessage(loginHandler.obtainMessage(HTTP_REGISTER_REQUEST_FAIL,null));
					
					}
				});
		PKeeperApplication.getInstance().addRequestQueue(registerRequest,
				TAG_LOGINREQUEST_REQUEST);

	}
	
	public static void makeHadKeepRequest(String batchnum) {
		String url = RequestAddress.getHadKeepCodeUrl();
		Uri.Builder builder = Uri.parse(url).buildUpon();
		
		Log.i(TAG, "是否提交报告请求:" + RequestParamUtil.getHadKeepRequestParam(batchnum));
		hadkeepRespRequest = new FastJsonRequest<HadKeepResp>(
				Request.Method.POST,
				builder.toString(),
				HadKeepResp.class,
				RequestParamUtil.getHadKeepRequestParam(batchnum),
				new Response.Listener<HadKeepResp>() {
					@Override
					public void onResponse(HadKeepResp response) {
						Log.i(TAG, "是否提交报告请求...... ok...");
						mainHandler.sendMessage(mainHandler.obtainMessage(HTTP_REMEND_KEEP_REQUEST,response));
					}
				},
				new Response.ErrorListener() {
					@Override
					public void onErrorResponse(VolleyError error) {
						Log.i(TAG, "是否提交报告失败:" + error.getMessage()+error.getCause());
						mainHandler.sendMessage(mainHandler.obtainMessage(HTTP_REQUEST_FAIL,null));
					}
				});
		PKeeperApplication.getInstance().addRequestQueue(hadkeepRespRequest,
				TAG_REMEND_REQUEST);

	}
	
	public static void makeNewReportRequest() {
		String url = RequestAddress.getNewReportUrl();
		Uri.Builder builder = Uri.parse(url).buildUpon();
		
		Log.i(TAG, "是否有回复请求:" + RequestParamUtil.getNewReportRequestParam());
		newreportRespRequest = new FastJsonRequest<NewReportResp>(
				Request.Method.POST,
				builder.toString(),
				NewReportResp.class,
				RequestParamUtil.getNewReportRequestParam(),
				new Response.Listener<NewReportResp>() {
					@Override
					public void onResponse(NewReportResp response) {
						Log.i(TAG, "是否有回复请求...... ok...");
						mainHandler.sendMessage(mainHandler.obtainMessage(HTTP_REMEND_NEWS_REQUEST,response));
					}
				},
				new Response.ErrorListener() {
					@Override
					public void onErrorResponse(VolleyError error) {
						Log.i(TAG, "是否有回复请求失败:" + error.getMessage()+error.getCause());
						mainHandler.sendMessage(mainHandler.obtainMessage(HTTP_REQUEST_FAIL,null));
					}
				});
		PKeeperApplication.getInstance().addRequestQueue(newreportRespRequest,
				TAG_REMEND_REQUEST);

	}
	
	public static void makeUserInfoRequest(int user, List<String> list, String path) {
		String url = RequestAddress.getUserInfoCodeUrl();
		Uri.Builder builder = Uri.parse(url).buildUpon();
		
		Log.i(TAG, "更改用户信息请求:" + RequestParamUtil.getUserInfoRequestParam(user, list, path));
		userinfoRequest = new FastJsonRequest<UserInfoResp>(
				Request.Method.POST,
				builder.toString(),
				UserInfoResp.class,
				RequestParamUtil.getUserInfoRequestParam(user,list,path),
				new Response.Listener<UserInfoResp>() {
					@Override
					public void onResponse(UserInfoResp response) {
						Log.i(TAG, "更改用户信息请求...... ok...");
						userinfoHandler.sendMessage(userinfoHandler.obtainMessage(HTTP_REQUEST,response));
					}
				},
				new Response.ErrorListener() {
					@Override
					public void onErrorResponse(VolleyError error) {
						Log.i(TAG, "更改用户信息请求失败:" + error.getMessage()+error.getCause());
						userinfoHandler.sendMessage(userinfoHandler.obtainMessage(HTTP_REQUEST_FAIL,null));
					}
				});
		PKeeperApplication.getInstance().addRequestQueue(userinfoRequest,
				TAG_USERINFO_REQUEST);

	}
	
	public static void makeCFactoryRequest(int userid, List<String> list) {
		String url;
		if (userid == -1) {
			url = RequestAddress.getSaveCFactoryCodeUrl();
		} else {
			url = RequestAddress.getUpdateCFactoryCodeUrl();
		}
		
		Uri.Builder builder = Uri.parse(url).buildUpon();

		Log.i(TAG, "鸡场信息请求:" + RequestParamUtil.getCFactoryRequestParam(userid,list));

		cfactoryRequest = new FastJsonRequest<CFactoryInfoResp>(
				Request.Method.POST, builder.toString(),
				CFactoryInfoResp.class,
				RequestParamUtil.getCFactoryRequestParam(userid,list),
				new Response.Listener<CFactoryInfoResp>() {
					@Override
					public void onResponse(CFactoryInfoResp response) {
						Log.i(TAG, "鸡场信息请求...... ok...");
						cfactoryHandler.sendMessage(cfactoryHandler.obtainMessage(
								HTTP_REQUEST, response));
						
					}
				}, new Response.ErrorListener() {
					@Override
					public void onErrorResponse(VolleyError error) {
						Log.i(TAG, "鸡场信息请求失败:" + error.getMessage());
						cfactoryHandler.sendMessage(cfactoryHandler.obtainMessage(
								HTTP_REQUEST_FAIL, null));

					}
				});
		PKeeperApplication.getInstance().addRequestQueue(cfactoryRequest,
				TAG_CFACTORYINFO_REQUEST);
	}
	
	public static void makeBatchNumRequest() {
		String url = RequestAddress.getBatchNumUrl();
		
		Uri.Builder builder = Uri.parse(url).buildUpon();
		Log.i(TAG, "鸡场批次请求:" + RequestParamUtil.getBatchNumParam());

		keepinfobatchRequest = new FastJsonRequest<BatchNumResp>(
				Request.Method.POST, builder.toString(),
				BatchNumResp.class,
				RequestParamUtil.getBatchNumParam(),
				new Response.Listener<BatchNumResp>() {
					@Override
					public void onResponse(BatchNumResp response) {
						Log.i(TAG, "鸡场批次请求...... ok...");
						keepinfoHandler.sendMessage(keepinfoHandler.obtainMessage(
								HTTP_BATCHNUM_REQUEST, response));
						
					}
				}, new Response.ErrorListener() {
					@Override
					public void onErrorResponse(VolleyError error) {
						Log.i(TAG, "鸡场批次请求失败:" + error.getMessage());
						keepinfoHandler.sendMessage(keepinfoHandler.obtainMessage(
								HTTP_REQUEST_FAIL, null));

					}
				});
		PKeeperApplication.getInstance().addRequestQueue(keepinfobatchRequest,
				TAG_KEEPINFO_REQUEST);
	}
	
	/*public static void makeTagRequest(String num) {
		String url = RequestAddress.getTagUrl();
		
		Uri.Builder builder = Uri.parse(url).buildUpon();
		Log.i(TAG, "鸡场阶段请求:" + RequestParamUtil.getTagParam(num));

		keepinfotagRequest = new FastJsonRequest<TagNumResp>(
				Request.Method.POST, builder.toString(),
				TagNumResp.class,
				RequestParamUtil.getTagParam(num),
				new Response.Listener<TagNumResp>() {
					@Override
					public void onResponse(TagNumResp response) {
						Log.i(TAG, "鸡场阶段请求...... ok...");
						keepinfoHandler.sendMessage(keepinfoHandler.obtainMessage(
								HTTP_TAGNUM_REQUEST, response));
						
					}
				}, new Response.ErrorListener() {
					@Override
					public void onErrorResponse(VolleyError error) {
						Log.i(TAG, "鸡场阶段请求失败:" + error.getMessage());
						keepinfoHandler.sendMessage(keepinfoHandler.obtainMessage(
								HTTP_REQUEST_FAIL, null));

					}
				});
		PKeeperApplication.getInstance().addRequestQueue(keepinfotagRequest,
				TAG_KEEPINFO_REQUEST);
	}*/
	
	public static void makeFirstStageRequest(String batchnum) {
		String url = RequestAddress.getFirstStageUrl();
		
		Uri.Builder builder = Uri.parse(url).buildUpon();
		Log.i(TAG, "第一阶段请求:" + RequestParamUtil.getFirstStageParam(batchnum,1,15));

		firststageRequest = new FastJsonRequest<FirstStageResp>(
				Request.Method.POST, builder.toString(),
				FirstStageResp.class,
				RequestParamUtil.getFirstStageParam(batchnum,1,15),
				new Response.Listener<FirstStageResp>() {
					@Override
					public void onResponse(FirstStageResp response) {
						Log.i(TAG, "第一阶段请求...... ok...");
						keepinfoHandler.sendMessage(keepinfoHandler.obtainMessage(
								HTTP_FIRSTSTAGE_REQUEST, response));
						
					}
				}, new Response.ErrorListener() {
					@Override
					public void onErrorResponse(VolleyError error) {
						Log.i(TAG, "第一阶段请求失败:" + error.getMessage());
						keepinfoHandler.sendMessage(keepinfoHandler.obtainMessage(
								HTTP_REQUEST_FAIL, null));

					}
				});
		PKeeperApplication.getInstance().addRequestQueue(firststageRequest,
				TAG_KEEPINFO_REQUEST);
		
	}
	public static void makeSecondStageRequest(String batchnum) {
		String url = RequestAddress.getSecondStageUrl();
		
		Uri.Builder builder = Uri.parse(url).buildUpon();
		Log.i(TAG, "第二阶段请求请求:" + RequestParamUtil.getFirstStageParam(batchnum,1,48));

		firststageRequest = new FastJsonRequest<FirstStageResp>(
				Request.Method.POST, builder.toString(),
				FirstStageResp.class,
				RequestParamUtil.getFirstStageParam(batchnum,1,48),
				new Response.Listener<FirstStageResp>() {
					@Override
					public void onResponse(FirstStageResp response) {
						Log.i(TAG, "第二阶段请求...... ok...");
						keepinfoHandler.sendMessage(keepinfoHandler.obtainMessage(
								HTTP_SECONDSTAGE_REQUEST, response));
						
					}
				}, new Response.ErrorListener() {
					@Override
					public void onErrorResponse(VolleyError error) {
						Log.i(TAG, "第二阶段请求失败:" + error.getMessage());
						keepinfoHandler.sendMessage(keepinfoHandler.obtainMessage(
								HTTP_REQUEST_FAIL, null));

					}
				});
		PKeeperApplication.getInstance().addRequestQueue(firststageRequest,
				TAG_KEEPINFO_REQUEST);
		
	}
	public static void makeThirdStageRequest(String batchnum,int page) {
		String url = RequestAddress.getThirdStageUrl();
		
		Uri.Builder builder = Uri.parse(url).buildUpon();
		Log.i(TAG, "第三阶段请求:" + RequestParamUtil.getFirstStageParam(batchnum,page,15));

		firststageRequest = new FastJsonRequest<FirstStageResp>(
				Request.Method.POST, builder.toString(),
				FirstStageResp.class,
				RequestParamUtil.getFirstStageParam(batchnum,page,15),
				new Response.Listener<FirstStageResp>() {
					@Override
					public void onResponse(FirstStageResp response) {
						Log.i(TAG, "第三阶段请求...... ok...");
						keepinfoHandler.sendMessage(keepinfoHandler.obtainMessage(
								HTTP_THIRDSTAGE_REQUEST, response));
						
					}
				}, new Response.ErrorListener() {
					@Override
					public void onErrorResponse(VolleyError error) {
						Log.i(TAG, "第三阶段请求失败:" + error.getMessage());
						keepinfoHandler.sendMessage(keepinfoHandler.obtainMessage(
								HTTP_REQUEST_FAIL, null));

					}
				});
		PKeeperApplication.getInstance().addRequestQueue(firststageRequest,
				TAG_KEEPINFO_REQUEST);
		
	}
	
	public static void makeSaveFirstStageRequest(String batchnum,String content,String path,int day) {
		String url = RequestAddress.getSaveFirstStageUrl();
		
		Uri.Builder builder = Uri.parse(url).buildUpon();
		Log.i(TAG, "保存第一阶段请求:" + RequestParamUtil.getSaveFirstStageParam(batchnum,content,path,day));

		savefirststageRequest = new FastJsonRequest<BasicResponse>(
				Request.Method.POST, builder.toString(),
				BasicResponse.class,
				RequestParamUtil.getSaveFirstStageParam(batchnum,content,path,day),
				new Response.Listener<BasicResponse>() {
					@Override
					public void onResponse(BasicResponse response) {
						Log.i(TAG, "保存第一阶段请求...... ok...");
						savekeepinfoHandler.sendMessage(savekeepinfoHandler.obtainMessage(
								HTTP_REQUEST, response));
						
					}
				}, new Response.ErrorListener() {
					@Override
					public void onErrorResponse(VolleyError error) {
						Log.i(TAG, "保存第一阶段请求失败:" + error.getMessage());
						savekeepinfoHandler.sendMessage(savekeepinfoHandler.obtainMessage(
								HTTP_REQUEST_FAIL, null));

					}
				});
		PKeeperApplication.getInstance().addRequestQueue(savefirststageRequest,
				TAG_SAVEKEEPINFO_REQUEST);
		
	}
	public static void makeSaveSecondStageRequest(String batchnum, FirstStageData date) {
		String url = RequestAddress.getSaveSecondStageUrl();
		
		Uri.Builder builder = Uri.parse(url).buildUpon();
		Log.i(TAG, "保存第二阶段请求:" + RequestParamUtil.getSaveSecondStageParam(batchnum,date));

		savefirststageRequest = new FastJsonRequest<BasicResponse>(
				Request.Method.POST, builder.toString(),
				BasicResponse.class,
				RequestParamUtil.getSaveSecondStageParam(batchnum,date),
				new Response.Listener<BasicResponse>() {
					@Override
					public void onResponse(BasicResponse response) {
						Log.i(TAG, "保存第二阶段请求...... ok...");
						savekeepinfoHandler.sendMessage(savekeepinfoHandler.obtainMessage(
								HTTP_REQUEST, response));
						
					}
				}, new Response.ErrorListener() {
					@Override
					public void onErrorResponse(VolleyError error) {
						Log.i(TAG, "保存第二阶段请求失败:" + error.getMessage());
						savekeepinfoHandler.sendMessage(savekeepinfoHandler.obtainMessage(
								HTTP_REQUEST_FAIL, null));

					}
				});
		PKeeperApplication.getInstance().addRequestQueue(savefirststageRequest,
				TAG_SAVEKEEPINFO_REQUEST);
		
	}
	public static void makeSaveThirdStageRequest(String batchnum,FirstStageData date) {
		String url = RequestAddress.getSaveThirdStageUrl();
		
		Uri.Builder builder = Uri.parse(url).buildUpon();
		Log.i(TAG, "保存第三阶段请求:" + RequestParamUtil.getSaveThirdStageParam(batchnum,date));

		savefirststageRequest = new FastJsonRequest<BasicResponse>(
				Request.Method.POST, builder.toString(),
				BasicResponse.class,
				RequestParamUtil.getSaveThirdStageParam(batchnum,date),
				new Response.Listener<BasicResponse>() {
					@Override
					public void onResponse(BasicResponse response) {
						Log.i(TAG, "保存第三阶段请求...... ok...");
						savekeepinfoHandler.sendMessage(savekeepinfoHandler.obtainMessage(
								HTTP_REQUEST, response));
						
					}
				}, new Response.ErrorListener() {
					@Override
					public void onErrorResponse(VolleyError error) {
						Log.i(TAG, "保存第三阶段请求失败:" + error.getMessage());
						savekeepinfoHandler.sendMessage(savekeepinfoHandler.obtainMessage(
								HTTP_REQUEST_FAIL, null));

					}
				});
		PKeeperApplication.getInstance().addRequestQueue(savefirststageRequest,
				TAG_SAVEKEEPINFO_REQUEST);
		
	}
	
	public static void makeScheduleRequest(int stage,int day) {
		String url = RequestAddress.getScheduleUrl();
		
		Uri.Builder builder = Uri.parse(url).buildUpon();
		Log.i(TAG, "日常安排请求:" + RequestParamUtil.getScheduleParam(stage, day));

		keepinfotagRequest = new FastJsonRequest<ScheduleResp>(
				Request.Method.POST, builder.toString(),
				ScheduleResp.class,
				RequestParamUtil.getScheduleParam(stage, day),
				new Response.Listener<ScheduleResp>() {
					@Override
					public void onResponse(ScheduleResp response) {
						Log.i(TAG, "日常安排请求...... ok...");
						savekeepinfoHandler.sendMessage(savekeepinfoHandler.obtainMessage(
								HTTP_SCHEDULE_REQUEST, response));
						
					}
				}, new Response.ErrorListener() {
					@Override
					public void onErrorResponse(VolleyError error) {
						Log.i(TAG, "日常安排请求失败:" + error.getMessage());
						savekeepinfoHandler.sendMessage(savekeepinfoHandler.obtainMessage(
								HTTP_REQUEST_FAIL, null));

					}
				});
		PKeeperApplication.getInstance().addRequestQueue(keepinfotagRequest,
				TAG_SAVEKEEPINFO_REQUEST);
		
	}
	
	public static void makeReportInfoRequest(int page,int pagenum) {
		String url = RequestAddress.getReportInfoUrl();
		
		Uri.Builder builder = Uri.parse(url).buildUpon();
		Log.i(TAG, "疾病报告请求:" + RequestParamUtil.getReportInfoRequestParam(page,pagenum));

		reportinfotagRequest = new FastJsonRequest<ReportInfoResp>(
				Request.Method.POST, builder.toString(),
				ReportInfoResp.class,
				RequestParamUtil.getReportInfoRequestParam(page,pagenum),
				new Response.Listener<ReportInfoResp>() {
					@Override
					public void onResponse(ReportInfoResp response) {
						Log.i(TAG, "疾病报告请求...... ok...");
						reportinfoHandler.sendMessage(reportinfoHandler.obtainMessage(
								HTTP_REQUEST, response));
						
					}
				}, new Response.ErrorListener() {
					@Override
					public void onErrorResponse(VolleyError error) {
						Log.i(TAG, "疾病报告请求失败:" + error.getMessage());
						reportinfoHandler.sendMessage(reportinfoHandler.obtainMessage(
								HTTP_REQUEST_FAIL, null));

					}
				});
		PKeeperApplication.getInstance().addRequestQueue(reportinfotagRequest,
				TAG_REPORTINFO_REQUEST);
		
	}
	public static void makeHadReadRequest(int id) {
		String url = RequestAddress.getHadReadUrl();
		
		Uri.Builder builder = Uri.parse(url).buildUpon();
		Log.i(TAG, "疾病报告已读请求:" + RequestParamUtil.getHadReadRequestParam(id));

		reportreadRequest = new FastJsonRequest<HadReadResp>(
				Request.Method.POST, builder.toString(),
				HadReadResp.class,
				RequestParamUtil.getHadReadRequestParam(id),
				new Response.Listener<HadReadResp>() {
					@Override
					public void onResponse(HadReadResp response) {
						Log.i(TAG, "疾病报告已读请求...... ok...");
						reportreadHandler.sendMessage(reportreadHandler.obtainMessage(
								HTTP_REQUEST, response));
						
					}
				}, new Response.ErrorListener() {
					@Override
					public void onErrorResponse(VolleyError error) {
						Log.i(TAG, "疾病报告已读请求失败:" + error.getMessage());
						reportreadHandler.sendMessage(reportreadHandler.obtainMessage(
								HTTP_REQUEST_FAIL, null));

					}
				});
		PKeeperApplication.getInstance().addRequestQueue(reportreadRequest,
				TAG_REPORTREAD_REQUEST);
		
	}
	
	public static void makeReportInfoAddRequest(String title,String detail,String file) {
		String url = RequestAddress.getSaveReportinfoUrl();
		
		Uri.Builder builder = Uri.parse(url).buildUpon();
		Log.i(TAG, "疾病报告添加请求:" + RequestParamUtil.getReportInfoAddRequestParam(title,detail,file));

		reportinfoaddRequest = new FastJsonRequest<BasicResponse>(
				Request.Method.POST, builder.toString(),
				BasicResponse.class,
				RequestParamUtil.getReportInfoAddRequestParam(title,detail,file),
				new Response.Listener<BasicResponse>() {
					@Override
					public void onResponse(BasicResponse response) {
						Log.i(TAG, "疾病报告添加请求...... ok...");
						reportinfoaddHandler.sendMessage(reportinfoaddHandler.obtainMessage(
								HTTP_REQUEST, response));
						
					}
				}, new Response.ErrorListener() {
					@Override
					public void onErrorResponse(VolleyError error) {
						Log.i(TAG, "疾病报告添加请求失败:" + error.getMessage());
						reportinfoaddHandler.sendMessage(reportinfoaddHandler.obtainMessage(
								HTTP_REQUEST_FAIL, null));

					}
				});
		PKeeperApplication.getInstance().addRequestQueue(reportinfoaddRequest,
				TAG_REPORTINFOADD_REQUEST);
		
	}
	
	public static void makeBusinessInfoRequest(int type,int page) {
		String url = RequestAddress.getBusinessInfoUrl();
		
		Uri.Builder builder = Uri.parse(url).buildUpon();
		Log.i(TAG, "获取行业知识请求:" + RequestParamUtil.getBusinessInfoRequestParam(type, page));

		businessinfoRequest = new FastJsonRequest<BusinessInfoResp>(
				Request.Method.POST, builder.toString(),
				BusinessInfoResp.class,
				RequestParamUtil.getBusinessInfoRequestParam(type, page),
				new Response.Listener<BusinessInfoResp>() {
					@Override
					public void onResponse(BusinessInfoResp response) {
						Log.i(TAG, "获取行业知识请求...... ok...");
						businessinfoHandler.sendMessage(businessinfoHandler.obtainMessage(
								HTTP_REQUEST, response));
						
					}
				}, new Response.ErrorListener() {
					@Override
					public void onErrorResponse(VolleyError error) {
						Log.i(TAG, "获取行业知识失败:" + error.getMessage());
						businessinfoHandler.sendMessage(businessinfoHandler.obtainMessage(
								HTTP_REQUEST_FAIL, null));

					}
				});
		PKeeperApplication.getInstance().addRequestQueue(businessinfoRequest,
				TAG_BUSINESSINFO_REQUEST);
		
	}
	
	public static void makeUpyunDownloadRequest(String path) {
		String url = RequestAddress.getUpyunDownloadUrl()+path;
		Uri.Builder builder = Uri.parse(url).buildUpon();
		Log.i(TAG, "获取图片请求:" + RequestParamUtil.getUpyunDownloadParam());
		loginRequest = new FastJsonRequest<LoginResp>(
				Request.Method.POST,
				builder.toString(),
				LoginResp.class,
				RequestParamUtil.getUpyunDownloadParam(),
				new Response.Listener<LoginResp>() {
					@Override
					public void onResponse(LoginResp response) {
						Log.i(TAG, "获取图片请求...... ok...");
						mainHandler.sendMessage(loginHandler.obtainMessage(HTTP_IMAGE_REQUEST,response));
					}
				},
				new Response.ErrorListener() {
					@Override
					public void onErrorResponse(VolleyError error) {
						Log.i(TAG, "获取图片请求失败:" + error.getMessage());
						mainHandler.sendMessage(loginHandler.obtainMessage(HTTP_IMAGE_REQUEST_FAIL,null));
					}
				});
		PKeeperApplication.getInstance().addRequestQueue(loginRequest,
				TAG_LOGINREQUEST_REQUEST);

	}
	
	
/*
	public class BitmapLruCache extends LruCache<String, Bitmap> implements
			ImageCache {

		public BitmapLruCache(int maxSize) {
			super(maxSize);
			initLocalFileManager();
		}

		private void initLocalFileManager() {

		}

		@Override
		protected int sizeOf(String key, Bitmap value) {
			// TODO value.getByteCount();
			return value.getRowBytes() * value.getHeight();
		}

		@Override
		public Bitmap getBitmap(String url) {
			Bitmap tbm = get(url);
			if (tbm != null) {
				return tbm;
			}
			return null; // TODO local file
		}

		@Override
		public void putBitmap(String url, Bitmap bitmap) {
			put(url, bitmap);
		}
	}

	*//**
	 * 网络图片加载方法
	 * 
	 * @param uri
	 *            图片uri
	 *//*
	public static void makeImageLoadRequest(String uri) {

		ImageRequest imgRequest = new ImageRequest(uri,
				new Response.Listener<Bitmap>() {
					@Override
					public void onResponse(Bitmap response) {
						// mImageView3.setImageBitmap(response);
						Log.i(TAG, "图片请求...... ok...");
					}
				}, 0, 0, Bitmap.Config.ARGB_8888, new Response.ErrorListener() {
					@Override
					public void onErrorResponse(VolleyError error) {

						Log.i(TAG, "图片请求....... Error...");

						// mImageView3.setImageResource(R.drawable.ic_launcher);
					}
				});
		MyApplication.getInstance().addRequestQueue(imgRequest,
				"TAG_MOVIE_IMAGE_LOAD_REQUEST");
	}

	*//** 加载图片，单张加载 *//*
	public void makeImageLoading(String uri) {

		ImageRequest imgRequest = new ImageRequest(uri,
				new Response.Listener<Bitmap>() {
					@Override
					public void onResponse(Bitmap response) {
						// mImageView3.setImageBitmap(response);
						Log.i(TAG, "图片请求...... ok...");
					}
				}, 0, 0, Bitmap.Config.ARGB_8888, new Response.ErrorListener() {
					@Override
					public void onErrorResponse(VolleyError error) {
						Log.i(TAG, "图片请求....... Error...");

						// mImageView3.setImageResource(R.drawable.ic_launcher);
					}
				});
		MyApplication.getInstance().addRequestQueue(imgRequest,
				"TAG_LOGO_IMAGE_LOAD_REQUEST");

	}*/


	
	
	
}
