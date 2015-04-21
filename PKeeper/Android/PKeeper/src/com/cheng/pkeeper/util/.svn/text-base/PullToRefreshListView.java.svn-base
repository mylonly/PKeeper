package com.cheng.pkeeper.util;

import java.text.SimpleDateFormat;
import java.util.Date;

import com.cheng.pkeeper.AppConfig;
import com.cheng.pkeeper.R;

import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.Canvas;
import android.graphics.Color;
import android.util.AttributeSet;
import android.util.Log;
import android.view.Gravity;
import android.view.MotionEvent;
import android.view.View;
import android.view.ViewGroup;
import android.view.animation.LinearInterpolator;
import android.view.animation.RotateAnimation;
import android.widget.AbsListView;
import android.widget.AbsListView.OnScrollListener;
import android.widget.BaseAdapter;
import android.widget.FrameLayout;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.ListView;
import android.widget.ProgressBar;
import android.widget.TextView;

public class PullToRefreshListView extends ListView implements OnScrollListener {

	/** The tag. */
	private String TAG = "AbPullToRefreshListView";

	public LinearLayout.LayoutParams layoutParamsFF = null;

	/** The layout params fw. */
	public LinearLayout.LayoutParams layoutParamsFW = null;

	/** The layout params wf. */
	public LinearLayout.LayoutParams layoutParamsWF = null;

	/** The layout params ww. */
	public LinearLayout.LayoutParams layoutParamsWW = null;

	/** The Constant RELEASE_To_REFRESH. */
	private final static int RELEASE_To_REFRESH = 0;

	/** The Constant PULL_To_REFRESH. */
	private final static int PULL_To_REFRESH = 1;

	private final static int REFRESHING = 2;

	private final static int DONE = 3;

	/** The Constant LOADING. */
	private final static int LOADING = 4;

	/** The Constant RATIO. */
	private final static int RATIO = 3;

	private LinearLayout headerView;

	/** The tips textview. */
	private TextView tipsTextview;

	/** The last updated text view. */
	private TextView lastUpdatedTextView;

	/** The arrow image view. */
	private ImageView arrowImageView;

	/** The header progress bar. */
	private ProgressBar headerProgressBar;

	/** The arrow image. */
	private Bitmap arrowImage = null;

	private LinearLayout footerView;

	/** The footer textview. */
	private TextView footerTextview;

	/** The footer progress bar. */
	private ProgressBar footerProgressBar;

	private LinearLayout nodataView;

	private BaseAdapter mAdapter = null;

	private RotateAnimation animation;

	/** The reverse animation. */
	private RotateAnimation reverseAnimation;

	/** The is recored. */
	private boolean isRecored;

	/** The head content width. */
	private int headContentWidth;

	/** The head content height. */
	private int headContentHeight;

	/** The start y. */
	private int startY;

	/** The first item index. */
	private int firstItemIndex;

	/** The state. */
	private int state;

	/** The is back. */
	private boolean isBack;

	/** The is refreshable. */
	private boolean isRefreshable;

	// private int i = 1;

	/** The last refresh time. */
	private String lastRefreshTime = null;

	/**
	 * Instantiates a new ab pull to refresh list view.
	 * 
	 * @param context
	 *            the context
	 */
	public PullToRefreshListView(Context context) {
		super(context);
		init(context);
	}

	/**
	 * Instantiates a new ab pull to refresh list view.
	 * 
	 * @param context
	 *            the context
	 * @param attrs
	 *            the attrs
	 */
	public PullToRefreshListView(Context context, AttributeSet attrs) {
		super(context, attrs);
		init(context);
	}

