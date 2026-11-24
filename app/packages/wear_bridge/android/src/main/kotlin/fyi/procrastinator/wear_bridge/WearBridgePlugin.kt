package fyi.procrastinator.wear_bridge

import android.content.Context
import com.google.android.gms.wearable.Wearable
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.SupervisorJob
import kotlinx.coroutines.cancel
import kotlinx.coroutines.launch
import kotlinx.coroutines.tasks.await
import kotlinx.coroutines.withContext

/** `send(path, json)` to every connected watch over the Wearable MessageClient. */
class WearBridgePlugin : FlutterPlugin, MethodChannel.MethodCallHandler {
    private lateinit var channel: MethodChannel
    private lateinit var context: Context
    private val scope = CoroutineScope(SupervisorJob() + Dispatchers.Main)

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        context = binding.applicationContext
        channel = MethodChannel(binding.binaryMessenger, "fyi.procrastinator.wear_bridge")
        channel.setMethodCallHandler(this)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
        scope.cancel()
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        if (call.method != "send") return result.notImplemented()
        val path = call.argument<String>("path")
        val json = call.argument<String>("json")
        if (path == null || json == null) return result.error("ARGS", "path and json required", null)
        scope.launch {
            try {
                val sent = withContext(Dispatchers.IO) {
                    val nodes = Wearable.getNodeClient(context).connectedNodes.await()
                    val bytes = json.toByteArray(Charsets.UTF_8)
                    nodes.forEach {
                        Wearable.getMessageClient(context).sendMessage(it.id, path, bytes).await()
                    }
                    nodes.size
                }
                result.success(sent)
            } catch (e: Exception) {
                result.error("SEND", e.message, null)
            }
        }
    }
}
