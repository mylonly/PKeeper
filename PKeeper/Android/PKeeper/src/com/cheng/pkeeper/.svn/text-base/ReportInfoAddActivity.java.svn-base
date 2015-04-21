package com.cheng.pkeeper;

import java.io.File;
import java.util.ArrayList;
import java.util.Map;

import com.cheng.pkeeper.data.ReportData;
import com.cheng.pkeeper.http.RequestAddress;
import com.cheng.pkeeper.http.SendRequestUtil;
import com.cheng.pkeeper.util.Constants;
import com.cheng.pkeeper.util.NineGridView;
import com.cheng.pkeeper.util.TitleView;
import com.cheng.pkeeper.util.ToastUtil;
import com.cheng.pkeeper.util.NineGridView.OnDeleteListener;
import com.upyun.block.api.listener.CompleteListener;
import com.upyun.block.api.listener.ProgressListener;
import com.upyun.block.api.main.UploaderManager;

import android.content.Intent;
import android.database.Cursor;
import android.net.Uri;
import android.os.AsyncTask;
import android.os.Bundle;
import android.os.Message;
import android.provider.MediaStore;
import android.util.Log;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.LinearLayout;

public class ReportInfoAddActivity extends AppBasicActivity {

	private ImageView repoinfo_add;
	private NineGridView mAddView;
	public ArrayList<String> mPathNews = new ArrayList<String>();
	private EditText title;
	private EditText detail;
	private LinearLayout pb;
	private final String savePath = "/android/reportinfo";
	
	public void onCreate(Bundle savedInstanceState) {
		
		super.onCreate(savedInstanceState);
		setContentView(R.layout.reportinfo_add);
		TitleView mTitleView = (TitleView) findViewById(R.id.titleview);
		mTitleView.setTitle(R.string.reportinfo);
		mTitleView.setBackButton(mBackListener);
		mTitleView.setRightButton(getResources().getString(R.string.submit),
				0, mPublishListener);
		
		tag_request =SendRequestUtil.TAG_REPORTINFOADD_REQUEST;
		SendRequestUtil.reportinfoaddHandler = handler;
		title = (EditText)findViewById(R.id.edittext_title);
		detail = (EditText)findViewById(R.id.edittext_detail);
		pb = (LinearLayout)findViewById(R.id.progbar_loading);
		repoinfo_add = (ImageView)findViewById(R.id.iv_repoinfo_add);
		repoinfo_add.setOnClickListener(new ImageSetectListener());
		mAddView = (NineGridView) findViewById(R.id.addview_content);
		mAddView.setAdapter(mPathNews);
		mAddView.setOnDeleteListener(mOnDeleteListener);
	}
	
	private class ImageSetectListener implements OnClickListener {
		
		public void onClick(View v) {
			if (mPathNews != null && mPathNews.size() ==9) {
				ToastUtil.showToast(ReportInfoAddActivity.this, "图片数量已达上限");
				return;
			}
		 	Intent intent = new Intent();
	        intent.setType("image/*");
	        intent.setAction(Intent.ACTION_GET_CONTENT); 
	        startActivityForResult(intent, 1);
		}
    	
    }

	protected void onActivityResult(int requestCode, int resultCode, Intent data) {
		if (resultCode == RESULT_OK) {
			Uri uri = data.getData();
			Log.i("uri", uri.toString());
			mPathNews.add(uri.toString());
			mAddView.notifyDataSetChanged(mPathNews);
		}
		super.onActivityResult(requestCode, resultCode, data);
	}
	
	@Override
	protected void requestFail(Message msg) {
		ToastUtil.showToast(ReportInfoAddActivity.this, R.string.request_fail);
		pb.setVisibility(View.GONE);
	}

	@Override
	protected void requestSuccess(Message msg) {
		Intent intent = new Intent();
		Bundle bundle = new Bundle();
		ReportData data = new ReportData();
		data.setPic(file);
		data.setTitle(title.getText().toString());
		data.setDesc(detail.getText().toString());
		bundle.putSerializable("data", data);
		intent.putExtras(bundle);
		setResult(0, intent);
		finish();
	}
	
