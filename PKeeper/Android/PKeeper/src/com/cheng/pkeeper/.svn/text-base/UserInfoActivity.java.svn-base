package com.cheng.pkeeper;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.cheng.pkeeper.adapt.UserAdapter;
import com.cheng.pkeeper.data.UserData;
import com.cheng.pkeeper.data.response.UserInfoResp;
import com.cheng.pkeeper.http.RequestAddress;
import com.cheng.pkeeper.http.SendRequestUtil;
import com.cheng.pkeeper.util.Constants;
import com.cheng.pkeeper.util.DBManager;
import com.cheng.pkeeper.util.FileUtils;
import com.cheng.pkeeper.util.ImageUtils;
import com.cheng.pkeeper.util.TitleView;
import com.cheng.pkeeper.util.ToastUtil;
import com.nostra13.universalimageloader.core.ImageLoader;
import com.upyun.block.api.listener.CompleteListener;
import com.upyun.block.api.listener.ProgressListener;
import com.upyun.block.api.main.UploaderManager;

import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.res.TypedArray;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.graphics.Bitmap;
import android.graphics.Bitmap.Config;
import android.graphics.Canvas;
import android.graphics.Paint;
import android.graphics.PorterDuff.Mode;
import android.graphics.PorterDuffXfermode;
import android.graphics.Rect;
import android.graphics.RectF;
import android.graphics.drawable.BitmapDrawable;
import android.graphics.drawable.Drawable;
import android.net.Uri;
import android.os.AsyncTask;
import android.os.Bundle;
import android.os.Environment;
import android.os.Message;
import android.provider.MediaStore;
import android.util.Log;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.AdapterView;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.Toast;
import android.widget.AdapterView.OnItemClickListener;

public class UserInfoActivity extends AppBasicActivity {

	private ImageView user_head;
	private ListView user_info;
	private TypedArray mTypedArray1;
	private TypedArray mTypedArray2;
	private UserData user;
	private List<String> userList;
	private UserAdapter listAdapter;
	private String[] items = new String[] { "选择本地图片", "拍照" };
    private static final String IMAGE_FILE_NAME = "faceImage.jpg";
    
    private String file;
    /* 请求码*/
    private static final int IMAGE_REQUEST_CODE = 0;
    private static final int CAMERA_REQUEST_CODE = 1;
    private static final int RESULT_REQUEST_CODE = 2;
    private String fileName;
 	// 保存到又拍云的路径
 	String savePath = "/android/head";
    
	public void onCreate(Bundle savedInstanceState) {

		super.onCreate(savedInstanceState);
		setContentView(R.layout.userinfo);
		
		TitleView mTitleView = (TitleView) findViewById(R.id.titleview);
		mTitleView.setTitle(R.string.userinfo);
		mTitleView.setBackButton(mBackListener);
		
		user_head = (ImageView) findViewById(R.id.iv_edit);
		user_head.setOnClickListener(new OnEditClickListener());
		
		user_info = (ListView)findViewById(R.id.list_userinfo);
		mTypedArray1 = getResources().obtainTypedArray(
				R.array.userinfo_library_drawable);
		mTypedArray2 = getResources().obtainTypedArray(
				R.array.userinfo_library_name);
		
		Intent intent = this.getIntent(); 
		user = (UserData)intent.getSerializableExtra("user");
		userList = new ArrayList<String>();
		userList = dataToList(user);
		listAdapter = new UserAdapter(this,userList,mTypedArray1,mTypedArray2);
		
		user_info.setAdapter(listAdapter);
		user_info.setOnItemClickListener(new OnItemClickListenerImpl());
	
		ImageLoader.getInstance().displayImage(
				user.getPicAddress(),user_head,
				ImageUtils.optionHead);
		
		tag_request =SendRequestUtil.TAG_USERINFO_REQUEST;
		SendRequestUtil.userinfoHandler = handler;
	}
	
	
	protected void onActivityResult(int requestCode, int resultCode, Intent data) {
		switch (requestCode) {
		case IMAGE_REQUEST_CODE:
			if (data != null) {
				startPhotoZoom(data.getData());
			}
			break;
		case CAMERA_REQUEST_CODE:
			if (FileUtils.hasSdcard()) {
				File tempFile = new File(
						Environment.getExternalStorageDirectory(),IMAGE_FILE_NAME);
				startPhotoZoom(Uri.fromFile(tempFile));
			} else {
				ToastUtil.showToast(this, "未找到存储卡，无法存储照片！");
			}

			break;
		case RESULT_REQUEST_CODE:
			if (data != null) {
				getImageToView(data);
			}
			break;
		}
		super.onActivityResult(requestCode, resultCode, data);
	}
	
