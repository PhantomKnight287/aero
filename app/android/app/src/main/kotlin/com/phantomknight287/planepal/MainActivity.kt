package com.phantomknight287.planepal

import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.os.Bundle
import android.os.PersistableBundle
import android.util.Log
import com.google.android.gms.tasks.Tasks
import com.google.android.gms.wearable.Wearable
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext
import org.json.JSONObject

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.phantomknight287.planepal/planepal"
    private lateinit var wearOsDeviceManager: WearOsDeviceManager

    override fun onCreate(savedInstanceState: Bundle?, persistentState: PersistableBundle?) {
        super.onCreate(savedInstanceState, persistentState)
        Log.d("DeepLinkDebug", "onCreate called with intent: ${intent?.data}")
        handleIntent(intent)
        startService(Intent(this, ChangeAppIconService::class.java))
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        Log.d("DeepLinkDebug", "onNewIntent called with intent: ${intent.data}")
        handleIntent(intent)
    }

    private fun handleIntent(intent: Intent) {
        if (intent.data != null) {

            val uri = intent.data;
            Log.d("DeepLinkDebug", "URI: ${uri.toString()}")
            Log.d("DeepLinkDebug", "Path: ${uri?.path}")
            Log.d("DeepLinkDebug", "Query: ${uri?.query}")
            val channel = MethodChannel(flutterEngine!!.dartExecutor.binaryMessenger, CHANNEL)

            val route = "/loading${uri?.query?.let { "?$it" } ?: ""}"
            Log.d("DeepLinkDebug", "Sending route: $route")
            channel.invokeMethod("navigateToRoute", route)
        }
    }

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

                "loginInWearable" -> {
                    CoroutineScope(Dispatchers.Main).launch {
                        try {
                            sendMessageToWatch(
                                applicationContext,
                                "/login-token",
                                (call.arguments as String).toByteArray()
                            )
                        } catch (e: Exception) {
                            e.printStackTrace()
                            result.error("ERROR", e.message, null)
                        }
                    }
                }

                "registerFlight" -> {
                    CoroutineScope(Dispatchers.Main).launch {
                        val jsonString = JSONObject(call.arguments as Map<*, *>).toString()
                        val dataToSend = jsonString.toByteArray(Charsets.UTF_8)
                        try {
                            sendMessageToWatch(
                                applicationContext,
                                "/register-flight",
                                dataToSend,
                            )
                        } catch (e: Exception) {
                            e.printStackTrace()
                            result.error("ERROR", e.message, null)

                        }
                    }
                }
                "changeAppIcon"->{
                    try {
                        // Accept icon ID as argument, or read from SharedPreferences if not provided
                        val iconId = call.argument<String>("iconId")
                        ChangeAppIconService().changeAppIcon(applicationContext, iconId)
                        result.success(null)
                    } catch (e: Exception) {
                        e.printStackTrace()
                        result.error("ERROR", e.message, null)
                    }
                }
                else -> result.notImplemented()
            }
        }
    }

    suspend fun sendMessageToWatch(
        context: Context,
        path: String,
        data: ByteArray = ByteArray(0)
    ) {
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
