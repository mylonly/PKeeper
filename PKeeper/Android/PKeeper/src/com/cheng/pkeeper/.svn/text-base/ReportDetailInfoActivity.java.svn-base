package com.cheng.pkeeper;

import java.util.ArrayList;

import com.cheng.pkeeper.data.ReportData;
import com.cheng.pkeeper.http.SendRequestUtil;
import com.cheng.pkeeper.util.NineGridView;
import com.cheng.pkeeper.util.TitleView;

import android.content.Intent;
import android.os.Bundle;
import android.os.Message;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.TextView;

public class ReportDetailInfoActivity extends AppBasicActivity {

	private NineGridView mAddView;
	public ArrayList<String> mPathNews = new ArrayList<String>();
	private TextView title;
	private TextView detail;
	private TextView retitle;
	private TextView redetail;
	private TextView retime;
	
	public void onCreate(Bundle savedInstanceState) {

		super.onCreate(savedInstanceState);
		setContentView(R.layout.reportinfo_detail);
		TitleView mTitleView = (TitleView) findViewById(R.id.titleview);
		mTitleView.setTitle(R.string.reportinfo);
		mTitleView.setBackButton(mBackListener);
		
		Intent in = getIntent();
		ReportData data = (ReportData) in.getSerializableExtra("data");
		tag_request =SendRequestUtil.TAG_REPORTREAD_REQUEST;
		SendRequestUtil.reportreadHandler = handler;
		SendRequestUtil.makeHadReadRequest(data.getId());
		
		title = (TextView) findViewById(R.id.title);
		detail = (TextView) findViewById(R.id.detail);
		retitle = (TextView) findViewById(R.id.re_title);
		redetail = (TextView) findViewById(R.id.re_detail);
		retime = (TextView) findViewById(R.id.re_time);
		title.setText(data.getTitle());
		detail.setText(data.getDesc());
		if (data.getResuserid() != 0) {
			redetail.setText(data.getResdesc());
			if (data.getRestime().length()>10) {
				retime.setText(data.getRestime().substring(0, 10));
			} else {
				retime.setText(data.getRestime());
			}
			retitle.setText(data.getResname());
			if (!data.getPic().equals("")) {
				String[] str = data.getPic().split(",");
				for (int i=0;i<str.length;i++) {
					mPathNews.add(str[i]);
				}
			}
		}
		mAddView = (NineGridView) findViewById(R.id.addview_content);
		mAddView.setAdapter(mPathNews);
	}
	

	
	@Override
	protected void requestFail(Message msg) {
		// TODO Auto-generated method stub
		
	}

	@Override
	protected void requestSuccess(Message msg) {
		// TODO Auto-generated method stub
		
	}
	
	private OnClickListener mBackListener = new OnClickListener() {
		public void onClick(View view) {
			onBackPressed();
		}
	};
}

