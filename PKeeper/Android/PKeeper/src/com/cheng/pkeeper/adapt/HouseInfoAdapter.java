package com.cheng.pkeeper.adapt;
//package com.example.mytest.adapt;
//
//import java.util.List;
//
//import com.example.mytest.ApkBean;
//import com.example.mytest.HouseInfoActivity;
//import com.example.mytest.R;
//
//import android.app.AlertDialog;
//import android.content.Context;
//import android.content.DialogInterface;
//import android.view.LayoutInflater;
//import android.view.View;
//import android.view.ViewGroup;
//import android.view.View.OnClickListener;
//import android.widget.BaseAdapter;
//import android.widget.EditText;
//import android.widget.ImageView;
//import android.widget.RelativeLayout;
//import android.widget.TextView;
//
//public class HouseInfoAdapter extends BaseAdapter {
//		private List<MyData> datas;
//		private LayoutInflater mInfalter;
//		private Context context;
//
//		class HolderView {
//			TextView houseContent, houseType;
//			RelativeLayout content2;
//		}
//
//		public HouseInfoAdapter(Context context, List<MyData> datas) {
//			this.datas = datas;
//			this.context = context;
//			this.mInfalter = LayoutInflater.from(context);
//		}
//
//		public void updateView(List<MyData> datas) {
//			this.datas = datas;
//			this.notifyDataSetChanged();
//		}
//
//		@Override
//		public int getCount() {
//			return datas.size();
//		}
//
//		@Override
//		public Object getItem(int position) {
//			return datas.get(position);
//		}
//
//		@Override
//		public long getItemId(int position) {
//			return position;
//		}
//
//		@Override
//		public View getView(final int position, View convertView, ViewGroup parent) {
//			HolderView holderView;
//			MyData data = datas.get(position);
//			if (convertView == null) {
//				holderView = new HolderView();
//				convertView = mInfalter.inflate(R.layout.houseinfo_item, null);
//				holderView.houseType = (TextView) convertView
//						.findViewById(R.id.house_type);
//				holderView.houseContent = (TextView) convertView
//						.findViewById(R.id.house_content);
//				holderView.content2 = (RelativeLayout) convertView
//						.findViewById(R.id.content2);
//				convertView.setTag(holderView);
//			} else {
//				holderView = (HolderView) convertView.getTag();
//			}
//			if (data.expand) {
//
//				holderView.content2.setVisibility(View.VISIBLE);
//				holderView.content2.setOnClickListener(new OnClickListener(){
//
//					@Override
//					public void onClick(View v) {
//						final int ss = position;
//						final EditText inputServer = new EditText(context);
//				        inputServer.setFocusable(true);
//				        inputServer.setText(datas.get(position).getDateString()+"123");
//				        AlertDialog.Builder builder = new AlertDialog.Builder(context);
//				        builder.setTitle("更改"+mTypedArray.getString(position)+"?")
//				        	.setView(inputServer)
//				        	.setNegativeButton(context.getString(R.string.cancel), null);
//				        builder.setPositiveButton(context.getString(R.string.confirm),
//				                new DialogInterface.OnClickListener() {
//				                    public void onClick(DialogInterface dialog, int which) {
////				                    	if (!inputServer.getText().toString().equals(userList.get(ss))) {
////				                    		userList.set(ss, inputServer.getText().toString());
////					                    	listAdapter.updateView(userList);
////					                    	SendRequestUtil.makeUserInfoRequest(user.getUserId(),userList);
////				                    	}
//				                    }
//
//				                });
//				        builder.show();
//					}
//					
//				});
//			} else {
//				holderView.content2.setVisibility(View.GONE);
//			}
//		
//			holderView.houseType.setText(mTypedArray.getString(position));
//			holderView.houseContent.setText(datas.get(position).getDateString()+"123");
//			return convertView;
//		}
//	}
//	
//	class MyData{
//		boolean expand;
//		private String content;
//		private String dateString;
//		public String getContent() {
//			return content;
//		}
//
//		public void setContent(String content) {
//			this.content = content;
//		}
//
//		public String getDateString() {
//			return dateString;
//		}
//
//		public void setDateString(String dateString) {
//			this.dateString = dateString;
//		}
//	}