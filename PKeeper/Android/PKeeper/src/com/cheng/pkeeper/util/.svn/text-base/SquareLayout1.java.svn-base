package com.cheng.pkeeper.util;

import android.content.Context;
import android.util.AttributeSet;
import android.util.Log;
import android.widget.RelativeLayout;

public class SquareLayout1 extends RelativeLayout {

	private boolean isSelect;
	
	public SquareLayout1(Context context, AttributeSet attrs, int defStyle) {
		super(context, attrs, defStyle);
	}

	public SquareLayout1(Context context, AttributeSet attrs) {
		super(context, attrs);
	}

	public SquareLayout1(Context context, boolean isSelect) {
		super(context);
	}

	protected void onMeasure(int widthMeasureSpec, int heightMeasureSpec) {
		Log.i("myself","onMeasure");
		setMeasuredDimension(getDefaultSize(0, widthMeasureSpec),
				getDefaultSize(0, heightMeasureSpec));

		int childWidthSize = getMeasuredWidth();
		int childHeightSize = getMeasuredHeight();
		// 高度和宽度一样
		widthMeasureSpec = MeasureSpec.makeMeasureSpec(
				childWidthSize, MeasureSpec.EXACTLY);
		if (!isSelect) {
			heightMeasureSpec = widthMeasureSpec-72;
		} else {
			heightMeasureSpec = widthMeasureSpec-24;
		}
		Log.i("myself","heightMeasureSpec"+heightMeasureSpec);
		super.onMeasure(widthMeasureSpec, heightMeasureSpec);
	}
	
	public void updateView(boolean isSelect) {
		this.isSelect = isSelect;
		Log.i("myself","invalidate");
		this.requestLayout();
		
	}
}