	private void init(Context context) {
		setCacheColorHint(context.getResources().getColor(
				android.R.color.transparent));
		layoutParamsFF = new LinearLayout.LayoutParams(
				LayoutParams.MATCH_PARENT, LayoutParams.MATCH_PARENT);
		layoutParamsFW = new LinearLayout.LayoutParams(
				LayoutParams.MATCH_PARENT, LayoutParams.WRAP_CONTENT);
		layoutParamsWF = new LinearLayout.LayoutParams(
				LayoutParams.WRAP_CONTENT, LayoutParams.MATCH_PARENT);
		layoutParamsWW = new LinearLayout.LayoutParams(
				LayoutParams.WRAP_CONTENT, LayoutParams.WRAP_CONTENT);

		headerView = new LinearLayout(context);
		headerView.setOrientation(LinearLayout.HORIZONTAL);
		// headerView.setBackgroundColor(Color.rgb(225, 225, 225));
		headerView.setGravity(Gravity.CENTER);

		FrameLayout headImage = new FrameLayout(context);
		arrowImageView = new ImageView(context);
		arrowImageView.setImageResource(R.drawable.ic_pulltorefresh_arrow);
		arrowImageView.setMinimumWidth(50);
		arrowImageView.setMinimumHeight(50);
		arrowImageView.setPadding(10, 0, 10, 0);
		headerProgressBar = new ProgressBar(context);
		headerProgressBar.setIndeterminateDrawable(getResources().getDrawable(
				R.drawable.refresh_progress));
		headerProgressBar.setVisibility(View.GONE);
		headImage.addView(arrowImageView, layoutParamsWW);
		int width = 0;
//		if (AppConfig.isPad)
//			width = AppConfig.screenWidth / 20;
//		else
			width = AppConfig.screenWidth / 10;
		LinearLayout.LayoutParams p = new LinearLayout.LayoutParams(width,
				width);
		headImage.addView(headerProgressBar, p);

		LinearLayout headText = new LinearLayout(context);
		tipsTextview = new TextView(context);
		lastUpdatedTextView = new TextView(context);
		headText.setOrientation(LinearLayout.VERTICAL);
		headText.setGravity(Gravity.CENTER_VERTICAL);
		headText.setPadding(10, 0, 0, 0);
		headText.addView(tipsTextview, layoutParamsFW);
		headText.addView(lastUpdatedTextView, layoutParamsFW);
		tipsTextview.setGravity(Gravity.CENTER_HORIZONTAL);
		tipsTextview.setTextColor(0xffE96164);
		lastUpdatedTextView.setGravity(Gravity.CENTER_HORIZONTAL);
		lastUpdatedTextView.setTextColor(0xffE96164);
		tipsTextview.setTextSize(12);
		lastUpdatedTextView.setTextSize(10);
		headerView.addView(headImage, layoutParamsWW);
		// headerView.addView(headText, layoutParamsWW);

		measureView(headerView);
		headContentHeight = headerView.getMeasuredHeight();
		headContentWidth = headerView.getMeasuredWidth();
		headerView.setPadding(0, -1 * headContentHeight, 0, 0);
		headerView.invalidate();
		addHeaderView(headerView, null, false);

		footerView = new LinearLayout(context);
		footerView.setOrientation(LinearLayout.HORIZONTAL);
		footerView.setGravity(Gravity.CENTER);
		// footerView.setBackgroundColor(Color.rgb(225, 225, 225));

		footerTextview = new TextView(context);
		footerTextview.setGravity(Gravity.CENTER_VERTICAL);
		footerTextview.setTextColor(0xffE96164);
		footerTextview.setTextSize(15);
		footerTextview.setHeight(headContentHeight);
		footerProgressBar = new ProgressBar(context, null,
				android.R.attr.progressBarStyleSmall);
		footerProgressBar.setVisibility(View.GONE);
		footerView.addView(footerProgressBar, layoutParamsWW);
		footerView.addView(footerTextview, layoutParamsWW);
		footerTextview.setText("更多...");
		footerView.setVisibility(View.GONE);
		addFooterView(footerView, null, false);

		nodataView = new LinearLayout(context);
		nodataView.setOrientation(LinearLayout.HORIZONTAL);
		nodataView.setBackgroundColor(Color.rgb(225, 225, 225));
		nodataView.setGravity(Gravity.CENTER);

		setOnScrollListener(this);

		animation = new RotateAnimation(0, -180,
				RotateAnimation.RELATIVE_TO_SELF, 0.5f,
				RotateAnimation.RELATIVE_TO_SELF, 0.5f);
		animation.setInterpolator(new LinearInterpolator());
		animation.setDuration(250);
		animation.setFillAfter(true);

		reverseAnimation = new RotateAnimation(-180, 0,
				RotateAnimation.RELATIVE_TO_SELF, 0.5f,
				RotateAnimation.RELATIVE_TO_SELF, 0.5f);
		reverseAnimation.setInterpolator(new LinearInterpolator());
		reverseAnimation.setDuration(200);
		reverseAnimation.setFillAfter(true);

		state = DONE;
		isRefreshable = false;

	}

	public void setNoLoadMore() {
		this.removeFooterView(footerView);
	}

	public void onScroll(AbsListView arg0, int firstVisiableItem,
			int visibleItemCount, int totalItemCount) {
		firstItemIndex = firstVisiableItem;
	}

