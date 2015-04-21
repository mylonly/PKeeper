package com.cheng.pkeeper;

import java.util.ArrayList;
import java.util.List;

import com.cheng.pkeeper.data.CFactoryData;
import com.cheng.pkeeper.data.response.CFactoryInfoResp;
import com.cheng.pkeeper.http.SendRequestUtil;
import com.cheng.pkeeper.util.NineGridView;
import com.cheng.pkeeper.util.TitleView;
import com.cheng.pkeeper.util.ToastUtil;

import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.res.TypedArray;
import android.os.Bundle;
import android.os.Message;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.view.View.OnClickListener;
import android.widget.AdapterView;
import android.widget.AdapterView.OnItemClickListener;
import android.widget.BaseAdapter;
import android.widget.EditText;
import android.widget.ListView;
import android.widget.TextView;

public class HouseInfoActivity extends AppBasicActivity {

	private ListView lv_info;
	private TypedArray mTypedArray;
	private DemoAdapter listAdapter;
	private int oldPostion = -1;
	private List<String> list;
	private CFactoryData cfactory;
	private NineGridView mAddView;
	public ArrayList<String> mPathNews = new ArrayList<String>();
	public void onCreate(Bundle savedInstanceState) {

		super.onCreate(savedInstanceState);
		setContentView(R.layout.houseinfo);
		
		TitleView mTitleView = (TitleView) findViewById(R.id.titleview);
		mTitleView.setTitle(R.string.house_info);
		mTitleView.setBackButton(mBackListener);
		
		lv_info = (ListView) findViewById(R.id.house_info);
		mTypedArray = getResources().obtainTypedArray(
				R.array.houseinfo_library_string);
		Intent intent = this.getIntent(); 
		cfactory = (CFactoryData)intent.getSerializableExtra("cfactory");
		list = dataToList(cfactory);
		listAdapter = new DemoAdapter(this,list);
		lv_info.setAdapter(listAdapter);
		lv_info.setOnItemClickListener(new OnItemClickListenerImpl());
		
		tag_request =SendRequestUtil.TAG_CFACTORYINFO_REQUEST;
		SendRequestUtil.cfactoryHandler = handler;
		if (!list.get(11).equals("")) {
			String[] str = list.get(11).split(",");
			for (int i=0;i<str.length;i++) {
				mPathNews.add(str[i]);
			}
		}
//		mAddView = (NineGridView) findViewById(R.id.addview_content);
//		mAddView.setAdapter(mPathNews);
	}
	
	private List<String> dataToList(CFactoryData cf) {
		list = new ArrayList<String>();
		if (cf == null) {
			list.add("");
			list.add("");
			list.add("0");
			list.add("");
			list.add("0");
			list.add("0");
			list.add("0");
			list.add("0");
			list.add("0");
			list.add("0");
			list.add("0");
			list.add("");
		} else {
			list.add(cf.getCfactoryName());
			list.add(cf.getCfactoryAddress());
			list.add(String.valueOf(cf.getCfactoryScale()));
			list.add(cf.getCbuildTime());
			list.add(String.valueOf(cf.getCfactoryType()));
			list.add(String.valueOf(cf.getCfactoryMode()));
			list.add(String.valueOf(cf.getCroomType()));
			list.add(String.valueOf(cf.getCwaterSupply()));
			list.add(String.valueOf(cf.getCfoodSupply()));
			list.add(String.valueOf(cf.getClearExcrement()));
			list.add(String.valueOf(cf.getCgroupStyle()));
			list.add(cf.getPicnames());
			
		}
		return list;
		
	}

	private class OnItemClickListenerImpl implements OnItemClickListener {

