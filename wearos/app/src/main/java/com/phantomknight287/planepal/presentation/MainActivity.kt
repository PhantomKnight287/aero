package com.phantomknight287.planepal.presentation

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.core.splashscreen.SplashScreen.Companion.installSplashScreen
import androidx.lifecycle.lifecycleScope
import com.google.android.gms.wearable.MessageClient
import com.google.android.gms.wearable.Wearable
import com.phantomknight287.planepal.PlanePalDatabase
import kotlinx.coroutines.launch
import kotlinx.coroutines.tasks.await

class MainActivity : ComponentActivity() {
    private val messageClient: MessageClient by lazy { Wearable.getMessageClient(this) }

    override fun onCreate(savedInstanceState: Bundle?) {
        installSplashScreen()
        super.onCreate(savedInstanceState)
        setTheme(android.R.style.Theme_DeviceDefault)
        val database = PlanePalDatabase.getDatabase(applicationContext)
        setContent {
            PlanePalApp(
                database = database,
                sendMessageToPhone = { path, data ->
                    lifecycleScope.launch {
                        sendMessageToPhone(path, data)
                    }
                },
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

