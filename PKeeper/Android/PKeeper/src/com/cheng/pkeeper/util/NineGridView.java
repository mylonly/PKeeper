package com.cheng.pkeeper.util;

import java.util.ArrayList;

import com.cheng.pkeeper.AppConfig;
import com.cheng.pkeeper.R;
import com.nostra13.universalimageloader.core.ImageLoader;

import android.app.AlertDialog;
import android.app.Dialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.drawable.BitmapDrawable;
import android.net.Uri;
import android.text.TextUtils;
import android.util.AttributeSet;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.AdapterView.OnItemClickListener;
import android.widget.AdapterView.OnItemLongClickListener;
import android.widget.BaseAdapter;
import android.widget.FrameLayout;
import android.widget.GridView;
import android.widget.ImageView;
import android.widget.ImageView.ScaleType;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;

public class NineGridView extends FrameLayout {
	/**
	 * 九宫格
	 */
	private GridView mGridView;
	private int column;
	private int spacing;
	private int width;
	private boolean add = false;
	private Context mContext;
	private OnClickListener mOnClickListener;
	private ArrayList<String> mPaths;
	private GridAdapter mAdapter;
	private boolean need_download = false;

	public NineGridView(Context context) {
		this(context, null);
	}

	public NineGridView(Context context, AttributeSet attrs) {
		this(context, attrs, 0);
	}

	public NineGridView(Context context, AttributeSet attrs, int defStyle) {
		super(context, attrs, defStyle);
		LayoutInflater inflater = (LayoutInflater) context
				.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
		inflater.inflate(R.layout.nine_grid_view, this, true);
		this.mContext = context;
		mGridView = (GridView) findViewById(R.id.nine_gridview);
		mGridView.setOnItemClickListener(mOnItemClickListener);
		mGridView.setOnItemLongClickListener(mOnItemLongClickListener);
		init(3, 15);
	}

	public void init(int colum, int spac) {
		this.column = colum;
		this.spacing = spac;
		int margin = (int) mContext.getResources().getDimension(
				R.dimen.theme_padding);
		width = (int) ((AppConfig.screenWidth - margin * 2 - spacing
				* (column - 1)) / column);
		mGridView.setNumColumns(column);
		mGridView.setHorizontalSpacing(spacing);
		mGridView.setVerticalSpacing(spacing);
	}

	private OnItemLongClickListener mOnItemLongClickListener = new OnItemLongClickListener() {

		@Override
		public boolean onItemLongClick(AdapterView<?> arg0, View arg1,
				int arg2, long arg3) {
			if (mDeleteListener != null) {
//				dialog = Dialog().showAlertDialog(mContext, "", mContext
//						.getResources().getString(R.string.delete_image),
//						mContext.getResources().getString(R.string.confirm),
//						deleteClick);
				AlertDialog.Builder builder = new AlertDialog.Builder(mContext);
				builder.setMessage(mContext.getResources().getString(R.string.delete_image))
				       .setCancelable(false)
				       .setPositiveButton(mContext.getResources().getString(R.string.confirm), 
				    		   new DialogInterface.OnClickListener() {
				           public void onClick(DialogInterface dialog, int id) {
				        	   mPaths.remove(deletePos);
				   			mAdapter.notifyDataSetChanged();
				   			setLayoutParams();
				   			if (mDeleteListener != null)
				   				mDeleteListener.delete(deletePos);
				   			dialog.dismiss();
				           }
				       })
				       .setNegativeButton(mContext.getResources().getString(R.string.cancel),
				    		   new DialogInterface.OnClickListener() {
				           public void onClick(DialogInterface dialog, int id) {
				                dialog.cancel();
				           }
				       });
				AlertDialog alert = builder.create();
				alert.show();
				deletePos = arg2;
			}
			return true;
		}
	};
	private int deletePos;
	private android.app.Dialog dialog;
//	private OnClickListener deleteClick = new OnClickListener() {
//
//		@Override
//		public void onClick(View view) {
//			mPaths.remove(deletePos);
//			mAdapter.notifyDataSetChanged();
//			setLayoutParams();
//			if (mDeleteListener != null)
//				mDeleteListener.delete(deletePos);
//			dialog.dismiss();
//		}
//	};
	private OnItemClickListener mOnItemClickListener = new OnItemClickListener() {

		@Override
		public void onItemClick(AdapterView<?> arg0, View arg1, int arg2,
				long arg3) {
//			if (arg2 < mPaths.size()) {
//					Intent intent = new Intent(mContext,
//							ImagePagerActivity.class);
//					intent.putExtra(Constant.KEY_IMAGE_LIST, mPaths);
//					intent.putExtra(Constant.KEY_IMAGE_INDEX, arg2);
//					intent.putExtra(Constant.KEY_NEED_DOWNLOAD, need_download);
//					mContext.startActivity(intent);
//			}
		}
	};

