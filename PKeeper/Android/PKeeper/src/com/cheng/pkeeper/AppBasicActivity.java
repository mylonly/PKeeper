package com.cheng.pkeeper;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.util.Log;
import android.view.MenuItem;
import android.view.Window;

import com.cheng.pkeeper.http.SendRequestUtil;

public abstract class AppBasicActivity extends Activity {
	
	public static final String TAG = "AppBasicActivity";
	public String tag_request = null;
	public Handler handler = new Handler() {
		
		public void handleMessage(Message msg) {
			super.handleMessage(msg);
			
			switch (msg.what) {
			case SendRequestUtil.HTTP_REQUEST:
				Log.i(TAG,"requestSuccess");
				requestSuccess(msg);
				break;
			case SendRequestUtil.HTTP_REQUEST_FAIL:
				Log.i(TAG,"requestFail");
				requestFail(msg);
				break;
			default:
				Log.i(TAG,"requestDefault");
				requsestDefault(msg);
				break;
			}
			
		}

		
	};
	

	protected abstract void requestFail(Message msg);

	protected abstract void requestSuccess(Message msg);
	protected void requsestDefault(Message msg){
	
	}
	
	public void onStop(){
		super.onStop();
		if (tag_request != null) {
			PKeeperApplication.getInstance().cancelRequestByTag(
					tag_request);
		}
	}
}
