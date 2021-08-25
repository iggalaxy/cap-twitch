package com.iggalaxy.plugins.twitch;

import android.content.Context;
import android.content.res.TypedArray;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Paint;
import android.graphics.drawable.Drawable;
import android.text.TextPaint;
import android.util.AttributeSet;
import android.view.View;
import android.view.ViewGroup;
import android.webkit.WebView;
import android.widget.Button;
import android.widget.FrameLayout;

import androidx.appcompat.app.AppCompatActivity;


public class TwitchView extends FrameLayout {
    private AppCompatActivity activity;

    private Button closeButton;
    private WebView twitchStreamWebView;

    private FrameLayout.LayoutParams layoutParams = new FrameLayout.LayoutParams(
        new ViewGroup.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT)
    );

    private Boolean isAttached = false;

    public TwitchView(Context context, AppCompatActivity activity) {
        super(context);

        this.activity = activity;

        initView();
    }

    private void initView() {
        inflate(getContext(), R.layout.twitch_layout, this);

        // Set up web view
        twitchStreamWebView = findViewById(R.id.twitchWebView);
        twitchStreamWebView.getSettings().setJavaScriptEnabled(true);
        twitchStreamWebView.getSettings().setMediaPlaybackRequiresUserGesture(false);

        // Set up close button
        closeButton = findViewById(R.id.closeButton);
        closeButton.setOnClickListener(l -> {
            this.detachView();
        });
    }

    public void attachView() {
        if (this.isAttached) return;

        activity.addContentView(this, layoutParams);
        this.isAttached = true;
    }

    public void detachView() {
        if (!this.isAttached) return;

        ((ViewGroup) this.getParent()).removeView(this);
        this.isAttached = false;
    }

    public void showStream(String username) {
        if (!this.isAttached) return;

        twitchStreamWebView.loadUrl("https://player.twitch.tv/?channel=" + username + "&parent=www.iggalaxy.com");
    }
}