	public void onScrollStateChanged(AbsListView view, int scrollState) {
		switch (scrollState) {
		case OnScrollListener.SCROLL_STATE_IDLE:
			Log.i(TAG, "SCROLL_STATE_IDLE");
			if (view.getFirstVisiblePosition() == 0) {
			} else if (view.getLastVisiblePosition() == (view.getCount() - 1)) {
				if (mOnLoadMoreListener != null) {
					footerProgressBar.setVisibility(View.VISIBLE);
					footerView.setVisibility(View.VISIBLE);
					footerTextview.setText(" 加载中...");
					mOnLoadMoreListener.onLoadMore();
				}
			}
			break;
		case OnScrollListener.SCROLL_STATE_FLING:
			Log.i(TAG, "SCROLL_STATE_FLING");
			footerView.setVisibility(View.GONE);
			break;
		case OnScrollListener.SCROLL_STATE_TOUCH_SCROLL:
			break;
		}
	}

	public boolean onTouchEvent(MotionEvent event) {
		if (isRefreshable) {
			switch (event.getAction()) {
			case MotionEvent.ACTION_DOWN:
				if (firstItemIndex == 0 && !isRecored) {
					isRecored = true;
					startY = (int) event.getY();
				}
				break;
			case MotionEvent.ACTION_UP:
				if (state != REFRESHING && state != LOADING) {
					if (state == DONE) {
					}
					if (state == PULL_To_REFRESH) {
						state = DONE;
						changeHeaderViewByState();
					}
					if (state == RELEASE_To_REFRESH) {
						state = REFRESHING;
						changeHeaderViewByState();
						onRefresh();
					}
				}
				isRecored = false;
				isBack = false;
				break;
			case MotionEvent.ACTION_MOVE:
				int tempY = (int) event.getY();
				if (!isRecored && firstItemIndex == 0) {
					isRecored = true;
					startY = tempY;
				}
				if (state != REFRESHING && isRecored && state != LOADING) {
					if (state == RELEASE_To_REFRESH) {
						setSelection(0);
						if (((tempY - startY) / RATIO < headContentHeight)
								&& (tempY - startY) > 0) {
							state = PULL_To_REFRESH;
							changeHeaderViewByState();
						} else if (tempY - startY <= 0) {
							state = DONE;
							changeHeaderViewByState();
						}
					}
					if (state == PULL_To_REFRESH) {
						setSelection(0);
						if ((tempY - startY) / RATIO >= headContentHeight) {
							state = RELEASE_To_REFRESH;
							isBack = true;
							changeHeaderViewByState();
						} else if (tempY - startY <= 0) {
							state = DONE;
							changeHeaderViewByState();
						}
					}
					if (state == DONE) {
						if (tempY - startY > 0) {
							state = PULL_To_REFRESH;
							changeHeaderViewByState();
						}
					}
					if (state == PULL_To_REFRESH) {
						headerView.setPadding(0, -1 * headContentHeight
								+ (tempY - startY) / RATIO, 0, 10);
					}
					if (state == RELEASE_To_REFRESH) {
						headerView.setPadding(0, (tempY - startY) / RATIO
								- headContentHeight, 0, 10);
					}
				}
				break;
			}
		}
		return super.onTouchEvent(event);
	}

	/**
	 * Change header view by state.
	 */
	private void changeHeaderViewByState() {
		switch (state) {
		case RELEASE_To_REFRESH:
			arrowImageView.setVisibility(View.VISIBLE);
			headerProgressBar.setVisibility(View.GONE);
			tipsTextview.setVisibility(View.VISIBLE);
			lastUpdatedTextView.setVisibility(View.VISIBLE);
			arrowImageView.clearAnimation();
			arrowImageView.startAnimation(animation);
			tipsTextview.setText("松开刷新");
			break;
		case PULL_To_REFRESH:
			headerProgressBar.setVisibility(View.GONE);
			tipsTextview.setVisibility(View.VISIBLE);
			lastUpdatedTextView.setVisibility(View.VISIBLE);
			arrowImageView.clearAnimation();
			arrowImageView.setVisibility(View.VISIBLE);
			if (isBack) {
				isBack = false;
				arrowImageView.clearAnimation();
				arrowImageView.startAnimation(reverseAnimation);
				// tipsTextview.setText("isBack  is true ������");
			} else {
				// tipsTextview.setText("isBack  is false ������");
			}
			break;
		case REFRESHING:
			headerView.setPadding(0, 0, 0, 10);
			headerProgressBar.setVisibility(View.VISIBLE);
			arrowImageView.clearAnimation();
			arrowImageView.setVisibility(View.GONE);
			tipsTextview.setText("正在刷新");
			lastUpdatedTextView.setVisibility(View.VISIBLE);
			break;
		case DONE:
			headerView.setPadding(0, -1 * headContentHeight, 0, 0);
			headerProgressBar.setVisibility(View.GONE);
			arrowImageView.clearAnimation();
			arrowImageView.setImageResource(R.drawable.ic_pulltorefresh_arrow);
			tipsTextview.setText("刷新完成");
			lastUpdatedTextView.setVisibility(View.VISIBLE);
			break;
		}
	}

