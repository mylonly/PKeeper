package com.cheng.pkeeper;

import java.util.Timer;
import java.util.TimerTask;

import com.cheng.pkeeper.data.CFactoryData;
import com.cheng.pkeeper.data.UserData;
import com.cheng.pkeeper.data.response.HadKeepResp;
import com.cheng.pkeeper.data.response.NewReportResp;
import com.cheng.pkeeper.http.SendRequestUtil;
import com.cheng.pkeeper.util.JsonUtil;
import com.cheng.pkeeper.util.TitleView;
import com.cheng.pkeeper.util.ToastUtil;

import android.os.Bundle;
import android.os.Message;
import android.app.Activity;
import android.content.Intent;
import android.content.SharedPreferences;
import android.util.Log;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.TextView;
import android.widget.Toast;

public class GlobalBrowserActivity extends AppBasicActivity implements OnClickListener{

	public static String TAG = "GlobalBrowserActivity";
	private UserData user;
	private CFactoryData cfactory;
	private TextView tv1;
	private TextView tv2;
	private TextView tv3;
	private TextView tv4;
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_main);
		
		TitleView mTitleView = (TitleView) findViewById(R.id.titleview);
		mTitleView.setTitle(R.string.global_pkeeper);
		
		Intent intent = this.getIntent(); 
		user = (UserData)intent.getSerializableExtra("user");
		cfactory = (CFactoryData)intent.getSerializableExtra("cfactory");
		findViewById(R.id.title_layout2).setOnClickListener(this);
		findViewById(R.id.title_layout3).setOnClickListener(this);
		findViewById(R.id.title_layout4).setOnClickListener(this);
		findViewById(R.id.title_layout5).setOnClickListener(this);
		findViewById(R.id.title_layout6).setOnClickListener(this);
		tag_request =SendRequestUtil.TAG_MAIN_REQUEST;
		SendRequestUtil.mainHandler = handler;
		tv1 = (TextView)findViewById(R.id.title_name1);
		tv2 = (TextView)findViewById(R.id.title_name2);
		tv3 = (TextView)findViewById(R.id.title_name3);
		tv4 = (TextView)findViewById(R.id.title_name4);
		
		
	}

	@Override
	protected void onResume() {
		if (user != null) {
			tv3.setVisibility(View.GONE);
		}
		if (cfactory != null) {
			tv4.setVisibility(View.GONE);
		}
		SharedPreferences share = getSharedPreferences("keepinfo",Activity.MODE_PRIVATE);
		String batchnum =share.getString(""+AppConfig.cfactoryid,"");
		if (!batchnum.equals("") && AppConfig.cfactoryid != 0) {
			SendRequestUtil.makeHadKeepRequest(batchnum);
		}
		SendRequestUtil.makeNewReportRequest();
		super.onResume();
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		// Inflate the menu; this adds items to the action bar if it is present.
		getMenuInflater().inflate(R.menu.activity_main, menu);
		return true;
	}
	public boolean onOptionsItemSelected(MenuItem item) {
		switch(item.getItemId()){
		case R.id.menu_logout:
			AppConfig.cfactoryid = 0;
			Intent intent = new Intent(GlobalBrowserActivity.this, LoginActivity.class);
			intent.putExtra("isRelogin", false);
			startActivity(intent);
			finish();
		break;
		}
		return super.onOptionsItemSelected(item);
	}

	@Override
	public void onClick(View arg0) {
		
		switch (arg0.getId()) {
			case R.id.title_layout2:
				if (cfactory == null) {
					ToastUtil.showToast(this, "请先完善鸡场信息！");
					return;
				}
				Intent intent = new Intent(GlobalBrowserActivity.this, KeepInfoActivity.class);
				intent.putExtra("data", "mainActivity");
				startActivity(intent);
				break;
			case R.id.title_layout3:
				intent = new Intent(GlobalBrowserActivity.this, ReportInfoActivity.class);
				intent.putExtra("data", "mainActivity");
				startActivity(intent);
				break;
			case R.id.title_layout4:
				intent = new Intent(GlobalBrowserActivity.this, UserInfoActivity.class);
				Bundle bundle = new Bundle();
				bundle.putSerializable("user", user);
				intent.putExtras(bundle);
				startActivityForResult(intent, 1);
				break;
			case R.id.title_layout5:
				intent = new Intent(GlobalBrowserActivity.this, HouseInfoActivity.class);
				Bundle bundle2 = new Bundle();
				bundle2.putSerializable("cfactory", cfactory);
				intent.putExtras(bundle2);
				startActivityForResult(intent, 2);
				break;
			case R.id.title_layout6:
				intent = new Intent(GlobalBrowserActivity.this, BusinessInfoActivity.class);
				intent.putExtra("data", "mainActivity");
				startActivity(intent);
				break;
				
			default:
				break;
		}
	}
	
	public void onBackPressed() {
		exitBy2Click();
	}
	/** 
	* 双击退出函数 
	*/  
	private static Boolean isExit = false;
	private void exitBy2Click() {  
		Timer tExit = null;  
		if (isExit == false) {  
			isExit = true; // 准备退出  
			Toast.makeText(this, "再按一次退出程序", Toast.LENGTH_SHORT).show();  
					tExit = new Timer();  
					tExit.schedule(new TimerTask() {  
						@Override  
						public void run() {  
							isExit = false; // 取消退出  
						}  
					}, 1000); // 如果1秒钟内没有按下返回键，则启动定时器取消掉刚才执行的任务  
		
				} else {  
				finish();  
				System.exit(0);  
				}  
			}  

	protected void onActivityResult(int requestCode, int resultCode, Intent data) {
		Log.i(TAG,"onActivityResult:"+resultCode);
		if (resultCode == 1) {
			user = (UserData) data.getSerializableExtra("userinfo");
			Log.i(TAG,JsonUtil.toJSONString(user));
		} else if (resultCode == 2) {
			cfactory = (CFactoryData) data.getSerializableExtra("cfactoryinfo");
			Log.i(TAG,JsonUtil.toJSONString(cfactory));
		}
		super.onActivityResult(requestCode, resultCode, data);
	}
	
	@Override
	protected void requestFail(Message msg) {
		// TODO Auto-generated method stub
		
	}

	@Override
	protected void requsestDefault(Message msg) {
		
		if (msg.what == SendRequestUtil.HTTP_REMEND_KEEP_REQUEST) {
			
			HadKeepResp is = (HadKeepResp)msg.obj;
			if (is.getResult() && is.isSubmit()) {
				tv1.setVisibility(View.GONE);
			}
		} else if (msg.what == SendRequestUtil.HTTP_REMEND_NEWS_REQUEST) {
			NewReportResp is = (NewReportResp)msg.obj;
			if (is.getResult() && is.getTotal() == 0) {
				tv2.setVisibility(View.GONE);
			}
		}
	}

	@Override
	protected void requestSuccess(Message msg) {
	}

}
