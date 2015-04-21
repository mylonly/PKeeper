package com.cheng.pkeeper;

import java.util.ArrayList;
import java.util.List;

import com.cheng.pkeeper.adapt.BusinessListAdapter;
import com.cheng.pkeeper.data.AttachmentsData;
import com.cheng.pkeeper.data.BusinessData;
import com.cheng.pkeeper.data.response.BusinessInfoResp;
import com.cheng.pkeeper.http.SendRequestUtil;
import com.cheng.pkeeper.util.PullToRefreshListView;
import com.cheng.pkeeper.util.TitleView;
import com.cheng.pkeeper.util.ToastUtil;
import com.cheng.pkeeper.util.PullToRefreshListView.OnLoadMoreListener;
import com.cheng.pkeeper.util.PullToRefreshListView.OnRefreshListener;

import android.content.Intent;
import android.os.Bundle;
import android.os.Message;
import android.util.Log;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.AdapterView;
import android.widget.AdapterView.OnItemClickListener;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;

public class BusinessInfoActivity extends AppBasicActivity implements OnClickListener{

	private PullToRefreshListView business_info;
	private LinearLayout pb;
	private RelativeLayout[] businessType = new RelativeLayout[4];
	private List<BusinessData> businessList1 = new ArrayList<BusinessData>();
	private List<BusinessData> businessList2 = new ArrayList<BusinessData>();
	private List<BusinessData> businessList3 = new ArrayList<BusinessData>();
	private List<BusinessData> businessList4 = new ArrayList<BusinessData>();
	private BusinessListAdapter businessAdapter1;
	private BusinessListAdapter businessAdapter2=new BusinessListAdapter(this);
	private BusinessListAdapter businessAdapter3=new BusinessListAdapter(this);
	private BusinessListAdapter businessAdapter4=new BusinessListAdapter(this);
	
	private int current =1;
	private boolean isRefresh;
	private int index1=1;
	private int index2=1;
	private int index3=1;
	private int index4=1;
	
	public void onCreate(Bundle savedInstanceState) {
		
		super.onCreate(savedInstanceState);
		setContentView(R.layout.businessinfo);
		tag_request =SendRequestUtil.TAG_BUSINESSINFO_REQUEST;
		SendRequestUtil.businessinfoHandler = handler;
		
		TitleView mTitleView = (TitleView) findViewById(R.id.titleview);
		mTitleView.setTitle(R.string.business_info);
		mTitleView.setBackButton(mBackListener);
		
		SendRequestUtil.makeBusinessInfoRequest(1,1);
		
		pb = (LinearLayout)findViewById(R.id.progbar_loading);
		pb.setVisibility(View.VISIBLE);
	
		business_info = (PullToRefreshListView)findViewById(R.id.business_info);
		
		businessAdapter1 = new BusinessListAdapter(this);
		business_info.setAdapter(businessAdapter1);
		business_info.setOnItemClickListener(new OnItemClickListenerImpl());
		
		businessType[0] = (RelativeLayout) findViewById(R.id.business_type0);
		businessType[1] = (RelativeLayout) findViewById(R.id.business_type1);
		businessType[2] = (RelativeLayout) findViewById(R.id.business_type2);
		businessType[3] = (RelativeLayout) findViewById(R.id.business_type3);
		businessType[0].setOnClickListener(this);
		businessType[1].setOnClickListener(this);
		businessType[2].setOnClickListener(this);
		businessType[3].setOnClickListener(this);
		businessType[0].setBackgroundResource(R.drawable.business_blue2);
		businessType[1].setBackgroundResource(R.drawable.business_yellow);
		businessType[2].setBackgroundResource(R.drawable.business_orange);
		businessType[3].setBackgroundResource(R.drawable.business_green);
		business_info.setOnRefreshListener(new OnRefreshListener() {

			@Override
			public void onRefresh() {
				isRefresh = true;
				switch (current) {
				case 1:
						SendRequestUtil.makeBusinessInfoRequest(1,1);
					break;
				case 2:
						SendRequestUtil.makeBusinessInfoRequest(2,1);
					break;
				case 3:
						SendRequestUtil.makeBusinessInfoRequest(3,1);
					break;
				case 4:
						SendRequestUtil.makeBusinessInfoRequest(4,1);
					break;

				default:
					break;
				}
			}
		});
		business_info.setOnLoadMoreListener(new OnLoadMoreListener() {

			@Override
			public void onLoadMore() {
				switch (current) {
				case 1:
						SendRequestUtil.makeBusinessInfoRequest(1,index1);
					break;
				case 2:
						SendRequestUtil.makeBusinessInfoRequest(2,index2);
					break;
				case 3:
						SendRequestUtil.makeBusinessInfoRequest(3,index3);
					break;
				case 4:
						SendRequestUtil.makeBusinessInfoRequest(4,index4);
					break;

				default:
					break;
				}
			}
		});
	}
	