		public void onItemClick(AdapterView<?> parent, View view, int position,
				long id) {
			switch (position) {
			case 0:
			case 1:
			case 3:
				showEditDialog(position);
				break;
			case 2:
			case 4:
			case 5:
			case 6:
			case 7:
			case 8:
			case 9:
			case 10:
				showSelectDialog(position);
				break;
			case 11:
				Intent intent = new Intent(HouseInfoActivity.this, HouseLayoutActivity.class);
				intent.putStringArrayListExtra("pic", mPathNews);
				startActivityForResult(intent, 1);
				break;
			default:
				break;
			
		}
		}
	}
	
	public boolean onCreateOptionsMenu(Menu menu) {
        super.onCreateOptionsMenu(menu);
        MenuItem add=menu.add(0,0,0,"add");
        //绑定到ActionBar  
        add.setShowAsAction(MenuItem.SHOW_AS_ACTION_IF_ROOM);
        return true;
    }

	class DemoAdapter extends BaseAdapter {
		private List<String> datas;
		private LayoutInflater mInfalter;

		class HolderView {
			TextView houseContent, houseType;
		}

		public DemoAdapter(Context context, List<String> datas) {
			this.datas = datas;
			this.mInfalter = LayoutInflater.from(context);
		}

		public void updateView(List<String> datas) {
			this.datas = datas;
			this.notifyDataSetChanged();
		}

		@Override
		public int getCount() {
			return datas.size();
		}

		@Override
		public Object getItem(int position) {
			return datas.get(position);
		}

		@Override
		public long getItemId(int position) {
			return position;
		}

		@Override
		public View getView(final int position, View convertView, ViewGroup parent) {
			HolderView holderView;
			if (convertView == null) {
				holderView = new HolderView();
				convertView = mInfalter.inflate(R.layout.houseinfo_item, null);
				holderView.houseType = (TextView) convertView
						.findViewById(R.id.house_type);
				holderView.houseContent = (TextView) convertView
						.findViewById(R.id.house_content);
				convertView.setTag(holderView);
			} else {
				holderView = (HolderView) convertView.getTag();
			}
		
			holderView.houseType.setText(mTypedArray.getString(position));
			String[] colors;
			if (position == 11) {
				if (!list.get(11).equals("")) {
					holderView.houseContent.setText(list.get(11).split(",").length+"张图片");
				} else {
					holderView.houseContent.setText("无图片");
				}
			} else if (position==0||position==1||position==3) {
				holderView.houseContent.setText(list.get(position));
			} else if (position==2) {
				colors = HouseInfoActivity.this.getResources().getStringArray(R.array.factoryscale_items);
				holderView.houseContent.setText(colors[Integer.valueOf(list.get(position))]);
			} else if (position==4) {
				colors = HouseInfoActivity.this.getResources().getStringArray(R.array.factorytype_items);
				holderView.houseContent.setText(colors[Integer.valueOf(list.get(position))]);
			} else if (position==5) {
				colors = HouseInfoActivity.this.getResources().getStringArray(R.array.factorymode_items);
				holderView.houseContent.setText(colors[Integer.valueOf(list.get(position))]);
			} else if (position==6) {
				colors = HouseInfoActivity.this.getResources().getStringArray(R.array.roomtype_items);
				holderView.houseContent.setText(colors[Integer.valueOf(list.get(position))]);
			} else if (position==7) {
				colors = HouseInfoActivity.this.getResources().getStringArray(R.array.watersupply_items);
				holderView.houseContent.setText(colors[Integer.valueOf(list.get(position))]);
			} else if (position==8) {
				colors = HouseInfoActivity.this.getResources().getStringArray(R.array.foodsupply_items);
				holderView.houseContent.setText(colors[Integer.valueOf(list.get(position))]);
			} else if (position==9) {
				colors = HouseInfoActivity.this.getResources().getStringArray(R.array.clearexcrement_items);
				holderView.houseContent.setText(colors[Integer.valueOf(list.get(position))]);
			} else if (position==10) {
				colors = HouseInfoActivity.this.getResources().getStringArray(R.array.cgroupstyle_items);
				holderView.houseContent.setText(colors[Integer.valueOf(list.get(position))]);
			}
			return convertView;
		}
	}
	public void showSelectDialog(int position) {
		final int ss = position;
		int items = 0;
		if (position == 2) {
			items = R.array.factoryscale_items;
		} else if (position == 4) {
			items = R.array.factorytype_items;
		} else if (position == 5) {
			items = R.array.factorymode_items;
		} else if (position == 6) {
			items = R.array.roomtype_items;
		} else if (position == 7) {
			items = R.array.watersupply_items;
		} else if (position == 8) {
			items = R.array.foodsupply_items;
		} else if (position == 9) {
			items = R.array.clearexcrement_items;
		} else if (position == 10) {
			items = R.array.cgroupstyle_items;
		}
		
		
		new AlertDialog.Builder(this)
				.setTitle("选择"+mTypedArray.getString(position)+"?")
				.setItems(items,
						new DialogInterface.OnClickListener() {
							@Override
							public void onClick(DialogInterface dialog,
									int which) {
								if (!String.valueOf(which).equals(list.get(ss))) {
		                    		list.set(ss,String.valueOf(which));
			                    	listAdapter.updateView(list);
			                    	if (cfactory == null) {
			                    		SendRequestUtil.makeCFactoryRequest(-1,list);
			                    	} else {
			                    		SendRequestUtil.makeCFactoryRequest(cfactory.getCfactoryId(),list);
		                    	
			                    	}
		                    	}
							}
						}).show();
	}
	
