package com.cheng.pkeeper.adapt;

import java.util.ArrayList;
import java.util.List;

import com.cheng.pkeeper.R;
import com.cheng.pkeeper.adapt.UserAdapter.HolderView;
import com.cheng.pkeeper.data.BusinessData;
import com.cheng.pkeeper.data.FirstStageData;

import android.app.Activity;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

public class FirstStageAdapter extends ArrayListAdapter<FirstStageData>{
	
	private static final String TAG = "FirstStageAdapter";
	private int stage;


	public FirstStageAdapter(Activity context){
		super(context);
	}


	public View getView(int position, View convertView, ViewGroup parent) {
	    // TODO Auto-generated method stub
	    HolderView holderView;
	    
	    if(convertView == null){
	      holderView = new HolderView();
	      convertView = mContext.getLayoutInflater().inflate(R.layout.keepinfo_item, null);
	      holderView.day = (TextView) convertView.findViewById(R.id.textView1);
	      holderView.status = (TextView) convertView.findViewById(R.id.textView2);
	      holderView.iv = (ImageView) convertView.findViewById(R.id.imageButton1);
	      convertView.setTag(holderView);
	      
	    }else{
	      holderView =(HolderView) convertView.getTag();
	    }
	    Log.i(TAG,"day"+mList.get(position).getDay());
	    	if (stage ==0) {
	    		holderView.day.setText(String.format(mContext.getString(R.string.day_num),(15 - position)));
	    		holderView.status.setText((mList.get(position).getDay() != 0)?"已记录":"未记录");
			    holderView.iv.setBackgroundResource((mList.get(position).getDay() != 0)?R.drawable.keepinfo_08:R.drawable.keepinfo_07);
	    	} else if (stage ==1) {
	    		holderView.day.setText(String.format(mContext.getString(R.string.day_num),( 1 + position)));
	    		holderView.status.setText((mList.get(position).getDay() != 0)?"已记录":"未记录");
			    holderView.iv.setBackgroundResource((mList.get(position).getDay() != 0)?R.drawable.keepinfo_08:R.drawable.keepinfo_07);
	    	} else {
	    		Log.i(TAG,mList.get(position).getRecordtime());
	    		if (mList.get(position).getRecordtime().length()>5) {
	    			holderView.day.setText(mList.get(position).getRecordtime().substring(5));
	    		} else {
	    			holderView.day.setText(mList.get(position).getRecordtime());
	    		}
	    		holderView.status.setText("已记录");
			    holderView.iv.setBackgroundResource(R.drawable.keepinfo_08);
	    	}
	    	
	    	
		    
	    
	    
	    return convertView;
	  }

	public void updataList(List<FirstStageData> list,int stage ){
		this.stage = stage;
		if (stage == 0) {
			mList = new ArrayList<FirstStageData>(15);
			for (int i =0;i<15;i++) {
				FirstStageData dd = new FirstStageData();
				if (list==null || list.size() ==0) {
					mList.add(dd);
					continue;
				}
				for (int j=0;j<list.size();j++) {
					if (list.get(j).getDay() == i+1) {
						dd =list.get(j);
						break;
					} 
				}
				mList.add(dd);
			}
		} else if(stage == 1) {
			mList = new ArrayList<FirstStageData>(48);
			for (int i =0;i<48;i++) {
				FirstStageData dd = new FirstStageData();
				if (list==null || list.size() ==0) {
					mList.add(dd);
					continue;
				}
				for (int j=0;j<list.size();j++) {
					if (list.get(j).getDay() == i+1) {
						dd = list.get(j);
						break;
					}
				}
				mList.add(dd);
			}
		} else {
			if (list == null) {
				mList = new ArrayList<FirstStageData>();
			} else {
				mList = (ArrayList<FirstStageData>) list;
			}
		}
		
	}


		class HolderView{
				ImageView iv;
			    TextView day,status;
		}


}
