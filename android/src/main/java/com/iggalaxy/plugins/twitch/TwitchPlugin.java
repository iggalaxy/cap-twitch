package com.iggalaxy.plugins.twitch;

import com.getcapacitor.Plugin;
import com.getcapacitor.PluginCall;
import com.getcapacitor.PluginMethod;
import com.getcapacitor.annotation.CapacitorPlugin;

@CapacitorPlugin(name = "Twitch")
public class TwitchPlugin extends Plugin {

    private Twitch implementation = new Twitch();
    private TwitchView twitchView;

    @PluginMethod
    public void openStream(PluginCall call) throws InterruptedException {
        getActivity().runOnUiThread(new Runnable() {
            public void run() {
                String username = call.getString("username");

                if (twitchView == null){
                    twitchView = new TwitchView(getContext(), getActivity());
                }

                twitchView.attachView();
                twitchView.showStream(username);
            }
        });
    }
}