	public void showEditDialog(int position) {
		final int ss = position;
		final EditText inputServer = new EditText(HouseInfoActivity.this);
        inputServer.setFocusable(true);
        inputServer.setText(list.get(position));
        AlertDialog.Builder builder = new AlertDialog.Builder(HouseInfoActivity.this);
        builder.setTitle("更改"+mTypedArray.getString(position)+"?")
        	.setView(inputServer)
        	.setNegativeButton(getString(R.string.cancel), null);
        builder.setPositiveButton(getString(R.string.confirm),
                new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface dialog, int which) {
                    	if (!inputServer.getText().toString().equals(list.get(ss))) {
                    		list.set(ss,inputServer.getText().toString());
	                    	listAdapter.updateView(list);
	                    	if (cfactory == null) {
	                    		SendRequestUtil.makeCFactoryRequest(-1,list);
	                    	} else {
	                    		SendRequestUtil.makeCFactoryRequest(cfactory.getCfactoryId(),list);
                    	
	                    	}
                    	}
                    }

                });
        builder.show();
	}
	
	private OnClickListener mBackListener = new OnClickListener() {
		public void onClick(View view) {
			onBackPressed();
		}
	};
	
	
	
	protected void onActivityResult(int requestCode, int resultCode, Intent data) {
		if (resultCode == 1&&data != null) {
			list.set(11, data.getStringExtra("pic"));
			if (cfactory == null) {
        		SendRequestUtil.makeCFactoryRequest(-1,list);
        	} else {
        		SendRequestUtil.makeCFactoryRequest(cfactory.getCfactoryId(),list);
        	}
			listAdapter.updateView(list);
		}
		super.onActivityResult(requestCode, resultCode, data);
	}

	@Override
	protected void requestFail(Message msg) {
		list.clear();
		list = dataToList(cfactory);
		listAdapter.updateView(list);
		ToastUtil.showToast(this, R.string.request_fail);
	}

	@Override
	protected void requestSuccess(Message msg) {
		CFactoryInfoResp info = (CFactoryInfoResp)msg.obj;
		if (info.getResult()) {
			Intent intent = new Intent();
			Bundle bundle = new Bundle();
			bundle.putSerializable("cfactoryinfo", info.getData());
			cfactory = info.getData();
			AppConfig.cfactoryid = cfactory.getCfactoryId();
			intent.putExtras(bundle);
			setResult(2, intent); 

		} else {
			list.clear();
			list = dataToList(cfactory);
			listAdapter.updateView(list);
			ToastUtil.showToast(this, info.getInfo());
			
		}
	}

}
