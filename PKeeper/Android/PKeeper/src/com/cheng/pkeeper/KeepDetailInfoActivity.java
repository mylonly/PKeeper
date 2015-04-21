package com.cheng.pkeeper;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Map;

import com.alibaba.fastjson.JSON;
import com.cheng.pkeeper.data.FirstStageData;
import com.cheng.pkeeper.data.StandarData;
import com.cheng.pkeeper.data.response.ScheduleResp;
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

import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.res.TypedArray;
import android.database.Cursor;
import android.net.Uri;
import android.os.AsyncTask;
import android.os.Bundle;
import android.os.Message;
import android.provider.MediaStore;
import android.text.InputType;
import android.util.Log;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.TextView;

public class KeepDetailInfoActivity extends AppBasicActivity implements OnClickListener {

	private ImageView keepinfo_add;
	private NineGridView mAddView;
	public ArrayList<String> mPathNews = new ArrayList<String>();
	
	private int stage;
	private String batchnum;
	private FirstStageData data;
	private EditText dosomething;
	private TextView dosome;
	private LinearLayout pb;
	private Button btn1;
	private Button btn2;
	private Button btn3;
	private Button btn4;
	private TextView content1;
	private TextView content2;
	private TextView content3;
	private TextView content4;
	private TextView content5;
	private TextView content6;
	private TextView content7;
	private TextView content8;
	private TextView content9;
	private TextView content10;
	private TextView content11;
	
	private boolean isadd;
	
	private final String savePath = "/android/keepinfo";
	
	public void onCreate(Bundle savedInstanceState) {

		super.onCreate(savedInstanceState);
		setContentView(R.layout.keepdetailinfo);
		
		TitleView mTitleView = (TitleView) findViewById(R.id.titleview);
		mTitleView.setTitle(R.string.keep_info_add);
		mTitleView.setBackButton(mBackListener);
		mTitleView.setRightButton(getResources().getString(R.string.submit),
				0, mPublishListener);
		TypedArray mTypedArray = getResources().obtainTypedArray(
				R.array.keepinfo_status3);
		mTitleView.setSubTitle("("+mTypedArray.getString(stage)+")");
		pb = (LinearLayout)findViewById(R.id.progbar_loading);
		
		Intent in = getIntent();
		stage  = in.getIntExtra("stage", 0);
		batchnum = in.getStringExtra("batchnum");
		
		data = (FirstStageData) in.getSerializableExtra("data");
		if (data == null) {
			isadd = true;
			data = new FirstStageData();
		}
		int day = in.getIntExtra("day", -1);
		if (day == -1) {
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");  
			String t=format.format(new Date());
			data.setRecordtime(t);

		} else {
//			if (stage == 0) {
//				data.setDay(14 - day);
//			} else {
				data.setDay(day);
//			}
			
		}
		
		TextView tv2= (TextView)findViewById(R.id.tv2);
		dosome = (TextView)findViewById(R.id.tv_should);
		dosomething = (EditText)findViewById(R.id.et_should);
		btn1= (Button)findViewById(R.id.btn_edit1);
		btn2= (Button)findViewById(R.id.btn_edit2);
		btn3= (Button)findViewById(R.id.btn_edit3);
		btn4= (Button)findViewById(R.id.btn_edit4);
		btn1.setOnClickListener(this);
		btn2.setOnClickListener(this);
		btn3.setOnClickListener(this);
		btn4.setOnClickListener(this);
		RelativeLayout r3 = (RelativeLayout)findViewById(R.id.rl3);
		RelativeLayout r2 = (RelativeLayout)findViewById(R.id.rl2);
		RelativeLayout r1 = (RelativeLayout)findViewById(R.id.rl1);
		if (stage == 0) {
			
			LinearLayout ll = (LinearLayout)findViewById(R.id.ll);
			ll.setVisibility(View.GONE);
			dosomething.setText(data.getDaycontent());
			SendRequestUtil.makeScheduleRequest(stage+1,day);
		} else if (stage == 1) {
			r2.setVisibility(View.GONE);
			r3.setVisibility(View.VISIBLE);
			SendRequestUtil.makeScheduleRequest(stage+1,day);
		} else {
			dosomething.setText(data.getDaycontent());
			r1.setVisibility(View.GONE);
			tv2.setText(R.string.keepdetail_status);
			
		}
		
		
		
		keepinfo_add = (ImageView)findViewById(R.id.iv_repoinfo_add);
		keepinfo_add.setOnClickListener(new ImageSetectListener());
		
		if (data.getPic() != null && !data.getPic().equals("")) {
			String[] str = data.getPic().split(",");
			for (int i=0;i<str.length;i++) {
				Log.i(TAG,str[i]);
				mPathNews.add(str[i]);
			}
		}
		
		mAddView = (NineGridView) findViewById(R.id.addview_content);
		mAddView.setAdapter(mPathNews);
		mAddView.setOnDeleteListener(mOnDeleteListener);
		
		tag_request =SendRequestUtil.TAG_SAVEKEEPINFO_REQUEST;
		SendRequestUtil.savekeepinfoHandler = handler;
	}
	