	/**
     * 裁剪图片方法实现
     * 
     * @param uri
     */
    public void startPhotoZoom(Uri uri) {

            Intent intent = new Intent("com.android.camera.action.CROP");
            intent.setDataAndType(uri, "image/*");
            // 设置裁剪
            intent.putExtra("crop", "true");
            // aspectX aspectY 是宽高的比例
            intent.putExtra("aspectX", 1);
            intent.putExtra("aspectY", 1);
            // outputX outputY 是裁剪图片宽高
            intent.putExtra("outputX", user_head.getWidth());
            intent.putExtra("outputY", user_head.getHeight());
            intent.putExtra("return-data", true);
            startActivityForResult(intent, RESULT_REQUEST_CODE);
    }
    
    /**    
     * 保存裁剪之后的图片数据    
     *     
     * @param picdata    
     */    
    private void getImageToView(Intent data) {    
        Bundle extras = data.getExtras();    
        if (extras != null) {    
            Bitmap photo = extras.getParcelable("data");    
            savePic(photo);  
            photo = toRoundBitmap(photo);  
            Drawable drawable = new BitmapDrawable(this.getResources(),photo);    
            user_head.setImageDrawable(drawable);    
        }    
    } 
    
	private void savePic(Bitmap photo) {
		
		
		fileName = "HEAD.jpg";
		String tempImgPath = getCacheDir().getAbsolutePath()
				+ "/head/";
		File dirFile = new File(tempImgPath);
		dirFile.mkdirs();
		if (!dirFile.exists()) {
			ToastUtil.showToast(this, "无法创建SD卡目录,图片无法保存");
		}
		Log.i("myself",tempImgPath);///data/data/com.example.mytest/cache/mytest/
		Log.i("myself",Environment.getExternalStorageDirectory().toString());///storage/emulated/0
		file = tempImgPath+fileName;
		BufferedOutputStream bos = null;
		try {
			bos = new BufferedOutputStream(
					new FileOutputStream(tempImgPath+fileName));
			photo.compress(Bitmap.CompressFormat.JPEG, 100, bos);// (0 - 100)压缩文件
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				//关闭流
				bos.flush();
				bos.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		new UploadTask().execute();
		
	}
	
	public class UploadTask extends AsyncTask<Void, Void, String> {
		@Override
		protected String doInBackground(Void... params) {
			File localFile = new File(file);
			String string = null;
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
							SendRequestUtil.makeUserInfoRequest(user.getUserId(),userList,
									RequestAddress.getUpyunDownloadUrl()+savePath+"/"+fileName);
						} else {
							ToastUtil.showToast(UserInfoActivity.this, "图片上传失败");
						}
						
					}
				};
				
				UploaderManager uploaderManager = UploaderManager.getInstance(Constants.bucket);
				uploaderManager.setConnectTimeout(60);
				uploaderManager.setResponseTimeout(60);
				Map<String, Object> paramsMap = uploaderManager.fetchFileInfoDictionaryWith(localFile, savePath+"/"+fileName);
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
			return string;
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

