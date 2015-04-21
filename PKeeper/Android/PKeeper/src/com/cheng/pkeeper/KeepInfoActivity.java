package com.cheng.pkeeper;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.cheng.pkeeper.adapt.FirstStageAdapter;
import com.cheng.pkeeper.data.FirstStageData;
import com.cheng.pkeeper.data.response.BatchNumResp;
import com.cheng.pkeeper.data.response.FirstStageResp;
import com.cheng.pkeeper.http.SendRequestUtil;
import com.cheng.pkeeper.util.PullToRefreshListView;
import com.cheng.pkeeper.util.TitleView;
import com.cheng.pkeeper.util.ToastUtil;
import com.cheng.pkeeper.util.PullToRefreshListView.OnLoadMoreListener;

import android.app.Activity;
import android.content.Intent;
import android.content.SharedPreferences;
import android.content.SharedPreferences.Editor;
import android.os.Bundle;
import android.os.Message;
import android.util.Log;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.AdapterView;
import android.widget.AdapterView.OnItemClickListener;
import android.widget.AdapterView.OnItemSelectedListener;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.LinearLayout;
import android.widget.Spinner;
import android.widget.TextView;

public class KeepInfoActivity extends AppBasicActivity {

	private Spinner current;
	private PullToRefreshListView keepinfo;
	private ArrayAdapter<?> adapter;
	private List<FirstStageData> Keepinfo1 = new ArrayList<FirstStageData>();
	private List<FirstStageData> Keepinfo2 = new ArrayList<FirstStageData>();
	private List<FirstStageData> Keepinfo3 = new ArrayList<FirstStageData>();
	private FirstStageAdapter keepinfo_adapter1=new FirstStageAdapter(this);
	private FirstStageAdapter keepinfo_adapter2=new FirstStageAdapter(this);
	private FirstStageAdapter keepinfo_adapter3=new FirstStageAdapter(this);
	private Button keepinfo_add;
	private TextView qa;
	private LinearLayout pb;
	private SharedPreferences share;
	
	private String batchnum;
	private int stage;
	private FirstStageData data;
	private int itemPosition;
	boolean isRefresh;
	private int index=1;
	
	public void onCreate(Bundle savedInstanceState) {
		
		super.onCreate(savedInstanceState);
		setContentView(R.layout.keeperinfo);
		
		tag_request =SendRequestUtil.TAG_KEEPINFO_REQUEST;
		SendRequestUtil.keepinfoHandler = handler;
		share = getSharedPreferences("keepinfo",Activity.MODE_PRIVATE);
		batchnum =share.getString(""+AppConfig.cfactoryid,"");
		Log.i(TAG,AppConfig.cfactoryid+"  "+batchnum);
		if (batchnum == null || batchnum.equals("")) {
			SendRequestUtil.makeBatchNumRequest();
		} else {
			SendRequestUtil.makeFirstStageRequest(batchnum);
		}
		pb = (LinearLayout)findViewById(R.id.progbar_loading);
		pb.setVisibility(View.VISIBLE);
		TitleView mTitleView = (TitleView) findViewById(R.id.titleview);
		mTitleView.setTitle(R.string.keep_info);
		mTitleView.setBackButton(mBackListener);
		qa = (TextView)findViewById(R.id.tv_qa);
		current = (Spinner)findViewById(R.id.spinner_current);
		keepinfo = (PullToRefreshListView)findViewById(R.id.listkeep_info);
		keepinfo_add = (Button)findViewById(R.id.btn_add);
		keepinfo_add.setOnClickListener(new AddClickListener());
		keepinfo_adapter1 = new FirstStageAdapter(this);
		keepinfo.setOnItemClickListener(new OnItemClickListenerImpl());
	
		adapter = ArrayAdapter.createFromResource(this, R.array.keepinfo_status3, android.R.layout.simple_spinner_item);
		adapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
		current.setAdapter(adapter);
		current.setOnItemSelectedListener(new SpinnerSelectedListener());
		
//		keepinfo.setOnRefreshListener(new OnRefreshListener() {
//
//			@Override
//			public void onRefresh() {
//				isRefresh = true;
//				SendRequestUtil.makeReportInfoRequest(1,reportList.size());
//			}
//		});
		keepinfo.setOnLoadMoreListener(new OnLoadMoreListener() {

			@Override
			public void onLoadMore() {
				if (stage ==3) {
					SendRequestUtil.makeThirdStageRequest(batchnum,index);;
				} else {
					keepinfo.onLoadMoreComplete(true);
				}
				
			}
		});
	}
	
	

