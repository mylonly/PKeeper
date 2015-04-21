package com.cheng.pkeeper.adapt;

import java.util.List;

import com.cheng.pkeeper.R;

import android.content.Context;
import android.content.res.TypedArray;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.ImageView;
import android.widget.TextView;

public class UserAdapter extends BaseAdapter {
	private List<String> datas;
	private LayoutInflater mInfalter;
	private TypedArray mTypedArray1;
	private TypedArray mTypedArray2;

	public UserAdapter(Context context, List<String> list,
			TypedArray mTypedArray1, TypedArray mTypedArray2) {
		this.mTypedArray1 = mTypedArray1;
		this.mTypedArray2 = mTypedArray2;
		this.datas = list;
		this.mInfalter = LayoutInflater.from(context);
	}

	public void updateView(List<String> datas) {
		this.datas = datas;
		this.notifyDataSetChanged();
	}

	@Override
	public int getCount() {
		// TODO Auto-generated method stub
		return datas.size();
	}

	@Override
	public Object getItem(int position) {
		// TODO Auto-generated method stub
		return datas.get(position);
	}

	@Override
	public long getItemId(int position) {
		// TODO Auto-generated method stub
		return position;
	}

	@Override
	public View getView(int position, View convertView, ViewGroup parent) {
		HolderView holderView;

		if (convertView == null) {
			holderView = new HolderView();
			convertView = mInfalter.inflate(R.layout.userinfo_item, null);
			holderView.userinfoType = (ImageView) convertView
					.findViewById(R.id.iv_userinfo_type);
			holderView.userinfoContent = (TextView) convertView
					.findViewById(R.id.userinfo_content);
			holderView.userinfoTypeName = (TextView) convertView
			.findViewById(R.id.userinfo_type);
			convertView.setTag(holderView);

		} else {
			holderView = (HolderView) convertView.getTag();
		}
		holderView.userinfoContent.setText(datas.get(position));
		holderView.userinfoType.setBackgroundDrawable(mTypedArray1
				.getDrawable(position));
		holderView.userinfoTypeName.setText(mTypedArray2
				.getString(position));
		return convertView;
	}

	class HolderView {
		ImageView userinfoType;
		TextView userinfoTypeName;
		TextView userinfoContent;
		ImageView userType;
	}

}