	private OnDeleteListener mOnDeleteListener = new OnDeleteListener() {

		@Override
		public void delete(int pos) {
			mPathNews.remove(pos);
		}
	};
	String file ="";
	private OnClickListener mPublishListener = new OnClickListener() {
		public void onClick(View view) {
			pb.setVisibility(View.VISIBLE);
			String file = "";
			for (int i=0;i<mPathNews.size()&&mPathNews.get(i).startsWith("http");i++) {
				if (file.equals("")) {
					file = mPathNews.get(i);
				} else {
					file += ","+ mPathNews.get(i);
				}
			}
			Log.i(TAG,"httpfile:"+file);
			Cursor cursor = null;
			for (int i=0;i<mPathNews.size();i++) {
				Log.i(TAG,"httpfile:"+mPathNews.get(i));
				if (!mPathNews.get(i).startsWith("http")) {
					String[] proj = { MediaStore.Images.Media.DATA };  
					cursor = managedQuery(Uri.parse(mPathNews.get(i)), proj, null, null, null);  
					int column_index = cursor.getColumnIndexOrThrow(MediaStore.Images.Media.DATA);  
					if (cursor.moveToFirst()) {  
						String path = cursor.getString(column_index);  
						if (file.equals("")&&!mPathNews.get(i).startsWith("http")) {
								  
							file = RequestAddress.getUpyunDownloadUrl()
									+savePath+"/"
									+path.substring(path.lastIndexOf("/")+1);
							Log.i(TAG,"localfile1:"+file);
						} else {
							file += ","+RequestAddress.getUpyunDownloadUrl()
									+savePath+"/"
									+path.substring(path.lastIndexOf("/")+1);
							Log.i(TAG,"localfile2:"+file);
						}
						new UploadTask(path).execute();
					}
				}
			}
			if (cursor != null) {
				cursor.close();
			}
			Log.i(TAG,"file:"+file);
				
				if (!title.getText().toString().equals("")){
					SendRequestUtil.makeReportInfoAddRequest(
							title.getText().toString(),detail.getText().toString(),file);
				} else {
					ToastUtil.showToast(ReportInfoAddActivity.this, "请输入要提交内容");
				}
			
		}
	
	};
	
	public class UploadTask extends AsyncTask<Void, Void, String> {
		String path;
		public UploadTask(String path) {
			this.path = path;
		}

		@Override
		protected String doInBackground(Void... params) {
			
			try {
				 /** 设置进度条回掉函数
				 * 
				 * 注意：由于在计算发送的字节数中包含了图片以外的其他信息，最终上传的大小总是大于图片实际大小，
				 * 为了解决这个问题，代码会判断如果实际传送的大小大于图片
				 * ，就将实际传送的大小设置成'fileSize-1000'（最小为0）*/
				 
				ProgressListener progressListener = new ProgressListener() {
					@Override
					public void transferred(long transferedBytes, long totalBytes) {
						// do something...
						System.out.println("trans:" + transferedBytes + "; total:" + totalBytes);
					}
				};
				
				CompleteListener completeListener = new CompleteListener() {
					@Override
					public void result(boolean isComplete, String result, String error) {
						// do something...
						System.out.println("isComplete:"+isComplete+";result:"+result+";error:"+error);
						if (isComplete) {
						} else {
							ToastUtil.showToast(ReportInfoAddActivity.this, "图片上传失败:"+result);
						}
						
					}
				};
				
					File localFile = new File(path);
					UploaderManager uploaderManager = UploaderManager.getInstance(Constants.bucket);
					uploaderManager.setConnectTimeout(60);
					uploaderManager.setResponseTimeout(60);
					Map<String, Object> paramsMap = uploaderManager.fetchFileInfoDictionaryWith(localFile, savePath+"/"
							+localFile.getName());
					paramsMap.put("return_url", "");
					// signature & policy 建议从服务端获取
					String policyForInitial = com.upyun.block.api.utils.UpYunUtils.getPolicy(paramsMap);
					String signatureForInitial = com.upyun.block.api.utils.UpYunUtils.getSignature(paramsMap, Constants.formApiSecret);
					uploaderManager.upload(policyForInitial, signatureForInitial, localFile, progressListener, completeListener);
//				//取得base64编码后的policy
//				final long EXPIRATION = System.currentTimeMillis()/1000 + 1000 * 5 * 10; //过期时间，必须大于当前时间
//				String policy = UpYunUtils.makePolicy(savePath+"/"+fileName, EXPIRATION, bucket);
//				
//				//根据表单api签名密钥对policy进行签名
//				//通常我们建议这一步在用户自己的服务器上进行，并通过http请求取得签名后的结果。
//				String signature = UpYunUtils.signature(policy + "&" + formApiSecret);
//				
//				string = Uploader
//						.upload(policy, signature , bucket, file);
				
			} catch (Exception e) {
				e.printStackTrace();
			}
			return "result";
		}

		@Override
		protected void onPostExecute(String result) {
			super.onPostExecute(result);
//			if (result != null) {
//				Toast.makeText(getApplicationContext(), "成功", Toast.LENGTH_LONG).show();
//			} else {
//				Toast.makeText(getApplicationContext(), "失败", Toast.LENGTH_LONG).show();
//			}
		}
	}
	private OnClickListener mBackListener = new OnClickListener() {
		public void onClick(View view) {
			onBackPressed();
		}
	};
}

