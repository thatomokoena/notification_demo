package com.example.notification_demo;

import android.content.Intent;
import android.util.Log;
import android.os.Build;
import android.os.Bundle;

import com.huawei.hms.push.HmsMessageService;
import com.huawei.hms.push.RemoteMessage;

public class HuaweiPushKitService extends HmsMessageService{
    private static final String TAG = "HuaweiPushKitService";
    @Override
    public void onNewToken(String token) {
        super.onNewToken(token);
        Log.i(TAG, "HPK token:" + token);
    }

    @Override
    public void onMessageReceived(RemoteMessage remoteMessage) {
        super.onMessageReceived(remoteMessage);

        Log.d(TAG, "From: " + remoteMessage.getFrom());

        if (remoteMessage.getNotification() != null) {
            Log.d(TAG, "Message Notification Body: " + remoteMessage.getNotification().getBody());
        }
        else {
            Log.d(TAG, "Received message entity is null!");
        }

        if (remoteMessage.getData() != null) {
            Log.d(TAG, "Data: " + remoteMessage.getData()); //Whole data
        }
    }
}
