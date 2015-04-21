package com.cheng.pkeeper.util;

import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.Bitmap.Config;
import android.graphics.Canvas;
import android.graphics.Paint;
import android.graphics.PorterDuff.Mode;
import android.graphics.PorterDuffXfermode;
import android.graphics.Rect;
import android.graphics.drawable.BitmapDrawable;
import android.graphics.drawable.Drawable;
import android.util.AttributeSet;
import android.widget.ImageView;

public class CircleImage extends ImageView {
	public CircleImage(Context context) {
		super(context);
	}

	public CircleImage(Context context, AttributeSet attrs) {
		super(context, attrs);
	}

	public CircleImage(Context context, AttributeSet attrs, int defStyle) {
		super(context, attrs, defStyle);
	}

	@Override
	protected void onDraw(Canvas canvas) {
		Drawable drawable = getDrawable();
		if (drawable == null) {
			return;
		}
		if (getWidth() == 0 || getHeight() == 0) {
			return;
		}
		Bitmap b = ((BitmapDrawable) drawable).getBitmap();
		Bitmap bitmap = b.copy(Bitmap.Config.ARGB_8888, true);
		Bitmap roundBitmap = getCroppedBitmap(bitmap);
		canvas.drawBitmap(roundBitmap, 0, 0, null);
	}

	/**
	 * 对Bitmap裁剪，使其变成圆形
	 * 
	 * @param bitmap
	 *            位图
	 * @return Bitmap
	 */
	public Bitmap getCroppedBitmap(Bitmap bitmap) {
		int bwidth = bitmap.getWidth();
		int bheight = bitmap.getHeight();
		int width = getWidth();
		int height = getHeight();
		float roundPx, left, top, right, bottom, dst_left, dst_top, dst_right, dst_bottom;
		if (width <= height) {
			roundPx = width / 2;
			left = 0;
			top = 0;
			right = bwidth;
			bottom = bheight;
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

		Bitmap output = Bitmap.createBitmap(width, height, Config.ARGB_8888);
		Canvas canvas = new Canvas(output);
		final Paint paint = new Paint();
		final Rect src = new Rect((int) left, (int) top, (int) right,
				(int) bottom);
		final Rect dst = new Rect((int) dst_left, (int) dst_top,
				(int) dst_right, (int) dst_bottom);
		// final RectF rectF = new RectF(dst);
		// 设置画笔无锯齿
		paint.setAntiAlias(true);
		// 填充整个Canvas
		canvas.drawARGB(0, 0, 0, 0);
		// 以下有两种方法画圆,drawRounRect和drawCircle
		// 画圆角矩形，第一个参数为图形显示区域，第二个参数和第三个参数分别是水平圆角半径和垂直圆角半径。
		// canvas.drawRoundRect(rectF, roundPx, roundPx, paint);
		canvas.drawCircle(roundPx, roundPx, roundPx, paint);
		// 设置两张图片相交时的模式,参考http://trylovecatch.iteye.com/blog/1189452
		paint.setXfermode(new PorterDuffXfermode(Mode.SRC_IN));
		// 以Mode.SRC_IN模式合并bitmap和已经draw了的Circle
		canvas.drawBitmap(bitmap, src, dst, paint);
		return output;
	}

}