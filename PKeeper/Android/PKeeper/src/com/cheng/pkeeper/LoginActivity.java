package com.cheng.pkeeper;

import com.cheng.pkeeper.data.UserData;
import com.cheng.pkeeper.data.response.LoginResp;
import com.cheng.pkeeper.data.response.RegisterResp;
import com.cheng.pkeeper.http.SendRequestUtil;
import com.cheng.pkeeper.util.ToastUtil;

import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.content.SharedPreferences.Editor;
import android.os.Bundle;
import android.os.Message;
import android.text.Editable;
import android.text.InputType;
import android.text.TextWatcher;
import android.util.Log;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.ArrayAdapter;
import android.widget.AutoCompleteTextView;
import android.widget.CheckBox;
import android.widget.CompoundButton;
import android.widget.CompoundButton.OnCheckedChangeListener;
import android.widget.EditText;
import android.widget.Button;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.TextView;

public class LoginActivity extends AppBasicActivity {
	private static final String TAG = "LoginActivity";
	private EditText password;
	private AutoCompleteTextView userName;
	private EditText confirm;
	private Button btn_login, btn_register;
	// private ImageButton btnQuit;
	private String userNameValue, passwordValue, confirmValue;
	private LinearLayout pb;
	private RelativeLayout info_layout;
	private boolean isRegister = false;
	private TextView loadstatus;
	
