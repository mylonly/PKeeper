package com.cheng.pkeeper;

import com.cheng.pkeeper.http.RequestAddress;
import com.cheng.pkeeper.util.TitleView;

import android.app.Activity;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.MediaController;
import android.widget.VideoView;

public class InternetVideoActivity extends Activity {
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState); 
		this.setContentView(R.layout.videoview); 
		Intent in = getIntent();
		String title = in.getStringExtra("title");
		TitleView mTitleView = (TitleView) findViewById(R.id.titleview);
		mTitleView.setTitle(title);
		mTitleView.setBackButton(mBackListener);
		String url=in.getStringExtra("content");
		Uri uri;
		if (url.startsWith("http")) {
			uri = Uri.parse(url.replace("\\", "/"));
		} else {
			uri = Uri.parse(RequestAddress.getUpyunDownloadUrl()+"/"+url.replace("\\", "/"));
		}
//		Uri uri = Uri.parse("http://babyun-files.b0.upaiyun.com/videos/03/dd/33/61/42/03dd3361427aa0cbd8428c5ad76a8f0f.mp4");
		VideoView videoView = (VideoView)this.findViewById(R.id.videoview); 
		videoView.setMediaController(new MediaController(this));  
		videoView.setVideoURI(uri);  
		videoView.requestFocus(); 
	}
	
	private OnClickListener mBackListener = new OnClickListener() {
		public void onClick(View view) {
			onBackPressed();
		}
	};


}