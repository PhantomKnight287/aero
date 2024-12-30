/* While this template provides a good starting point for using Wear Compose, you can always
 * take a look at https://github.com/android/wear-os-samples/tree/main/ComposeStarter to find the
 * most up to date changes to the libraries and their usages.
 */

package com.phantomknight287.planepal.presentation

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.core.splashscreen.SplashScreen.Companion.installSplashScreen
import com.google.android.gms.wearable.MessageClient
import com.google.android.gms.wearable.Wearable
import kotlinx.coroutines.tasks.await

class MainActivity : ComponentActivity() {
    private val messageClient: MessageClient by lazy { Wearable.getMessageClient(this) }

    override fun onCreate(savedInstanceState: Bundle?) {
        installSplashScreen()
        super.onCreate(savedInstanceState)
        setTheme(android.R.style.Theme_DeviceDefault)
        setContent {
            PlanePalApp()
        }
    }

    private suspend fun sendMessageToPhone(path: String, data: ByteArray) {
        val connectedNodes = Wearable.getNodeClient(this).connectedNodes.await()
        println("Connected nodes: $connectedNodes")
        for (node in connectedNodes) {
            try {
                messageClient.sendMessage(node.id, path, data).await()
                println("Message sent successfully to node: ${node.id}")
            } catch (e: Exception) {
                println("Failed to send message to node ${node.id}: ${e.message}")
            }
        }
    }
}

