/* While this template provides a good starting point for using Wear Compose, you can always
 * take a look at https://github.com/android/wear-os-samples/tree/main/ComposeStarter to find the
 * most up to date changes to the libraries and their usages.
 */

package com.phantomknight287.planepal.presentation

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.core.splashscreen.SplashScreen.Companion.installSplashScreen
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.runtime.Composable
import androidx.compose.runtime.rememberCoroutineScope
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.lifecycle.lifecycleScope
import androidx.wear.compose.material.Button
import androidx.wear.compose.material.MaterialTheme
import androidx.wear.compose.material.Text
import com.google.android.gms.wearable.MessageClient
import com.google.android.gms.wearable.Wearable
import com.phantomknight287.planepal.presentation.theme.PlanePalTheme
import kotlinx.coroutines.launch
import kotlinx.coroutines.tasks.await

class MainActivity : ComponentActivity() {
    private val messageClient: MessageClient by lazy { Wearable.getMessageClient(this) }

    override fun onCreate(savedInstanceState: Bundle?) {
        installSplashScreen()

        super.onCreate(savedInstanceState)

        setTheme(android.R.style.Theme_DeviceDefault)

        setContent {
            WearApp(
                "Android",
                onClick = {
                    lifecycleScope.launch {
                        sendMessageToPhone(
                            "/open",
                            ByteArray(0)
                        )
                    }
                }
            )
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

@Composable
fun WearApp(greetingName: String, onClick: () -> Unit) {
    val scope = rememberCoroutineScope()
    PlanePalTheme {
        Box(
            modifier = Modifier
                .fillMaxSize()
                .background(MaterialTheme.colors.background),
            contentAlignment = Alignment.Center
        ) {
            Button(
                onClick,
                modifier = Modifier.fillMaxSize()
            ) {
                Text("Open in Phone")
            }
        }
    }
}