	public void setOnItemClickListener(OnItemClickListener onItemClickListener) {
		mGridView.setOnItemClickListener(onItemClickListener);
	}

	public void setOnItemLongClickListener(
			OnItemLongClickListener onItemLongClickListener) {
		mGridView.setOnItemLongClickListener(onItemLongClickListener);
	}

	public void setListener(OnItemClickListener onItemClickListener,
			OnItemLongClickListener onItemLongClickListener) {
		mGridView.setOnItemClickListener(onItemClickListener);
		mGridView.setOnItemLongClickListener(onItemLongClickListener);
	}

	public void setAdapter(int width, ArrayList<String> paths) {
		this.width = (int) ((width
				- mContext.getResources().getDimension(R.dimen.theme_padding)
				* 2 - spacing * (column - 1)) / column);
		setAdapter(paths);
	}

	/**
	 * 可添加
	 * 
	 * @param paths
	 * @param onClickListener
	 */
	public void setAdapter(ArrayList<String> paths,
			OnClickListener onClickListener) {
		this.add = true;
		this.mOnClickListener = onClickListener;
		setAdapter(paths);
	}

	public void setAdapter(ArrayList<String> paths) {
		mPaths = new ArrayList<String>();
		if (paths != null)
			mPaths.addAll(paths);
		mAdapter = new GridAdapter(mPaths);
		mGridView.setAdapter(mAdapter);
		setLayoutParams();
	}


	public void notifyDataSetChanged(ArrayList<String> paths) {
		mPaths.clear();
		mPaths.addAll(paths);
		mAdapter.notifyDataSetChanged();
		setLayoutParams();
	}

	private void setLayoutParams() {
		int total = 0;
		if (mPaths.size() == Constants.PIC_MAX_SIZE)
			total = mPaths.size();
		else {
			if (add)
				total = mPaths.size() + 1;
			else
				total = mPaths.size();
		}
		int row = total / column + (total % column == 0 ? 0 : 1);
		int height = width * row + spacing * (row - 1);
		LinearLayout.LayoutParams p = new LinearLayout.LayoutParams(
				LinearLayout.LayoutParams.MATCH_PARENT, height);
		if (total == 0)
			p.topMargin = 0;
		else
			p.topMargin = (int) (12 * AppConfig.density);
		this.setLayoutParams(p);
	}

	public void setNeedDownload(boolean need) {
		need_download = need;
	}

	private class GridAdapter extends BaseAdapter {
		private ArrayList<String> mPaths;

		public GridAdapter(ArrayList<String> paths) {
			this.mPaths = paths;
		}

		@Override
		public int getCount() {
			if (add) {
				if (mPaths.size() == Constants.PIC_MAX_SIZE)
					return mPaths.size();
				else
					return mPaths.size() + 1;
			} else
				return mPaths.size();
		}

		@Override
		public Object getItem(int arg0) {
			return null;
		}

		@Override
		public long getItemId(int arg0) {
			return 0;
		}

		@Override
		public View getView(int arg0, View arg1, ViewGroup arg2) {
			View layout = View.inflate(mContext, R.layout.item_nine_grid_view,
					null);
			ImageView iv = (ImageView) layout
					.findViewById(R.id.item_nine_grid_view_img);
			iv.setLayoutParams(new RelativeLayout.LayoutParams(width, width));
			layout.setLayoutParams(new GridView.LayoutParams(
					new GridView.LayoutParams(width, width)));
			iv.setScaleType(ScaleType.CENTER_CROP);
			if (add && mPaths.size() != Constants.PIC_MAX_SIZE
					&& arg0 == getCount() - 1) {
				iv.setImageResource(R.drawable.add_image);
				if (mOnClickListener != null)
					iv.setOnClickListener(mOnClickListener);
			} else {
				String path = mPaths.get(arg0);
//				if (path.startsWith("file://")) {
//
//				} else {
//					path = CommonParams
//							.getResizeMediaString(width, width, path);
//				}
				ImageLoader.getInstance().displayImage(path, iv,
						ImageUtils.optionAlbum);
			}
			return layout;
		}
	}

	// public void setOnAddClickListener(OnClickListener addListener) {
	// this.mOnClickListener = addListener;
	// }

	private OnDeleteListener mDeleteListener;

	public void setOnDeleteListener(OnDeleteListener onDeleteListener) {
		this.mDeleteListener = onDeleteListener;
	}

	public interface OnDeleteListener {
		public void delete(int pos);
	}
}
