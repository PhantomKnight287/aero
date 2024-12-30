package com.phantomknight287.planepal

import android.content.Context
import com.google.android.gms.tasks.Tasks
import com.google.android.gms.wearable.Wearable
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.phantomknight287.planepal/planepal"
    private lateinit var wearOsDeviceManager: WearOsDeviceManager
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        wearOsDeviceManager = WearOsDeviceManager(context)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL
        ).setMethodCallHandler { call, result ->
            when (call.method) {
                "getConnectedWearables" -> {
                    CoroutineScope(Dispatchers.Main).launch {
                        try {
                            val devices = wearOsDeviceManager.getConnectedNodes()
                            val deviceList = devices.map { device ->
                                mapOf(
                                    "id" to device.id,
                                    "displayName" to device.displayName,
                                    "isNearby" to device.isNearby,
                                )
                            }
                            result.success(deviceList)
                        } catch (e: Exception) {
                            result.error("ERROR", e.message, null)
                        }
                    }
                }

                "bootAppOnWatch" -> {
                    CoroutineScope(Dispatchers.Main).launch {
                        try {
                            sendMessageToWatch(applicationContext, "/boot")
                            result.success(null)
                        } catch (e: Exception) {
                            e.printStackTrace()

                            result.error("ERROR", e.message, null)
                        }

                    }
                }

                else -> result.notImplemented()
            }
        }
    }

    suspend fun sendMessageToWatch(context: Context, path: String, data: ByteArray = ByteArray(0)) {
        withContext(Dispatchers.IO) {
            try {
                val nodes = Tasks.await(Wearable.getNodeClient(context).connectedNodes)
                nodes.forEach { node ->
                    Tasks.await(
                        Wearable.getMessageClient(context).sendMessage(
                            node.id,
                            path,
                            data,
                        )
                    )
                }
            } catch (e: Exception) {
                e.printStackTrace()
            }
        }
    }
}
