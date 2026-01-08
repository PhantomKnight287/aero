package fyi.procrastinator.aero

import android.content.Intent
import android.net.Uri
import android.util.Log
import com.google.android.gms.wearable.MessageEvent
import com.google.android.gms.wearable.WearableListenerService
import androidx.core.net.toUri
import java.nio.charset.StandardCharsets

class WearMessageReceiver : WearableListenerService() {
    override fun onMessageReceived(event: MessageEvent) {
        super.onMessageReceived(event)
        when (event.path) {
            "/open" -> {
                val intent = packageManager.getLaunchIntentForPackage(packageName)?.apply {
                    addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                    addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP)
                }
                startActivity(intent)
            }

            "/sign-in-request" -> {
                val intent = packageManager.getLaunchIntentForPackage(packageName)?.apply {
                    data =
                        "aero://?wearable_name=${String(event.data, Charsets.UTF_8)}".toUri()
                    addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                    addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP)
                }
                startActivity(intent)
            }
            "/data-request"->{
                val requestPayload = String(event.data, StandardCharsets.UTF_8)
                Log.d("PhoneListenerService", "Data request: $requestPayload from ${event.sourceNodeId}")
                val intent = packageManager.getLaunchIntentForPackage(packageName)?.apply {

                }
            }
        }
    }
}