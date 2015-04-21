package com.cheng.pkeeper;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.view.animation.AlphaAnimation;
import android.view.animation.Animation;
import android.view.animation.Animation.AnimationListener;
import android.widget.ImageView;

public class SplashActivity extends Activity{
	private ImageView load;
	protected void onCreate(Bundle savedInstanceState) { 
	    super.onCreate(savedInstanceState);   
	    setContentView(R.layout.splash);   

	    load = (ImageView) findViewById(R.id.load);    
	    
	    load.setVisibility(View.VISIBLE); 
	        
	    
	    AlphaAnimation alphaAnimation = new AlphaAnimation((float) 0.1, 1);    
	    alphaAnimation.setDuration(2000);//设定动画时间    
	    alphaAnimation.setAnimationListener(new AnimationListener() {    
	    	@Override   
	    	public void onAnimationStart(Animation animation) {    
	    	}    
	   	   
	    	 @Override   
	    	public void onAnimationRepeat(Animation animation) {    
	    	}    
	   	
	    	@Override   
	    	public void onAnimationEnd(Animation animation) {    
	    		load.setVisibility(View.GONE); 
	    		Intent intent = new Intent(SplashActivity.this, LoginActivity.class);
				startActivity(intent);
				finish();
	    		}    
	    	});    
	    
	    load.setAnimation(alphaAnimation);
	 
	}

}
