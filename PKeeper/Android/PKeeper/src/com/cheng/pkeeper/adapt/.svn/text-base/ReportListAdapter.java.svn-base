package com.cheng.pkeeper.adapt;

import java.util.ArrayList;

import com.cheng.pkeeper.R;
import com.cheng.pkeeper.adapt.UserAdapter.HolderView;
import com.cheng.pkeeper.data.ReportData;
import com.cheng.pkeeper.http.RequestAddress;
import com.cheng.pkeeper.util.ImageUtils;
import com.nostra13.universalimageloader.core.ImageLoader;

import android.app.Activity;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

public class ReportListAdapter extends ArrayListAdapter<ReportData>{
	
	
	public ReportListAdapter(Activity context){
		super(context);
	}


	@Override
	public View getView(int position, View convertView, ViewGroup parent) {
		HolderView holderView;

		if (convertView == null) {
			holderView = new HolderView();
			convertView = mContext.getLayoutInflater().inflate(R.layout.reportinfo_item, null);
			holderView.reportinfo = (ImageView) convertView
					.findViewById(R.id.iv_repoinfo);
			holderView.reportinfoContent = (TextView) convertView
					.findViewById(R.id.repoinfo_content);
			holderView.reportType = (ImageView) convertView
			.findViewById(R.id.iv_repoinfo_type);
			convertView.setTag(holderView);

		} else {
			holderView = (HolderView) convertView.getTag();
		}
//		holderView.reportinfoContent.setText(mList.get(position).getTitle());
		holderView.reportType.setBackgroundResource(mList.get(position).getResuserid() != 0?
				R.drawable.report_reply:R.drawable.report_noreply);
		
		holderView.reportinfoContent.setText(mList.get(position).getDesc());
		String path = mList.get(position).getPic().split(",")[0];
		if (path != null&&path.length() !=0) {
			holderView.reportinfo.setVisibility(View.VISIBLE);
			if (path.startsWith("http")) {
				ImageLoader.getInstance().displayImage(path, holderView.reportinfo,
						ImageUtils.optionAlbum);
			} else {
				ImageLoader.getInstance().displayImage(RequestAddress.getUpyunDownloadUrl()+"/"+path.replace("\\", "/"), holderView.reportinfo,
						ImageUtils.optionAlbum);
			}
		}
		return convertView;
	}

	class HolderView {
		ImageView reportinfo;
		TextView reportinfoContent;
		ImageView reportType;
	}


}
