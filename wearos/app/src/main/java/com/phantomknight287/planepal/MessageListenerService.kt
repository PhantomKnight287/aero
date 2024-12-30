package com.phantomknight287.planepal

import android.content.Intent
import com.google.android.gms.wearable.MessageEvent
import com.google.android.gms.wearable.WearableListenerService
import com.phantomknight287.planepal.presentation.MainActivity

class MessageListenerService : WearableListenerService() {
    override fun onMessageReceived(event: MessageEvent) {
        super.onMessageReceived(event)
        if (event.path == "/boot") {
            val intent = Intent(this, MainActivity::class.java).apply {
                addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
            }
            startActivity(intent)
        }
    }
}