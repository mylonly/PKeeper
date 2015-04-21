package com.cheng.pkeeper.adapt;

import java.util.List;

import com.cheng.pkeeper.R;
import com.cheng.pkeeper.data.AttachmentsData;
import com.cheng.pkeeper.data.BusinessData;
import com.cheng.pkeeper.http.RequestAddress;
import com.cheng.pkeeper.http.RequestAddress.Address;
import com.cheng.pkeeper.util.ImageUtils;
import com.nostra13.universalimageloader.core.ImageLoader;

import android.app.Activity;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

public class BusinessListAdapter extends ArrayListAdapter<BusinessData>{
	
	
	public BusinessListAdapter(Activity context){
		super(context);
	}


	@Override
	public View getView(int position, View convertView, ViewGroup parent) {
		HolderView holderView;

		if (convertView == null) {
			holderView = new HolderView();
			convertView = mContext.getLayoutInflater().inflate(R.layout.business_item, null);
			holderView.iv_business = (ImageView) convertView
					.findViewById(R.id.iv_businessitem);
			holderView.businessTitle = (TextView) convertView
					.findViewById(R.id.businessitem_title);
			holderView.businessContent = (TextView) convertView
			.findViewById(R.id.businessitem_content);
			holderView.businessDate = (TextView) convertView
					.findViewById(R.id.businessitem_date);
			convertView.setTag(holderView);

		} else {
			holderView = (HolderView) convertView.getTag();
		}
//		holderView.reportinfoContent.setText(mList.get(position).getTitle());
		holderView.businessTitle.setText(mList.get(position).getTitle());
		holderView.businessContent.setText(mList.get(position).getDocabstract());
		if (mList.get(position).getPublishtime().length()>10) {
			holderView.businessDate.setText(mList.get(position).getPublishtime().substring(0, 9));
		} else {
			holderView.businessDate.setText(mList.get(position).getPublishtime());
		}
		
		List<AttachmentsData> list = mList.get(position).getAttachments();
		String path = null;
		for (AttachmentsData ll:list) {
			ll.getType().equals("pic");
			path = ll.getAttachAddr();
			break;
		}
		if (path != null&&path.length() !=0) {
			holderView.iv_business.setVisibility(View.VISIBLE);
			if (path.startsWith("http")) {
				ImageLoader.getInstance().displayImage(path.replace("\\", "/"), 
						holderView.iv_business,
						ImageUtils.optionAlbum);
			} else {
				ImageLoader.getInstance().displayImage(RequestAddress.getUpyunDownloadUrl()+"/"+path.replace("\\", "/"), 
						holderView.iv_business,
						ImageUtils.optionAlbum);
			}
		}
		
		return convertView;
	}

	class HolderView {
		ImageView iv_business;
		TextView businessTitle;
		TextView businessContent;
		TextView businessDate;
	}


}