	private class OnItemClickListenerImpl implements OnItemClickListener {

		public void onItemClick(AdapterView<?> parent, View view, int position,
				long id) {
			if (current == 3) {
//				Intent intent = new Intent(BusinessInfoActivity.this, WebViewActivity.class);
//							Intent intent = new Intent(BusinessInfoActivity.this, VideoPlayerActivity.class);
				Intent intent = new Intent(BusinessInfoActivity.this, InternetVideoActivity.class);
				intent.putExtra("title", businessList3.get(position-1).getTitle());
							for (AttachmentsData a : businessList3.get(position-1).getAttachments()) {
								if (a.getType().equals("video")){
									if (a.getAttachAddr() == null) {
										ToastUtil.showToast(BusinessInfoActivity.this, "无播放视频");
										return;
									}
									intent.putExtra("content", a.getAttachAddr());
									break;
								}
							}
							startActivity(intent);
			} else if(current == 1) {
				Intent intent = new Intent(BusinessInfoActivity.this, WebViewActivity.class);
	//			Intent intent = new Intent(BusinessInfoActivity.this, VideoPlayerActivity.class);
				intent.putExtra("title", businessList1.get(position-1).getTitle());
				intent.putExtra("content", businessList1.get(position-1).getContent());
				startActivity(intent);
			}
			else if(current == 2) {
				Intent intent = new Intent(BusinessInfoActivity.this, WebViewActivity.class);
	//			Intent intent = new Intent(BusinessInfoActivity.this, VideoPlayerActivity.class);
				intent.putExtra("title", businessList2.get(position-1).getTitle());
				intent.putExtra("content", businessList2.get(position-1).getContent());
				startActivity(intent);
			}
			else if(current == 4) {
				Intent intent = new Intent(BusinessInfoActivity.this, WebViewActivity.class);
	//			Intent intent = new Intent(BusinessInfoActivity.this, VideoPlayerActivity.class);
				intent.putExtra("title", businessList4.get(position-1).getTitle());
				intent.putExtra("content", businessList4.get(position-1).getContent());
				startActivity(intent);
			}
		}
	}	
	
	@Override
	public void onClick(View arg0) {
		Log.i("myself","onclick"+arg0.getId());
		switch (arg0.getId()) {
		case R.id.business_type0:
			current = 1;
			businessType[0].setBackgroundResource(R.drawable.business_blue2);
			businessType[1].setBackgroundResource(R.drawable.business_yellow);
			businessType[2].setBackgroundResource(R.drawable.business_orange);
			businessType[3].setBackgroundResource(R.drawable.business_green);
			if (businessList1 != null && businessList1.size() != 0) {
				PKeeperApplication.getInstance().cancelRequestByTag(
						tag_request);
				isRefresh=false;
				SendRequestUtil.makeBusinessInfoRequest(1,index1);
				pb.setVisibility(View.VISIBLE);
			}
//			keepinfo.setAdapter(keepinfo_adapter1);
//			keepinfo_adapter1.updataList(Keepinfo1);
			business_info.setAdapter(businessAdapter1);
			pb.setVisibility(View.GONE);
			break;
		case R.id.business_type1:
			current = 2;
			businessType[0].setBackgroundResource(R.drawable.business_blue);
			businessType[1].setBackgroundResource(R.drawable.business_yellow2);
			businessType[2].setBackgroundResource(R.drawable.business_orange);
			businessType[3].setBackgroundResource(R.drawable.business_green);
			if (businessList2 != null&& businessList2.size() == 0) {
				PKeeperApplication.getInstance().cancelRequestByTag(
						tag_request);
				isRefresh=false;
				SendRequestUtil.makeBusinessInfoRequest(2,index2);
				pb.setVisibility(View.VISIBLE);
			}
//			keepinfo.setAdapter(keepinfo_adapter1);
//			keepinfo_adapter1.updataList(Keepinfo1);
			business_info.setAdapter(businessAdapter2);
			pb.setVisibility(View.GONE);
			break;
		case R.id.business_type2:
			current = 3;
			businessType[0].setBackgroundResource(R.drawable.business_blue);
			businessType[1].setBackgroundResource(R.drawable.business_yellow);
			businessType[2].setBackgroundResource(R.drawable.business_orange2);
			businessType[3].setBackgroundResource(R.drawable.business_green);
			if (businessList3 != null&& businessList3.size() == 0) {
				PKeeperApplication.getInstance().cancelRequestByTag(
						tag_request);
				isRefresh=false;
				SendRequestUtil.makeBusinessInfoRequest(3,index3);
				pb.setVisibility(View.VISIBLE);
			}
//			keepinfo.setAdapter(keepinfo_adapter1);
//			keepinfo_adapter1.updataList(Keepinfo1);
			business_info.setAdapter(businessAdapter3);
			pb.setVisibility(View.GONE);
			break;
		case R.id.business_type3:
			current = 4;
			businessType[0].setBackgroundResource(R.drawable.business_blue);
			businessType[1].setBackgroundResource(R.drawable.business_yellow);
			businessType[2].setBackgroundResource(R.drawable.business_orange);
			businessType[3].setBackgroundResource(R.drawable.business_green2);
			if (businessList4 != null&& businessList4.size() == 0) {
				PKeeperApplication.getInstance().cancelRequestByTag(
						tag_request);
				isRefresh=false;
				SendRequestUtil.makeBusinessInfoRequest(4,index4);
				pb.setVisibility(View.VISIBLE);
			}
			business_info.setAdapter(businessAdapter4);
			pb.setVisibility(View.GONE);
			break;

		default:
			break;
		}
		
	}
	
