package com.cheng.pkeeper;

import java.io.File;

import android.app.Application;
import android.content.Context;
import android.text.TextUtils;
import android.util.Log;

import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.VolleyLog;
import com.android.volley.toolbox.Volley;
import com.cheng.pkeeper.util.FileUtils;
import com.nostra13.universalimageloader.cache.disc.impl.UnlimitedDiscCache;
import com.nostra13.universalimageloader.cache.disc.naming.Md5FileNameGenerator;
import com.nostra13.universalimageloader.cache.memory.impl.WeakMemoryCache;
import com.nostra13.universalimageloader.core.ImageLoader;
import com.nostra13.universalimageloader.core.ImageLoaderConfiguration;
import com.nostra13.universalimageloader.core.assist.QueueProcessingType;

public class PKeeperApplication extends Application {

	private static final String TAG = "PKeeperApplication";
	public static final String VOLLEY_TAG = "VolleyRequestTag";
	
	private static PKeeperApplication instance = null;
	
	//请求队列
	private RequestQueue requestQueue = null;
	
	public void onCreate() {
		super.onCreate();
		initImageLoader(getApplicationContext());
		instance = this;
		
	}
	
	public static PKeeperApplication getInstance()
	{
		return instance;
	}
	
	
	/**
	 * 获得请求队列
	 * @return
	 */
	public RequestQueue getRequestQueue()
	{
		if(requestQueue == null)
		{
			requestQueue = Volley.newRequestQueue(getApplicationContext());
		}
		return requestQueue;
	}
	
	/**
	 * 添加请求队列
	 * @param request
	 * @param tag
	 */
	public <T> void addRequestQueue(Request<T> request, String tag) {
		request.setTag(TextUtils.isEmpty(tag) ? VOLLEY_TAG : tag);
		VolleyLog.d("Adding request to queue: %s", request.getUrl());
		getRequestQueue().add(request);
	}
	
	/**
	 * 取消网络请求
	 * @param tag
	 */
	public void cancelRequestByTag(String tag)
	{
		if(requestQueue != null && !TextUtils.isEmpty(tag))
		{
			requestQueue.cancelAll(tag);
		}
	}
	
	@Override
	public void onLowMemory() {
		Log.i(TAG, "onLowMemory");
		ImageLoader.getInstance().clearMemoryCache();
		super.onLowMemory();
	}

	@Override
	public void onTrimMemory(int level) {
		Log.i(TAG, "onTrimMemory");
		if (level > 60)
			ImageLoader.getInstance().clearMemoryCache();
		super.onTrimMemory(level);
	}

	
	public static void initImageLoader(Context context) {
		File cachFile = FileUtils.getImageCachFile(context);
		int width = context.getResources().getDisplayMetrics().widthPixels;
		int height = context.getResources().getDisplayMetrics().heightPixels;
		float density = context.getResources().getDisplayMetrics().density;
		AppConfig.screenWidth = width;
		AppConfig.screenHeight = height;
		AppConfig.density = density;
		Log.i(TAG, "width:" + width + "height:" + height + "density:" + density);
		ImageLoaderConfiguration config = new ImageLoaderConfiguration.Builder(
				context).threadPriority(Thread.NORM_PRIORITY - 2)
				.denyCacheImageMultipleSizesInMemory()
				.diskCacheFileNameGenerator(new Md5FileNameGenerator())
				.memoryCache(new WeakMemoryCache())
				.memoryCacheExtraOptions(width, height)
				.tasksProcessingOrder(QueueProcessingType.LIFO)
				.writeDebugLogs() // Remove for release app
				.diskCache(new UnlimitedDiscCache(cachFile)).build();
		ImageLoader.getInstance().init(config);
	}
	
}