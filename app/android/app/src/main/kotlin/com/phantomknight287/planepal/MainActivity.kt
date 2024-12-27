package com.phantomknight287.planepal

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.phantomknight287.planepal/aero"
    private lateinit var wearOsDeviceManager: WearOsDeviceManager
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        wearOsDeviceManager = WearOsDeviceManager(context)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL
        ).setMethodCallHandler { call, result ->
            when (call.method) {
                "getConnectedWearOsDevices" -> {
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

                else -> result.notImplemented()
            }
        }
    }
}
