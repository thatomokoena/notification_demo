package com.example.notification_demo;

import android.app.IntentService;
import android.content.Intent;
import android.content.SharedPreferences;
import android.preference.PreferenceManager;
import android.util.Log;
import com.google.android.gms.tasks.OnSuccessListener;
import com.google.firebase.iid.FirebaseInstanceId;
import com.google.firebase.iid.InstanceIdResult;
//import com.microsoft.windowsazure.messaging.NotificationHub;
import com.windowsazure.messaging.*;

import java.util.concurrent.TimeUnit;

public class RegistrationIntentService extends IntentService {

    private static final String TAG = "RegIntentService";
    String FCM_token = null;

    private NotificationHub hub;

    public RegistrationIntentService() {
        super(TAG);
    }

    @Override
    protected void onHandleIntent(Intent intent) {
        Notification nn = new Notification();
        SharedPreferences sharedPreferences = PreferenceManager.getDefaultSharedPreferences(this);
        String resultString = null;
        Installation installation = null;

        try {
            FirebaseInstanceId.getInstance().getInstanceId().addOnSuccessListener(new OnSuccessListener<InstanceIdResult>() {
                @Override
                public void onSuccess(InstanceIdResult instanceIdResult) {
                    FCM_token = instanceIdResult.getToken();
                    Log.d(TAG, "FCM Registration Token: " + FCM_token);
                }
            });
            TimeUnit.SECONDS.sleep(1);

            /*Log.d(TAG, "Before Installation");
            if(intent.hasExtra("userId") && intent.hasExtra("devicePlatform"))
            {
                String userId = intent.getStringExtra("userId");
                String devicePlatform = intent.getStringExtra("devicePlatform");

                NotificationHub hub_ = new NotificationHub(NotificationSettings.HubListenConnectionString, NotificationSettings.HubName);

                installation = new Installation("12234", NotificationPlatform.Gcm, FCM_token);
                installation.setUserId(userId);
                hub_.createOrUpdateInstallation(installation);
            }
            else
            {
                Log.d(TAG, "UserId parameter was not set");
            }

            Log.d(TAG, "After Installation");*/

        } catch (Exception e) {
            Log.e(TAG, resultString="Failed to complete registration", e);
            // If an exception happens while fetching the new token or updating registration data
            // on a third-party server, this ensures that we'll attempt the update at a later time.
        }
    }
}
