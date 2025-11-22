package fyi.procrastinator.aero.services

import android.content.Context
import com.google.android.gms.wearable.MessageClient
import com.google.android.gms.wearable.Wearable
import kotlinx.coroutines.tasks.await

class MessageSenderService(private val context: Context) {
    private val messageClient: MessageClient by lazy { Wearable.getMessageClient(context) }

    suspend fun sendMessageToPhone(path:String, data: ByteArray){
        val connectedNodes = Wearable.getNodeClient(context).connectedNodes.await()
        for(node in connectedNodes){
            try{
                messageClient.sendMessage(node.id, path,data).await()
            }
            catch(e: Exception){
                println("Failed to send message to node ${node.id}: ${e.message}")
            }
        }
    }
}