	/**
	 * The listener interface for receiving onRefresh events. The class that is
	 * interested in processing a onRefresh event implements this interface, and
	 * the object created with that class is registered with a component using
	 * the component's <code>addOnRefreshListener<code> method. When
	 * the onRefresh event occurs, that object's appropriate
	 * method is invoked.
	 * 
	 * @see OnRefreshEvent
	 */
	public interface OnRefreshListener {
		public void onRefresh();
	}

	public interface OnLoadMoreListener {
		public void onLoadMore();
	}

	private OnRefreshListener mOnRefreshListener;
	private OnLoadMoreListener mOnLoadMoreListener;

	public void setOnRefreshListener(OnRefreshListener onRefreshListener) {
		this.mOnRefreshListener = onRefreshListener;
		isRefreshable = true;
	}

	public void setOnLoadMoreListener(OnLoadMoreListener onLoadMoreListener) {
		this.mOnLoadMoreListener = onLoadMoreListener;
	}

	public void startResfresh(){
		state = REFRESHING;
		changeHeaderViewByState();
	}
	
	public void onRefreshComplete() {
		mAdapter.notifyDataSetChanged();
		state = DONE;
		lastRefreshTime = new SimpleDateFormat("yyyy-MM-dd   HH:mm:ss")
				.format(new Date(System.currentTimeMillis()));
		lastUpdatedTextView.setText("更新于：" + lastRefreshTime);

		changeHeaderViewByState();
		if (mAdapter.getCount() > 0) {
			footerView.setVisibility(View.GONE);
			footerProgressBar.setVisibility(View.GONE);
			footerTextview.setText("...");
		} else {
			footerView.setVisibility(View.VISIBLE);
			footerProgressBar.setVisibility(View.GONE);
			footerTextview.setText("没有数据!");
		}
	}

	public void onLoadMoreComplete(boolean have) {
		if (have) {
			mAdapter.notifyDataSetChanged();
			footerProgressBar.setVisibility(View.VISIBLE);
			footerView.setVisibility(View.GONE);
			footerTextview.setText("加载中...");
		} else {
			footerProgressBar.setVisibility(View.GONE);
			footerTextview.setText("全部加载完成");
		}
	}

	/**
	 * On refresh.
	 */
	private void onRefresh() {
		if (mOnRefreshListener != null) {
			mOnRefreshListener.onRefresh();
		}
	}

	/**
	 * Measure view.
	 * 
	 * @param child
	 *            the child
	 */
	private void measureView(View child) {
		ViewGroup.LayoutParams p = child.getLayoutParams();
		if (p == null) {
			p = new ViewGroup.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT,
					ViewGroup.LayoutParams.WRAP_CONTENT);
		}
		int childWidthSpec = ViewGroup.getChildMeasureSpec(0, 0 + 0, p.width);
		int lpHeight = p.height;
		int childHeightSpec;
		if (lpHeight > 0) {
			childHeightSpec = MeasureSpec.makeMeasureSpec(lpHeight,
					MeasureSpec.EXACTLY);
		} else {
			childHeightSpec = MeasureSpec.makeMeasureSpec(0,
					MeasureSpec.UNSPECIFIED);
		}
		child.measure(childWidthSpec, childHeightSpec);
	}

	public void setAdapter(BaseAdapter adapter) {
		lastRefreshTime = new SimpleDateFormat("yyyy-MM-dd   HH:mm:ss")
				.format(new Date(System.currentTimeMillis()));
		lastUpdatedTextView.setText("更新于：" + lastRefreshTime);

		mAdapter = adapter;
		super.setAdapter(mAdapter);
	}
	
	@Override
	protected void dispatchDraw(Canvas canvas) {
		try {
            super.dispatchDraw(canvas);
        } catch (IndexOutOfBoundsException e) {
            // error       	
        }
	}
}
