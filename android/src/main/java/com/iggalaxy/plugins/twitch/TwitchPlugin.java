package com.iggalaxy.plugins.twitch;

import android.animation.Animator;
import android.animation.AnimatorListenerAdapter;
import android.content.Context;
import android.view.MotionEvent;
import android.view.View;
import android.view.ViewGroup;
import android.view.animation.Animation;
import android.webkit.WebView;
import android.widget.FrameLayout;
import com.getcapacitor.JSObject;
import com.getcapacitor.Plugin;
import com.getcapacitor.PluginCall;
import com.getcapacitor.PluginMethod;
import com.getcapacitor.annotation.CapacitorPlugin;

class WebViewTouchListener implements View.OnTouchListener {

    TwitchPlugin plugin;

    private float startY = -1;

    public WebViewTouchListener(TwitchPlugin plugin) {
        this.plugin = plugin;
    }

    @Override
    public boolean onTouch(View v, MotionEvent event) {
        int action = event.getAction();
        float pointerY = event.getY();

        switch (action) {
            case MotionEvent.ACTION_DOWN:
                // press down event
                if (startY == -1) {
                    // first event, set starting Y value
                    startY = pointerY;
                }
                break;
            case MotionEvent.ACTION_MOVE:
                // Drag event
                float diff = Math.max(pointerY - startY, 0);
                plugin.moveView(diff);
                break;
            case MotionEvent.ACTION_UP:
                // lift up event

                if ((pointerY - startY) > 300) {
                    // moved more than 300px threshold - close the modal now

                    // TODO: Check if over threshold and either close or bounce back to start position
                    if (plugin.getIsOpen()) {
                        plugin.closeView();
                    }
                } else {
                    plugin.setViewBackToDefaultPosition();
                }
                startY = -1; // reset back to -1 to work correctly on next event
                break;
        }

        return false;
    }
}

@CapacitorPlugin(name = "Twitch")
public class TwitchPlugin extends Plugin {

    private Twitch implementation = new Twitch();
    private WebView webView;
    private FrameLayout.LayoutParams layoutParams = new FrameLayout.LayoutParams(
        new ViewGroup.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT)
    );

    private Boolean isOpen = false;
    private float startYPos = 120;

    public WebViewTouchListener openTouchListener = new WebViewTouchListener(this);

    private Runnable createWebView = new Runnable() {
        public void run() {
            Context context = bridge.getWebView().getContext();
            webView = new WebView(context);
            webView.getSettings().setJavaScriptEnabled(true);
            webView.getSettings().setMediaPlaybackRequiresUserGesture(false);
            bridge.getWebView().setOnTouchListener(openTouchListener);

            synchronized (this) {
                this.notify();
            }
        }
    };

    public Boolean getIsOpen() {
        return isOpen;
    }

    private void slideIn() {
        if (this.webView == null) return;

        // prepare initial position for animation
        this.webView.setAlpha(0.0f);
        this.webView.setY(600f); // move 600px down the view

        // animate
        this.webView.animate().y(startYPos).alpha(1.0f);
    }

    private void slideOut(AnimatorListenerAdapter listener) {
        if (this.webView == null) return;

        // animate
        this.webView.animate().y(startYPos + 1000f).alpha(0.0f).setListener(listener);
    }

    @PluginMethod
    public void openStream(PluginCall call) throws InterruptedException {
        synchronized (createWebView) {
            if (this.webView == null) {
                getActivity().runOnUiThread(createWebView);
                createWebView.wait();
            } else {
                this.webView.setVisibility(View.VISIBLE);
            }

            String username = call.getString("username");

            getActivity()
                .runOnUiThread(
                    new Runnable() {
                        public void run() {
                            if (webView == null) return;

                            webView.loadUrl("https://player.twitch.tv/?channel=" + username + "&parent=www.iggalaxy.com");
                            layoutParams.setMargins(0, (int) startYPos, 0, 0);
                            getActivity().addContentView(webView, layoutParams);

                            isOpen = true;
                            slideIn();
                        }
                    }
                );
        }
    }

    public void moveView(float yDiff) {
        if (webView != null) {
            webView.setY(startYPos + yDiff);
        }
    }

    public void setViewBackToDefaultPosition() {
        if (webView != null) {
            // Seems to be issues with this being removed and causing NPEs
            webView.animate().y(startYPos);
        }
    }

    public void closeView() {
        // Mark the view as closed
        this.isOpen = false;
        slideOut(
            new AnimatorListenerAdapter() {
                @Override
                public void onAnimationEnd(Animator animation) {
                    super.onAnimationEnd(animation);
                    webView.setVisibility(View.GONE);
                    ((ViewGroup) webView.getParent()).removeView(webView);
                    webView.destroy();

                    webView = null;
                }
            }
        );
    }
}