	@Override
	protected void onResume() {
		Log.i("TAG",JSON.toJSONString(data));
		super.onResume();
		if (data.getOutinsect() ==1) {
			btn4.setBackgroundResource(R.drawable.buttonstyle2);
		} 
		if (data.getDisinfect() ==1) {
			btn3.setBackgroundResource(R.drawable.buttonstyle2);
		} 
		if (data.getHealthcare() ==1) {
			btn2.setBackgroundResource(R.drawable.buttonstyle2);
		}
		if (data.getVaccine() ==1) {
			btn1.setBackgroundResource(R.drawable.buttonstyle2);
		}
		if (stage ==1) {
			RelativeLayout type1 = (RelativeLayout)findViewById(R.id.type1);
			type1.setOnClickListener(this);
			RelativeLayout type2 = (RelativeLayout)findViewById(R.id.type2);
			type2.setOnClickListener(this);
			RelativeLayout type3 = (RelativeLayout)findViewById(R.id.type3);
			type3.setOnClickListener(this);
			RelativeLayout type4 = (RelativeLayout)findViewById(R.id.type4);
			type4.setOnClickListener(this);
			RelativeLayout type5 = (RelativeLayout)findViewById(R.id.type5);
			type5.setOnClickListener(this);
			RelativeLayout type6 = (RelativeLayout)findViewById(R.id.type6);
			type6.setOnClickListener(this);
			RelativeLayout type7 = (RelativeLayout)findViewById(R.id.type7);
			type7.setOnClickListener(this);
			RelativeLayout type8 = (RelativeLayout)findViewById(R.id.type8);
			type8.setOnClickListener(this);
			RelativeLayout type9 = (RelativeLayout)findViewById(R.id.type9);
			type9.setOnClickListener(this);
			RelativeLayout type10 = (RelativeLayout)findViewById(R.id.type10);
			type10.setOnClickListener(this);
			RelativeLayout type11 = (RelativeLayout)findViewById(R.id.type11);
			type11.setOnClickListener(this);
			content1 = (TextView)findViewById(R.id.house_content1);
			content1.setText(String.valueOf(data.getEatfood()));
			content2 = (TextView)findViewById(R.id.house_content2);
			content2.setText(String.valueOf(data.getEatwater()));
			content3 = (TextView)findViewById(R.id.house_content3);
			content3.setText(String.valueOf(data.getEachweight()));
			content4 = (TextView)findViewById(R.id.house_content4);
			content4.setText(String.valueOf(data.getDeadcount()));
			content5 = (TextView)findViewById(R.id.house_content5);
			content5.setText(String.valueOf(data.getWeedout()));
			content6 = (TextView)findViewById(R.id.house_content6);
			content6.setText(String.valueOf(data.getTemperature()));
			content7 = (TextView)findViewById(R.id.house_content7);
			content7.setText(String.valueOf(data.getHumidity()));
			content8 = (TextView)findViewById(R.id.house_content8);
			content8.setText(String.valueOf(data.getSunning()));
			content9 = (TextView)findViewById(R.id.house_content9);
			content9.setText(data.getVacname());
			content10 = (TextView)findViewById(R.id.house_content10);
			content10.setText(data.getVetdrug());
			content11 = (TextView)findViewById(R.id.house_content11);
			content11.setText(data.getDisoutectdesc());
		}
	}

	private class ImageSetectListener implements OnClickListener {
		
		public void onClick(View v) {
			if (mPathNews != null && mPathNews.size() ==9) {
				ToastUtil.showToast(KeepDetailInfoActivity.this, "图片数量已达上限");
				return;
			}
		 	Intent intent = new Intent();
	        intent.setType("image/*");
	        intent.setAction(Intent.ACTION_GET_CONTENT); 
	        startActivityForResult(intent, 1);
		}
    	
    }

	protected void onActivityResult(int requestCode, int resultCode, Intent data) {
		String path = null;
		if (resultCode == RESULT_OK) {
			Uri uri = data.getData();
			mPathNews.add(uri.toString());
			mAddView.notifyDataSetChanged(mPathNews);
		}
		super.onActivityResult(requestCode, resultCode, data);
	}
	
