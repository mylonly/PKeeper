package com.cheng.pkeeper;

import com.cheng.pkeeper.util.TitleView;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.view.KeyEvent;
import android.view.View;
import android.view.View.OnClickListener;
import android.webkit.WebSettings;
import android.webkit.WebSettings.LayoutAlgorithm;
import android.webkit.WebView;

public class WebViewActivity extends Activity {
	private WebView mWebView;
	private Handler mHandler = new Handler();

	public void onCreate(Bundle icicle) {
		super.onCreate(icicle);
		setContentView(R.layout.webview);
		Intent in = getIntent();
		String title = in.getStringExtra("title");
		String content = in.getStringExtra("content");
		TitleView mTitleView = (TitleView) findViewById(R.id.titleview);
		mTitleView.setTitle(title);
		mTitleView.setBackButton(mBackListener);

		mWebView = (WebView) findViewById(R.id.webview);
		WebSettings ws = mWebView.getSettings();
        ws.setJavaScriptEnabled(true); // 设置支持javascript脚本
        ws.setAllowFileAccess(true); // 允许访问文件
        ws.setBuiltInZoomControls(true); // 设置显示缩放按钮
        ws.setSupportZoom(true); // 支持缩放 <span style="color:#337fe5;"> /**
        // * 用WebView显示图片，可使用这个参数
        // * 设置网页布局类型：
        // * 1、LayoutAlgorithm.NARROW_COLUMNS ： 适应内容大小
        // * 2、LayoutAlgorithm.SINGLE_COLUMN:适应屏幕，内容将自动缩放
        // */
        ws.setLayoutAlgorithm(LayoutAlgorithm.NARROW_COLUMNS);
        ws.setDefaultTextEncodingName("utf-8"); // 设置文本编码
        ws.setAppCacheEnabled(true);
        ws.setCacheMode(WebSettings.LOAD_DEFAULT);// 设置缓存模式</span>
        //添加Javascript调用java对象
//		mWebView.loadUrl("file:///android_asset/demo.html");
		mWebView.loadData(content, "text/html; charset=utf8" ,null);

	}

	public boolean onKeyDown(int keyCode, KeyEvent event) {
		if ((keyCode == KeyEvent.KEYCODE_BACK) && mWebView.canGoBack()) {
			mWebView.goBack();
			return true;
		}
		return super.onKeyDown(keyCode, event);
	}

	private OnClickListener mBackListener = new OnClickListener() {
		public void onClick(View view) {
			onBackPressed();
		}
	};
}