    /**
    * 转换图片成圆形
    * @param bitmap 传入Bitmap对象
    * @return
    */
    public Bitmap toRoundBitmap(Bitmap bitmap) {
        int width = bitmap.getWidth();
        int height = bitmap.getHeight();
        float roundPx;
        float left, top, right, bottom, dst_left, dst_top, dst_right, dst_bottom;
        if (width <= height) {
            roundPx = width / 2;
            top = 0;
            bottom = width;
            left = 0;
            right = width;
            height = width;
            dst_left = 0;
            dst_top = 0;
            dst_right = width;
            dst_bottom = width;
        } else {
            roundPx = height / 2;
            float clip = (width - height) / 2;
            left = clip;
            right = width - clip;
            top = 0;
            bottom = height;
            width = height;
            dst_left = 0;
            dst_top = 0;
            dst_right = height;
            dst_bottom = height;
        }
        Bitmap output = Bitmap.createBitmap(width,
                                            height, Config.ARGB_8888);
        Canvas canvas = new Canvas(output);
        final int color = 0xff424242;
        final Paint paint = new Paint();
        final Rect src = new Rect((int)left, (int)top, (int)right, (int)bottom);
        final Rect dst = new Rect((int)dst_left, (int)dst_top, (int)dst_right, (int)dst_bottom);
        final RectF rectF = new RectF(dst);
        paint.setAntiAlias(true);
        canvas.drawARGB(0, 0, 0, 0);
        paint.setColor(color);
        canvas.drawRoundRect(rectF, roundPx, roundPx, paint);
        paint.setXfermode(new PorterDuffXfermode(Mode.SRC_IN));
        canvas.drawBitmap(bitmap, src, dst, paint);
        return output;
    }
    
	
	private class OnItemClickListenerImpl implements OnItemClickListener {

		public void onItemClick(AdapterView<?> parent, View view, int position,
				long id) {
			final int ss = position;
			if (position == 6) {
				List<String> list1 = new ArrayList<String>();
				list1 = initSpinner1(list1);
				
				final CharSequence[] items1 = list1.toArray(new CharSequence[list1.size()]);;
				new AlertDialog.Builder(UserInfoActivity.this)
				.setTitle("选择省"+"?")
				.setItems(items1,
						new DialogInterface.OnClickListener() {
							@Override
							public void onClick(DialogInterface dialog,
									int which) {
								final String province = items1[which].toString();
								if (which == 0 ||which == 1||which == 8||which == 31||which == 32) {
									
									if (!province.equals(userList.get(ss))) {
										userList.set(ss, items1[which].toString());
				                    	listAdapter.updateView(userList);
				                    	SendRequestUtil.makeUserInfoRequest(user.getUserId(),userList,user.getPicAddress());
			                    	}
									return;
								}
								Log.i(TAG,province);
								List<String> list2 = new ArrayList<String>();
								list2 = initSpinner2(listcode.get(which),list2);
								final CharSequence[] items2 = list2.toArray(new CharSequence[list2.size()]);;
								new AlertDialog.Builder(UserInfoActivity.this)
								.setTitle("选择市"+"?")
								.setItems(items2,
										new DialogInterface.OnClickListener() {
											@Override
											public void onClick(DialogInterface dialog,
													int which) {
												if (!(province+items2[which].toString()).equals(userList.get(ss))) {
													userList.set(ss, province+" "+items2[which].toString());
							                    	listAdapter.updateView(userList);
							                    	SendRequestUtil.makeUserInfoRequest(user.getUserId(),userList,user.getPicAddress());
						                    	}
											}
										}).show();
							}
						}).show();
			} else {
				final EditText inputServer = new EditText(UserInfoActivity.this);
		        inputServer.setFocusable(true);
		        inputServer.setText(userList.get(position).toString());
		        AlertDialog.Builder builder = new AlertDialog.Builder(UserInfoActivity.this);
		        builder.setTitle("更改"+mTypedArray2.getString(position)+"?")
		        	.setView(inputServer)
		        	.setNegativeButton(getString(R.string.cancel), null);
		        builder.setPositiveButton(getString(R.string.confirm),
		                new DialogInterface.OnClickListener() {
		                    public void onClick(DialogInterface dialog, int which) {
		                    	if (!inputServer.getText().toString().equals(userList.get(ss))) {
		                    		userList.set(ss, inputServer.getText().toString());
			                    	listAdapter.updateView(userList);
			                    	SendRequestUtil.makeUserInfoRequest(user.getUserId(),userList,user.getPicAddress());
		                    	}
		                    }
	
		                });
		        builder.show();
			}
		}
	}
	private DBManager dbm;
	private SQLiteDatabase db;
	List<String> listcode= new ArrayList<String>();
	public List<String> initSpinner1(List<String> list1){
		dbm = new DBManager(this);
	 	dbm.openDatabase();
	 	db = dbm.getDatabase();
		
	 	try {    
	        String sql = "select * from province";  
	        Cursor cursor = db.rawQuery(sql,null);  
	        cursor.moveToFirst();
	        while (!cursor.isLast()){
	        	String code=cursor.getString(cursor.getColumnIndex("code"));
		        byte bytes[]=cursor.getBlob(2); 
		        String name=new String(bytes,"gbk");
		        list1.add(name);
				listcode.add(code);
		        cursor.moveToNext();
	        }
	    } catch (Exception e) {  
	    } 
	 	dbm.closeDatabase();
	 	db.close();	
	 	return list1;
	}
	public List<String> initSpinner2(String code,List<String> list2){
		dbm = new DBManager(this);
	 	dbm.openDatabase();
	 	db = dbm.getDatabase();
	 	Log.i(TAG,"initSpinner2");
	 	try {
	 		String sql = "select * from city where pcode='"+code+"'";  
	 		Cursor cursor = db.rawQuery(sql,null);  
	        cursor.moveToFirst();
	        while (!cursor.isLast()){ 
		        byte bytes[]=cursor.getBlob(2); 
		        String name=new String(bytes,"gbk");
		        list2.add(name);
		        cursor.moveToNext();
	        }
	        
	    } catch (Exception e) {
	    	Log.i(TAG,"error");
	    } 
	 	dbm.closeDatabase();
	 	db.close();	
	 	return list2;
	}
	private class OnEditClickListener implements OnClickListener {