	private OnDeleteListener mOnDeleteListener = new OnDeleteListener() {

		@Override
		public void delete(int pos) {
			mPathNews.remove(pos);
		}
	};
	@Override
	protected void requestFail(Message msg) {
		ToastUtil.showToast(KeepDetailInfoActivity.this, R.string.request_fail);
		pb.setVisibility(View.GONE);
		
	}
	@Override
	protected void requsestDefault(Message msg) {
		if (msg.what == SendRequestUtil.HTTP_SCHEDULE_REQUEST) {
			ScheduleResp resp = (ScheduleResp)msg.obj;
			dosome.setText(((StandarData)resp.getData()).getStandarddesc());
		}
	}

	@Override
	protected void requestSuccess(Message msg) {
		Intent intent = new Intent();
		Bundle bundle = new Bundle();
		bundle.putSerializable("data", data);
		intent.putExtras(bundle);
		if (isadd) {
			setResult(0, intent);
		} else {
			setResult(1, intent);
		}
		finish();
		
	}
	
	@Override
	public void onBackPressed() {
		
		super.onBackPressed();
	}

	public void upload(){
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
		data.setPic(file);
	}
	private OnClickListener mPublishListener = new OnClickListener() {
		public void onClick(View view) {
			pb.setVisibility(View.VISIBLE);
			
			
			
			if (stage == 0) {
				
//				if (!dosomething.getText().toString().equals("")){
					upload();
					data.setDaycontent(dosomething.getText().toString());
					SendRequestUtil.makeSaveFirstStageRequest(
							batchnum,dosomething.getText().toString(),data.getPic(),data.getDay());
//				} else {
//					ToastUtil.showToast(KeepDetailInfoActivity.this, "请输入要提交内容");
//				}
			} else if (stage == 1) {
				
				upload();
					SendRequestUtil.makeSaveSecondStageRequest(
							batchnum,data);
				
				
			} else if (stage == 2) {
				
//				if (!dosomething.getText().toString().equals("")){
					upload();
					data.setDaycontent(dosomething.getText().toString());
					
					SendRequestUtil.makeSaveThirdStageRequest(
							batchnum,data);
//				} else {
//					ToastUtil.showToast(KeepDetailInfoActivity.this, "请输入要提交内容");
//				}
				
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
							ToastUtil.showToast(KeepDetailInfoActivity.this, "图片上传失败");
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

	@Override
	public void onClick(View arg0) {
		switch(arg0.getId()){
			case R.id.btn_edit1:
				if (data.getVaccine() ==1) {
					data.setVaccine(0);
					btn1.setBackgroundResource(R.drawable.buttonstyle_gray);
				} else {
					data.setVaccine(1);
					btn1.setBackgroundResource(R.drawable.buttonstyle2);
				}
				break;
			case R.id.btn_edit2:
				if (data.getHealthcare() ==1) {
					data.setHealthcare(0);
					btn2.setBackgroundResource(R.drawable.buttonstyle_gray);
				} else {
					data.setHealthcare(1);
					btn2.setBackgroundResource(R.drawable.buttonstyle2);
				}
				break;
			case R.id.btn_edit3:
				if (data.getDisinfect() ==1) {
					data.setDisinfect(0);
					btn3.setBackgroundResource(R.drawable.buttonstyle_gray);
				} else {
					data.setDisinfect(1);
					btn3.setBackgroundResource(R.drawable.buttonstyle2);
				}
				break;
			case R.id.btn_edit4:
				if (data.getOutinsect() ==1) {
					data.setOutinsect(0);
					btn4.setBackgroundResource(R.drawable.buttonstyle_gray);
				} else {
					data.setOutinsect(1);
					btn4.setBackgroundResource(R.drawable.buttonstyle2);
				}
				break;
			case R.id.type1:
				final EditText inputServer1 = new EditText(this);
		        inputServer1.setFocusable(true);
		        inputServer1.setInputType(InputType.TYPE_CLASS_NUMBER); 
		        AlertDialog.Builder builder = new AlertDialog.Builder(this);
		        builder.setTitle(R.string.keepinfo_type1)
		        	.setView(inputServer1)
		        	.setNegativeButton(getString(R.string.cancel), null);
		        builder.setPositiveButton(getString(R.string.confirm),
		                new DialogInterface.OnClickListener() {
		                    public void onClick(DialogInterface dialog, int which) {
		                    	if (inputServer1.getText()!=null&&!inputServer1.getText().toString().equals("")) {
		                    		data.setEatfood(Float.valueOf(inputServer1.getText().toString()));
		                    		content1.setText(Float.valueOf(inputServer1.getText().toString()).toString());
		                    	}
		                    }

		                });
		        builder.show();
				break;
			case R.id.type2:
				final EditText inputServer2 = new EditText(this);
		        inputServer2.setFocusable(true);
		        inputServer2.setInputType(InputType.TYPE_CLASS_NUMBER); 
		        builder = new AlertDialog.Builder(this);
		        builder.setTitle(R.string.keepinfo_type2)
		        	.setView(inputServer2)
		        	.setNegativeButton(getString(R.string.cancel), null);
		        builder.setPositiveButton(getString(R.string.confirm),
		                new DialogInterface.OnClickListener() {
		                    public void onClick(DialogInterface dialog, int which) {
		                    	if (inputServer2.getText()!=null&&!inputServer2.getText().toString().equals("")) {
		                    		data.setEatwater(Float.valueOf(inputServer2.getText().toString()));
		                    		content2.setText(Float.valueOf(inputServer2.getText().toString()).toString());
		                    	}
		                    }

		                });
		        builder.show();
				break;
			case R.id.type3:
				final EditText inputServer3 = new EditText(this);
		        inputServer3.setFocusable(true);
		        inputServer3.setInputType(InputType.TYPE_CLASS_NUMBER); 
		        builder = new AlertDialog.Builder(this);
		        builder.setTitle(R.string.keepinfo_type3)
		        	.setView(inputServer3)
		        	.setNegativeButton(getString(R.string.cancel), null);
		        builder.setPositiveButton(getString(R.string.confirm),
		                new DialogInterface.OnClickListener() {
		                    public void onClick(DialogInterface dialog, int which) {
		                    	if (inputServer3.getText()!=null&&!inputServer3.getText().toString().equals("")) {
		                    		data.setEachweight(Float.valueOf(inputServer3.getText().toString()));
		                    		content3.setText(Float.valueOf(inputServer3.getText().toString()).toString());
		                    	}
		                    }

		                });
		        builder.show();
				break;
			case R.id.type4:
				final EditText inputServer4 = new EditText(this);
		        inputServer4.setFocusable(true);
		        inputServer4.setInputType(InputType.TYPE_CLASS_NUMBER); 
		        builder = new AlertDialog.Builder(this);
		        builder.setTitle(R.string.keepinfo_type4)
		        	.setView(inputServer4)
		        	.setNegativeButton(getString(R.string.cancel), null);
		        builder.setPositiveButton(getString(R.string.confirm),
		                new DialogInterface.OnClickListener() {
		                    public void onClick(DialogInterface dialog, int which) {
		                    	if (inputServer4.getText()!=null&&!inputServer4.getText().toString().equals("")) {
		                    		data.setDeadcount(Integer.valueOf(inputServer4.getText().toString()));
		                    		content4.setText(inputServer4.getText().toString());
		                    	}
		                    }

		                });
		        builder.show();
				break;
			case R.id.type5:
				final EditText inputServer5 = new EditText(this);
		        inputServer5.setFocusable(true);
		        inputServer5.setInputType(InputType.TYPE_CLASS_NUMBER); 
		        builder = new AlertDialog.Builder(this);
		        builder.setTitle(R.string.keepinfo_type5)
		        	.setView(inputServer5)
		        	.setNegativeButton(getString(R.string.cancel), null);
		        builder.setPositiveButton(getString(R.string.confirm),
		                new DialogInterface.OnClickListener() {
		                    public void onClick(DialogInterface dialog, int which) {
		                    	if (inputServer5.getText()!=null&&!inputServer5.getText().toString().equals("")) {
		                    		data.setWeedout(Integer.valueOf(inputServer5.getText().toString()));
		                    		content5.setText(inputServer5.getText().toString());
		                    	}
		                    }

		                });
		        builder.show();
				break;
			case R.id.type6:
				final EditText inputServer6 = new EditText(this);
		        inputServer6.setFocusable(true);
		        inputServer6.setInputType(InputType.TYPE_CLASS_NUMBER); 
		        builder = new AlertDialog.Builder(this);
		        builder.setTitle(R.string.keepinfo_type6)
		        	.setView(inputServer6)
		        	.setNegativeButton(getString(R.string.cancel), null);
		        builder.setPositiveButton(getString(R.string.confirm),
		                new DialogInterface.OnClickListener() {
		                    public void onClick(DialogInterface dialog, int which) {
		                    	if (inputServer6.getText()!=null&&!inputServer6.getText().toString().equals("")) {
		                    		data.setTemperature(Float.valueOf(inputServer6.getText().toString()));
		                    		content6.setText(Float.valueOf(inputServer6.getText().toString()).toString());
		                    	}
		                    }

		                });
		        builder.show();
				break;
			case R.id.type7:
				final EditText inputServer7 = new EditText(this);
		        inputServer7.setFocusable(true);
		        inputServer7.setInputType(InputType.TYPE_CLASS_NUMBER); 
		        builder = new AlertDialog.Builder(this);
		        builder.setTitle(R.string.keepinfo_type7)
		        	.setView(inputServer7)
		        	.setNegativeButton(getString(R.string.cancel), null);
		        builder.setPositiveButton(getString(R.string.confirm),
		                new DialogInterface.OnClickListener() {
		                    public void onClick(DialogInterface dialog, int which) {
		                    	if (inputServer7.getText()!=null&&!inputServer7.getText().toString().equals("")) {
		                    		data.setHumidity(Float.valueOf(inputServer7.getText().toString()));
		                    		content7.setText(Float.valueOf(inputServer7.getText().toString()).toString());
		                    	}
		                    }

		                });
		        builder.show();
				break;
			case R.id.type8:
				final EditText inputServer8 = new EditText(this);
		        inputServer8.setFocusable(true);
		        inputServer8.setInputType(InputType.TYPE_CLASS_NUMBER); 
		        builder = new AlertDialog.Builder(this);
		        builder.setTitle(R.string.keepinfo_type8)
		        	.setView(inputServer8)
		        	.setNegativeButton(getString(R.string.cancel), null);
		        builder.setPositiveButton(getString(R.string.confirm),
		                new DialogInterface.OnClickListener() {
		                    public void onClick(DialogInterface dialog, int which) {
		                    	if (inputServer8.getText()!=null&&!inputServer8.getText().toString().equals("")) {
		                    		data.setSunning(Integer.valueOf(inputServer8.getText().toString()));
		                    		content8.setText(inputServer8.getText().toString());
		                    	}
		                    }

		                });
		        builder.show();
				break;
			case R.id.type9:
				final EditText inputServer9 = new EditText(this);
		        inputServer9.setFocusable(true);
		        builder = new AlertDialog.Builder(this);
		        builder.setTitle(R.string.keepinfo_type9)
		        	.setView(inputServer9)
		        	.setNegativeButton(getString(R.string.cancel), null);
		        builder.setPositiveButton(getString(R.string.confirm),
		                new DialogInterface.OnClickListener() {
		                    public void onClick(DialogInterface dialog, int which) {
		                    	if (inputServer9.getText()!=null&&!inputServer9.getText().toString().equals("")) {
		                    		data.setVacname(inputServer9.getText().toString());
		                    		content9.setText(inputServer9.getText().toString());
		                    	}
		                    }

		                });
		        builder.show();
				break;
			case R.id.type10:
				final EditText inputServer10 = new EditText(this);
		        inputServer10.setFocusable(true);
		        builder = new AlertDialog.Builder(this);
		        builder.setTitle(R.string.keepinfo_type10)
		        	.setView(inputServer10)
		        	.setNegativeButton(getString(R.string.cancel), null);
		        builder.setPositiveButton(getString(R.string.confirm),
		                new DialogInterface.OnClickListener() {
		                    public void onClick(DialogInterface dialog, int which) {
		                    	if (inputServer10.getText()!=null&&!inputServer10.getText().toString().equals("")) {
		                    		data.setVetdrug(inputServer10.getText().toString());
		                    		content10.setText(inputServer10.getText().toString());
		                    	}
		                    }

		                });
		        builder.show();
				break;
			case R.id.type11:
				final EditText inputServer11 = new EditText(this);
		        inputServer11.setFocusable(true);
		        builder = new AlertDialog.Builder(this);
		        builder.setTitle(R.string.keepinfo_type11)
		        	.setView(inputServer11)
		        	.setNegativeButton(getString(R.string.cancel), null);
		        builder.setPositiveButton(getString(R.string.confirm),
		                new DialogInterface.OnClickListener() {
		                    public void onClick(DialogInterface dialog, int which) {
		                    	if (inputServer11.getText()!=null&&!inputServer11.getText().toString().equals("")) {
		                    		data.setDisoutectdesc(inputServer11.getText().toString());
		                    		content11.setText(inputServer11.getText().toString());
		                    	}
		                    }

		                });
		        builder.show();
				break;
				
			default:
				break;
		}
	}	
	
	
}