	private OnClickListener mBackListener = new OnClickListener() {
		public void onClick(View view) {
			onBackPressed();
		}
	};

	@Override
	protected void requestFail(Message msg) {
		ToastUtil.showToast(BusinessInfoActivity.this, R.string.request_fail);
		pb.setVisibility(View.GONE);
		if (isRefresh == true) {
			business_info.onRefreshComplete();
		} else
			business_info.onLoadMoreComplete(true);
		
	}

	@Override
	protected void requestSuccess(Message msg) {
		BusinessInfoResp resp = (BusinessInfoResp)msg.obj;
		if (current == 1) {
			if (isRefresh == true) {
				business_info.onRefreshComplete();
				if (resp != null && resp.getResult()) {
					businessList1 = resp.getDatas();
				}
			} else {
				business_info.onLoadMoreComplete(true);
				if (resp != null && resp.getResult()) {
					if (resp.getDatas() != null && resp.getDatas().size() !=0) {
						index1++;
					}
					businessList1.addAll(resp.getDatas());
				}
			}
			business_info.setAdapter(businessAdapter1);
			businessAdapter1.updataList((ArrayList<BusinessData>) businessList1);
			pb.setVisibility(View.GONE);
		} else if (current == 2) {
			if (isRefresh == true) {
				business_info.onRefreshComplete();
				if (resp != null && resp.getResult()) {
					businessList2 = resp.getDatas();
				}
			} else {
				business_info.onLoadMoreComplete(true);
				if (resp != null && resp.getResult()) {
					if (resp.getDatas() != null && resp.getDatas().size() !=0) {
						index2++;
					}
					businessList2.addAll(resp.getDatas());
				}
			}
			business_info.setAdapter(businessAdapter2);
			businessAdapter2.updataList((ArrayList<BusinessData>) businessList2);
			pb.setVisibility(View.GONE);
		} else if (current == 3) {
			if (isRefresh == true) {
				business_info.onRefreshComplete();
				if (resp != null && resp.getResult()) {
					businessList3 = resp.getDatas();
				}
			} else {
				business_info.onLoadMoreComplete(true);
				if (resp != null && resp.getResult()) {
					if (resp.getDatas() != null && resp.getDatas().size() !=0) {
						index3++;
					}
					businessList3.addAll(resp.getDatas());
				}
			}
			business_info.setAdapter(businessAdapter3);
			businessAdapter3.updataList((ArrayList<BusinessData>) businessList3);
			pb.setVisibility(View.GONE);
		} else if (current == 4) {
			if (isRefresh == true) {
				business_info.onRefreshComplete();
				if (resp != null && resp.getResult()) {
					businessList4 = resp.getDatas();
				}
			} else {
				business_info.onLoadMoreComplete(true);
				if (resp != null && resp.getResult()) {
					if (resp.getDatas() != null && resp.getDatas().size() !=0) {
						index4++;
					}
					businessList4.addAll(resp.getDatas());
				}
			}
			business_info.setAdapter(businessAdapter4);
			businessAdapter4.updataList((ArrayList<BusinessData>) businessList4);
			pb.setVisibility(View.GONE);
		}
		
	}
	
}