		public void onClick(View arg0) {

			new AlertDialog.Builder(UserInfoActivity.this)
					.setTitle("设置头像")
					.setItems(items, new DialogInterface.OnClickListener() {
						public void onClick(DialogInterface dialog, int which) {
							switch (which) {
							case 0:
								Intent intentFromGallery = new Intent();
								intentFromGallery.setType("image/*"); // 设置文件类型
								intentFromGallery
										.setAction(Intent.ACTION_GET_CONTENT);
								startActivityForResult(intentFromGallery,
										IMAGE_REQUEST_CODE);
								break;
							case 1:
								Intent intentFromCapture = new Intent(
										MediaStore.ACTION_IMAGE_CAPTURE);
								// 判断存储卡是否可以用，可用进行存储
								if (FileUtils.hasSdcard()) {

									intentFromCapture.putExtra(
											MediaStore.EXTRA_OUTPUT,
											Uri.fromFile(new File(
													Environment
															.getExternalStorageDirectory(),
													IMAGE_FILE_NAME)));
								}

								startActivityForResult(intentFromCapture,
										CAMERA_REQUEST_CODE);
								break;
							}
						}
					})
					.setNegativeButton("取消",
							new DialogInterface.OnClickListener() {

								@Override
								public void onClick(DialogInterface dialog,
										int which) {
									dialog.dismiss();
								}
							}).show();
		}
	}

	

	private OnClickListener mBackListener = new OnClickListener() {
		public void onClick(View view) {
			onBackPressed();
		}
	};

	private List<String> dataToList(UserData user) {
		if (user == null) {
			userList.add("");
			userList.add("");
			userList.add("");
			userList.add("");
			userList.add("");
			userList.add("");
			userList.add("");
			userList.add("");
			userList.add("0");
		} else {
			userList.add(user.getRealName());
			userList.add(user.getGender());
			userList.add(String.valueOf(user.getAge()));
			userList.add(user.getMobile());
			userList.add(user.getQq());
			userList.add(user.getEmail());
			if (user.getCity().equals("")) {
				userList.add(user.getProvince());
			} else {
				userList.add(user.getProvince()+" "+user.getCity());
			}
			userList.add(user.getAddress());
			userList.add(String.valueOf(user.getWorkyear()));
		}
		return userList;
		
	}
	
	@Override
	protected void requestFail(Message msg) {
		userList.clear();
		userList = dataToList(user);
		listAdapter.updateView(userList);
		ToastUtil.showToast(this, R.string.request_fail);
	}

	@Override
	protected void requestSuccess(Message msg) {
		UserInfoResp userinfo = (UserInfoResp)msg.obj;
		if (userinfo.getResult()) {
			Intent intent = new Intent();
			Bundle bundle = new Bundle();
			bundle.putSerializable("userinfo", userinfo.getData());
			intent.putExtras(bundle);
			setResult(1, intent); 
		} else {
			userList.clear();
			userList = dataToList(user);
			listAdapter.updateView(userList);
			ToastUtil.showToast(this, userinfo.getInfo());
			
		}
	}
}