	private CheckBox rem_pw, auto_login;
	private SharedPreferences sp,sp_password;
	
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.login);

		sp = this.getSharedPreferences("userInfo", Context.MODE_PRIVATE);
		sp_password = this.getSharedPreferences("passwordInfo", Context.MODE_PRIVATE);
		
		// 隐藏密码为InputType.TYPE_TEXT_VARIATION_PASSWORD，也就是0x81
		// 显示密码为InputType.TYPE_TEXT_VARIATION_VISIBLE_PASSWORD，也就是0x91
		rem_pw = (CheckBox) findViewById(R.id.cb_mima);
		auto_login = (CheckBox) findViewById(R.id.cb_auto);
		
		userName = (AutoCompleteTextView) findViewById(R.id.et_user);
		userName.setThreshold(1);// 输入1个字母就开始自动提示
		password = (EditText) findViewById(R.id.et_pwd);
		confirm = (EditText) findViewById(R.id.et_confirm);
		password.setInputType(InputType.TYPE_CLASS_TEXT
				| InputType.TYPE_TEXT_VARIATION_PASSWORD);
		confirm.setInputType(InputType.TYPE_CLASS_TEXT
				| InputType.TYPE_TEXT_VARIATION_PASSWORD);
		btn_login = (Button) findViewById(R.id.btn_login);
		btn_register = (Button) findViewById(R.id.btn_register);
		
		info_layout = (RelativeLayout)findViewById(R.id.info_layout);
		loadstatus = (TextView)findViewById(R.id.tv_login);
		pb = (LinearLayout)findViewById(R.id.progbar_loading);

		btn_login.setOnClickListener(new LoginListener());
		btn_register.setOnClickListener(new RegisterListener());

		tag_request =SendRequestUtil.TAG_LOGINREQUEST_REQUEST;
		SendRequestUtil.loginHandler = handler;

		userName.addTextChangedListener(new TextWatcher() {

			@Override
			public void onTextChanged(CharSequence s, int start, int before,
					int count) {
				String[] allUserName = new String[sp_password.getAll().size()];// sp.getAll().size()返回的是有多少个键值对
				allUserName = sp_password.getAll().keySet().toArray(new String[0]);
				ArrayAdapter<String> adapter = new ArrayAdapter<String>(
						LoginActivity.this,
						android.R.layout.simple_dropdown_item_1line,
						allUserName);
				userName.setAdapter(adapter);// 设置数据适配器

			}
			public void beforeTextChanged(CharSequence s, int start, int count,
					int after) {
			}
			public void afterTextChanged(Editable s) {
				password.setText(sp_password.getString(userName.getText()
						.toString(), ""));// 自动输入密码
			}
		});
		rem_pw.setOnCheckedChangeListener(new OnCheckedChangeListener() {
			public void onCheckedChanged(CompoundButton buttonView,
					boolean isChecked) {
				if (auto_login.isChecked()) {
					return;
				}
				if (rem_pw.isChecked()) {
					sp.edit().putBoolean("ISCHECK", true).commit();

				} else {
					sp.edit().putBoolean("ISCHECK", false).commit();

				}

			}
		});
		
		auto_login.setOnCheckedChangeListener(new OnCheckedChangeListener() {
			public void onCheckedChanged(CompoundButton buttonView,
					boolean isChecked) {
				if (auto_login.isChecked()) {
					sp.edit().putBoolean("AUTO_ISCHECK", true).commit();
					rem_pw.setChecked(true);
					sp.edit().putBoolean("ISCHECK", true).commit();
				} else {
					sp.edit().putBoolean("AUTO_ISCHECK", false).commit();
				}
			}
		});
		
		Intent intent = this.getIntent(); 
		boolean isRelogin = intent.getBooleanExtra("isRelogin", true);
		if (sp.getBoolean("ISCHECK", false)) {
			// 设置默认是记录密码状态
			rem_pw.setChecked(true);
			userName.setText(sp.getString("USER_NAME", ""));
			password.setText(sp.getString("PASSWORD", ""));
			// 判断自动登陆多选框状态
			if (sp.getBoolean("AUTO_ISCHECK", false) && isRelogin) {
				userNameValue = sp.getString("USER_NAME", "");
				passwordValue = sp.getString("PASSWORD", "");
				login();
			} else {
				auto_login.setChecked(sp.getBoolean("AUTO_ISCHECK", false));
			}
		}
	
	}
	
	private boolean infoCheck() {
		userNameValue = userName.getText().toString().trim();
		passwordValue = password.getText().toString().trim();
		confirmValue = confirm.getText().toString().trim();
		if (userNameValue != null && userNameValue.length() != 0) {
			if (passwordValue != null && passwordValue.length() != 0) {
				if (passwordValue.equals(confirmValue) || !isRegister) {
					return true;
				} else {
					ToastUtil.showToast(LoginActivity.this, R.string.pwd_dif);
				}
			} else {
				ToastUtil.showToast(LoginActivity.this, R.string.pwd_null);
			}
		} else {
			ToastUtil.showToast(LoginActivity.this, R.string.user_null);
		}
		return false;
	}
	
	private void register() {
		pb.setVisibility(View.VISIBLE);
		SendRequestUtil.makeRegisterRequest(userNameValue, passwordValue);
	}
	
	private void login() {
		pb.setVisibility(View.VISIBLE);
		SendRequestUtil.makeLoginRequest(userNameValue, passwordValue);
		
	}
	
	class RegisterListener implements OnClickListener {

		public void onClick(View v) {
			if (isRegister) {
				if (infoCheck()) {
					register();
				}
			} else {
				isRegister = true;
				loadstatus.setText(R.string.user_register);
				btn_register.setText(R.string.confirm);
				btn_login.setText(R.string.cancel);
				btn_login.setBackgroundResource(R.drawable.buttonstyle);
				btn_register.setBackgroundResource(R.drawable.buttonstyle1);
				btn_login.setTextColor(getResources().getColor(R.color.theme_color_green));
				btn_register.setTextColor(getResources().getColor(R.color.text_color_primary));
				confirm.setVisibility(View.VISIBLE);
				rem_pw.setVisibility(View.GONE);
				auto_login.setVisibility(View.GONE);
			}
		}
	}
	
	class LoginListener implements OnClickListener {

		public void onClick(View v) {
			if (isRegister) {
				isRegister = false;
				loadstatus.setText(R.string.user_login);
				btn_register.setText(R.string.register);
				btn_login.setText(R.string.login);
				btn_login.setBackgroundResource(R.drawable.buttonstyle1);
				btn_login.setTextColor(getResources().getColor(R.color.text_color_primary));
				btn_register.setTextColor(getResources().getColor(R.color.theme_color_green));
				btn_register.setBackgroundResource(R.drawable.buttonstyle);
				confirm.setVisibility(View.GONE);
				rem_pw.setVisibility(View.VISIBLE);
				auto_login.setVisibility(View.VISIBLE);
				Log.i(TAG,"2222222222222222");
			} else {
				if (infoCheck()) {
					
					if (rem_pw.isChecked()) {
						// 记住用户名、密码、
						Editor editor = sp_password.edit();
						editor.putString(userNameValue, passwordValue);
						editor.commit();
						editor = sp.edit();
						editor.putString("USER_NAME",userNameValue);
						editor.putString("PASSWORD",passwordValue);
						editor.commit();
					}
					login();
				}
			}
			
		}

		
	}
	
	protected void requestFail(Message msg) {
		ToastUtil.showToast(LoginActivity.this, R.string.request_fail);
		pb.setVisibility(View.GONE);
		info_layout.setVisibility(View.VISIBLE);
	}

	protected void requestSuccess(Message msg) {
		LoginResp loginResp = (LoginResp)msg.obj;
		if (loginResp.getResult()) {
			AppConfig.userid = loginResp.getUserdata().getUserId();
			if (loginResp.getCfactorydata()!= null){
				AppConfig.cfactoryid = loginResp.getCfactorydata().getCfactoryId();
				Log.i(TAG,"cfactoryid"+AppConfig.cfactoryid);
			}
			Intent intent = new Intent(this, GlobalBrowserActivity.class);
			Bundle bundle = new Bundle();
			bundle.putSerializable("user", loginResp.getUserdata());
			bundle.putSerializable("cfactory", loginResp.getCfactorydata());
			intent.putExtras(bundle);
			startActivity(intent);
			ToastUtil.showToast(LoginActivity.this, "登入成功");
			finish();
		} else {
			ToastUtil.showToast(LoginActivity.this, loginResp.getInfo());
			pb.setVisibility(View.GONE);
			info_layout.setVisibility(View.VISIBLE);
		}
	}
	protected void requsestDefault(Message msg) {
		RegisterResp registerResp = (RegisterResp)msg.obj;
		if (msg.what == SendRequestUtil.HTTP_REGISTER_REQUEST_FAIL) {
			ToastUtil.showToast(LoginActivity.this, R.string.request_fail);
			pb.setVisibility(View.GONE);
		} else if (msg.what == SendRequestUtil.HTTP_REGISTER_REQUEST
				&& registerResp.getResult()) {
			pb.setVisibility(View.GONE);
			isRegister = false;
			loadstatus.setText(R.string.user_login);
			btn_register.setText(R.string.register);
			btn_login.setText(R.string.login);
			btn_login.setBackgroundResource(R.drawable.buttonstyle1);
			btn_login.setTextColor(getResources().getColor(R.color.text_color_primary));
			btn_register.setTextColor(getResources().getColor(R.color.theme_color_green));
			btn_register.setBackgroundResource(R.drawable.buttonstyle);
			confirm.setVisibility(View.GONE);
			rem_pw.setVisibility(View.VISIBLE);
			auto_login.setVisibility(View.VISIBLE);
			
			ToastUtil.showToast(LoginActivity.this, registerResp.getInfo());
		}
	}
	
}