	private class SpinnerSelectedListener implements OnItemSelectedListener{
		public void onItemSelected(AdapterView<?> arg0, View arg1, int arg2,
				long arg3) {
			qa.setText(getString(R.string.keepinfo_first)+adapter.getItem(arg2).toString()+getString(R.string.keepinfo_last));
			if (arg2 ==0) {
//				if (Keepinfo1 == null || Keepinfo1.size() == 0) {
//					PKeeperApplication.getInstance().cancelRequestByTag(
//							tag_request);
//					SendRequestUtil.makeFirstStageRequest(batchnum);
//					pb.setVisibility(View.VISIBLE);
//				}
//				keepinfo.setAdapter(keepinfo_adapter1);
//				keepinfo_adapter1.updataList(Keepinfo1);
				keepinfo.setAdapter(keepinfo_adapter1);
				keepinfo_adapter1.notifyDataSetChanged();
				stage = 0;
			} else if (arg2 ==1) {
//				SendRequestUtil.makeScheduleRequest(batchnum);
				if (Keepinfo2 == null || Keepinfo2.size() == 0) {
					PKeeperApplication.getInstance().cancelRequestByTag(
							tag_request);
					SendRequestUtil.makeSecondStageRequest(batchnum);
					pb.setVisibility(View.VISIBLE);
				}
				keepinfo.setAdapter(keepinfo_adapter2);
				keepinfo_adapter2.notifyDataSetChanged();
				keepinfo_add.setVisibility(View.GONE);
				stage = 1;
			} else if (arg2 ==2) {
				if (Keepinfo3 == null || Keepinfo3.size() == 0) {
					PKeeperApplication.getInstance().cancelRequestByTag(
							tag_request);
					SendRequestUtil.makeThirdStageRequest(batchnum,index);
					pb.setVisibility(View.VISIBLE);
				}
				keepinfo.setAdapter(keepinfo_adapter3);
				keepinfo_adapter3.notifyDataSetChanged();
				keepinfo_add.setVisibility(View.VISIBLE);
				stage = 2;
			}
		}

		public void onNothingSelected(AdapterView<?> arg0) {
			
		}
		
	}
	private class AddClickListener implements OnClickListener{

		@Override
		public void onClick(View arg0) {
			
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");  
			String t=format.format(new Date());
			if (Keepinfo3.size() != 0 && Keepinfo3.get(Keepinfo3.size()-1).getRecordtime().equals(t)) {
				ToastUtil.showToast(KeepInfoActivity.this, "当天信息已提交，请点击修改");
			} else {
				Intent intent = new Intent(KeepInfoActivity.this, KeepDetailInfoActivity.class);
				intent.putExtra("stage", 2);
				intent.putExtra("batchnum", batchnum);
				startActivityForResult(intent, 0);
			}
		}
		
	}

	private class OnItemClickListenerImpl implements OnItemClickListener {

		public void onItemClick(AdapterView<?> parent, View view, int position,
				long id) {
			Log.i(TAG,""+position);
			itemPosition = position-1;
			if (stage ==0) {
				data = keepinfo_adapter1.getList().get(position-1);
			} else if (stage ==1) {
				data = keepinfo_adapter2.getList().get(position-1);
			} else if (stage ==2) {
				data = keepinfo_adapter3.getList().get(position-1);
			}
			Intent intent = new Intent(KeepInfoActivity.this, KeepDetailInfoActivity.class);
			intent.putExtra("data", data);
			intent.putExtra("batchnum", batchnum);
			intent.putExtra("stage",stage);
			intent.putExtra("day", position);
			startActivityForResult(intent, 1);
		}
	}
	protected void onActivityResult(int requestCode, int resultCode, Intent data) {
		Log.i(TAG,"onActivityResult:"+resultCode);
		if (data == null) {
			return;
		}
		FirstStageData dd = (FirstStageData) data.getSerializableExtra("data");
		if (resultCode == 0) {
			keepinfo_adapter3.getList().add(dd);
			keepinfo_adapter3.notifyDataSetChanged();
		} else if (resultCode == 1) {
			if (stage ==0) {
				keepinfo_adapter1.getList().set(itemPosition, dd);
				keepinfo_adapter1.notifyDataSetChanged();
			} else if (stage ==1) {
				keepinfo_adapter2.getList().set(itemPosition, dd);
				keepinfo_adapter2.notifyDataSetChanged();
			} else if (stage ==2) {
				keepinfo_adapter3.getList().set(itemPosition, dd);
				keepinfo_adapter3.notifyDataSetChanged();
			
			}
		}
		super.onActivityResult(requestCode, resultCode, data);
	}
	
	
	@Override
	protected void requestFail(Message msg) {
		ToastUtil.showToast(KeepInfoActivity.this, R.string.request_fail);
		pb.setVisibility(View.GONE);
		
	}


