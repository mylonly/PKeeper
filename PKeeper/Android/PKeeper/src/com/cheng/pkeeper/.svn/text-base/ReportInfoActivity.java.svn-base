package com.cheng.pkeeper;

import java.util.ArrayList;
import java.util.List;

import android.content.Intent;
import android.os.Bundle;
import android.os.Message;
import android.util.Log;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.AdapterView;
import android.widget.AdapterView.OnItemClickListener;
import android.widget.LinearLayout;

import com.cheng.pkeeper.adapt.ReportListAdapter;
import com.cheng.pkeeper.data.ReportData;
import com.cheng.pkeeper.data.response.ReportInfoResp;
import com.cheng.pkeeper.http.SendRequestUtil;
import com.cheng.pkeeper.util.PullToRefreshListView;
import com.cheng.pkeeper.util.TitleView;
import com.cheng.pkeeper.util.ToastUtil;
import com.cheng.pkeeper.util.PullToRefreshListView.OnLoadMoreListener;
import com.cheng.pkeeper.util.PullToRefreshListView.OnRefreshListener;

public class ReportInfoActivity extends AppBasicActivity {
	private PullToRefreshListView reportinfo;
	private List<ReportData> reportList = new ArrayList<ReportData>();
	private ReportListAdapter reportAdapter;
	private LinearLayout pb;
	private int index=1;
	
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.reportinfo);
		TitleView mTitleView = (TitleView) findViewById(R.id.titleview);
		mTitleView.setTitle(R.string.reportinfo);
		mTitleView.setBackButton(mBackListener);
		mTitleView.setRightButton("", R.drawable.add, mPublishListener);
		
		tag_request =SendRequestUtil.TAG_REPORTINFO_REQUEST;
		SendRequestUtil.reportinfoHandler = handler;
		pb = (LinearLayout)findViewById(R.id.progbar_loading);
		pb.setVisibility(View.VISIBLE);
		
		//TODO
		SendRequestUtil.makeReportInfoRequest(index,15);
		reportinfo = (PullToRefreshListView) findViewById(R.id.list_reportinfo);
//		mEditContent = (EditText) findViewById(R.id.edittext_detail);
//		mAddView = (NineGridView) findViewById(R.id.addview_content);
		
		reportAdapter = new ReportListAdapter(this);
		reportinfo.setAdapter(reportAdapter);
		reportinfo.setOnItemClickListener(new OnItemClickListenerImpl());
		
		reportinfo.setOnRefreshListener(new OnRefreshListener() {

			@Override
			public void onRefresh() {
				isRefresh = true;
				SendRequestUtil.makeReportInfoRequest(1,reportList.size());
			}
		});
		reportinfo.setOnLoadMoreListener(new OnLoadMoreListener() {

			@Override
			public void onLoadMore() {
				isRefresh = false;
				SendRequestUtil.makeReportInfoRequest(index,15);
			}
		});
	
	}
	private class OnItemClickListenerImpl implements OnItemClickListener {

		public void onItemClick(AdapterView<?> parent, View view, int position,
				long id) {
			Intent intent = new Intent(ReportInfoActivity.this, ReportDetailInfoActivity.class);
			intent.putExtra("data", reportList.get(position-1));
			startActivity(intent);
		}
	}
	private OnClickListener mPublishListener = new OnClickListener() {

		@Override
		public void onClick(View view) {
			Intent intent = new Intent(ReportInfoActivity.this, ReportInfoAddActivity.class);
			intent.putExtra("data", "value");
			startActivityForResult(intent, 0);
		}
	};
	private OnClickListener mBackListener = new OnClickListener() {

		@Override
		public void onClick(View view) {
			onBackPressed();
		}
	};
		
	protected void onActivityResult(int requestCode, int resultCode, Intent data) {
		Log.i(TAG,"onActivityResult:"+resultCode);
		if (data == null) {
			return;
		}
		reportList.add(0,(ReportData)data.getSerializableExtra("data"));
		reportAdapter.updataList((ArrayList<ReportData>) reportList);
		super.onActivityResult(requestCode, resultCode, data);
	}
	@Override
	protected void requestFail(Message msg) {
		ToastUtil.showToast(ReportInfoActivity.this, R.string.request_fail);
		pb.setVisibility(View.GONE);
		if (isRefresh == true) {
			reportinfo.onRefreshComplete();
		} else
			reportinfo.onLoadMoreComplete(true);
	}
	boolean isRefresh;
	@Override
	protected void requestSuccess(Message msg) {
		ReportInfoResp res = (ReportInfoResp)msg.obj;
		if (isRefresh == true) {
			reportinfo.onRefreshComplete();
			if (res != null && res.getResult()) {
				reportList = res.getDatas();
				reportAdapter.updataList((ArrayList<ReportData>)reportList);
				pb.setVisibility(View.GONE);
			}
		} else {
			reportinfo.onLoadMoreComplete(true);
			if (res != null && res.getResult()) {
				if (res.getDatas() != null && res.getDatas().size() !=0) {
					index++;
				}
				reportList.addAll(res.getDatas());
				reportAdapter.updataList((ArrayList<ReportData>)reportList);
				pb.setVisibility(View.GONE);
			}
		}
	}
}
