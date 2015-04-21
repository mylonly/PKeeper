package com.cheng.pkeeper.http;

import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.Map;

import android.util.Log;

import com.alibaba.fastjson.JSON;
import com.android.volley.AuthFailureError;
import com.android.volley.DefaultRetryPolicy;
import com.android.volley.NetworkResponse;
import com.android.volley.ParseError;
import com.android.volley.Request;
import com.android.volley.Response;
import com.android.volley.Response.ErrorListener;
import com.android.volley.Response.Listener;
import com.android.volley.toolbox.HttpHeaderParser;
import com.cheng.pkeeper.util.Constants;
import com.cheng.pkeeper.util.JsonUtil;

public class FastJsonRequest<T> extends Request<T>{
	
	final String TAG = "FastJsonRequest";
	//正常返回的监听
	private Listener<T> mListener;
	
	//请求的数据字段
	private Map mRequestBody;
	
	//返回数据的解析类
	private Class<T> mClass;
	
	//添加的头部信息
	private HashMap<String,String> headers = new HashMap<String,String>();
	
    public static int index = 0;
	public FastJsonRequest(int method, String url, Class<T> cls,
			Map requestBody,Listener<T> listener,
			ErrorListener errorListener) {
		super(method, url, errorListener);
		this.mClass = cls;
		this.mListener = listener;
		this.mRequestBody = requestBody;
		init(url);
	}

	private void init(String url)
	{
//		addHeaderContentType();
		System.out.println("index----->"+index);
		//请求超时
		this.setRetryPolicy(new DefaultRetryPolicy(Constants.TIME_OUT, index, 1.0f));
	}
	
	@Override
	public Map<String, String> getHeaders() throws AuthFailureError {		
		return headers;
	}
	public void addHeader(String key, String value)
	{
		//如果不存在就加入到headers Map中
		if(!headers.containsKey(key))
		{
			headers.put(key, value);
		}
	}
	/**
	 * 添加消息体内容格式
	 */
	public void addHeaderContentType()
	{
		addHeader(Constants.PROTOCOL_CONTENT_TYPE,
				Constants.PROTOCOL_CONTENT_TYPE_JSON);
	}

	@Override
	protected Map<String, String> getParams() throws AuthFailureError {
//		return super.getParams();
		return mRequestBody;
	}
	
	
	@Override
	protected void deliverResponse(T response) {
		mListener.onResponse(response);
	}

	@Override
	protected Response<T> parseNetworkResponse(NetworkResponse response) {
		
		try {
			String jsonString = new String(response.data,HttpHeaderParser.
					parseCharset(response.headers));
			
			
			Log.i(TAG, "jsonString:"+jsonString);
			T parsedGSON = JSON.parseObject(jsonString, mClass);
			
			return Response.success(parsedGSON, 
					HttpHeaderParser.parseCacheHeaders(response));
		} catch (UnsupportedEncodingException e) {
			return Response.error(new ParseError(e));
		}catch(Exception je)
		{
			return Response.error(new ParseError(je));
		}
	}
	
//	@Override
//	public String getBodyContentType() {
//		return Constants.PROTOCOL_CONTENT_TYPE;
//	}
	
//	@Override
//	public byte[] getBody() {
//		try {
//			Log.i(TAG,JsonUtil.toUriString(mRequestBody
//					));
////			return "address=a&city=a".getBytes(Constants.PROTOCOL_CHARSET);
//			return mRequestBody == null ? null : JsonUtil.toUriString(mRequestBody
//					).getBytes(Constants.PROTOCOL_CHARSET);
////			return mRequestBody == null ? null : mRequestBody
////					.getBytes(Constants.PROTOCOL_CHARSET);
//		} catch (UnsupportedEncodingException e) {
//			Log.e(TAG,
//					String.format(
//							"Unsupported Encoding while trying to get the bytes of %s using %s",
//							mRequestBody, Constants.PROTOCOL_CHARSET));
//			return null;
//		}
//	}

}