	@Override
	protected void requestSuccess(Message msg) {
		// TODO Auto-generated method stub
		
	}
	
	@Override
	protected void requsestDefault(Message msg) {
		
		if (msg.what == SendRequestUtil.HTTP_BATCHNUM_REQUEST) {
			BatchNumResp resp = (BatchNumResp)msg.obj;
			batchnum =resp.getChickenbatchnuminfo().getBatchnum();
//			SendRequestUtil.makeTagRequest(batchnum);
			Editor editor = share.edit();
			editor.putString(""+AppConfig.cfactoryid, resp.getChickenbatchnuminfo().getBatchnum()).commit();
			batchnum = resp.getChickenbatchnuminfo().getBatchnum();
			SendRequestUtil.makeFirstStageRequest(batchnum);
//		} else if (msg.what == SendRequestUtil.HTTP_TAGNUM_REQUEST) {
//			TagNumResp resp = (TagNumResp)msg.obj;
//			SendRequestUtil.makeScheduleRequest(batchnum);
//			SendRequestUtil.makeFirstStageRequest(batchnum);
//			if (resp.getStage() == 1) {
//				adapter = ArrayAdapter.createFromResource(this, R.array.keepinfo_status1, android.R.layout.simple_spinner_item);
//			} else if (resp.getStage() == 2) {
//				adapter = ArrayAdapter.createFromResource(this, R.array.keepinfo_status2, android.R.layout.simple_spinner_item);
//			} else {
//				adapter = ArrayAdapter.createFromResource(this, R.array.keepinfo_status3, android.R.layout.simple_spinner_item);
//			}
			
//			pb.setVisibility(View.GONE);
		} else if (msg.what == SendRequestUtil.HTTP_FIRSTSTAGE_REQUEST) {
			FirstStageResp resp = (FirstStageResp)msg.obj;
			Keepinfo1 = resp.getDatas();
			keepinfo.setAdapter(keepinfo_adapter1);
			keepinfo_adapter1.updataList(Keepinfo1,0);
			pb.setVisibility(View.GONE);
		} else if (msg.what == SendRequestUtil.HTTP_SECONDSTAGE_REQUEST) {
			FirstStageResp resp = (FirstStageResp)msg.obj;
			Keepinfo2 = resp.getDatas();
			keepinfo.setAdapter(keepinfo_adapter2);
			keepinfo_adapter2.updataList(Keepinfo2,1);
			pb.setVisibility(View.GONE);
		} else if (msg.what == SendRequestUtil.HTTP_THIRDSTAGE_REQUEST) {
			FirstStageResp resp = (FirstStageResp)msg.obj;
//			Keepinfo3 = resp.getDatas();
			keepinfo.onLoadMoreComplete(true);
			if (resp != null && resp.getResult()) {
				if (resp.getDatas() != null && resp.getDatas().size() != 0) {
					index++;
				}
				Keepinfo3.addAll(resp.getDatas());
			}
			keepinfo.setAdapter(keepinfo_adapter3);
			keepinfo_adapter3.updataList(Keepinfo3,2);
			pb.setVisibility(View.GONE);
		}
		
		
	}
	private OnClickListener mBackListener = new OnClickListener() {
		public void onClick(View view) {
			onBackPressed();
		}
	};
	
}
