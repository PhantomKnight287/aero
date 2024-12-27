package com.phantomknight287.planepal

import android.content.Context
import com.google.android.gms.tasks.Tasks
import com.google.android.gms.wearable.NodeClient
import com.google.android.gms.wearable.Wearable
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext

class WearOsDeviceManager(private val context: Context) {
    private val client: NodeClient by lazy {
        Wearable.getNodeClient(context)
    }

    /**
     * Get all connected Wear OS devices
     * @return List of NodeInfo containing device information
     */
    suspend fun getConnectedNodes(): List<NodeInfo> = withContext(Dispatchers.IO) {
        try {
            val nodes = Tasks.await(client.connectedNodes)
            return@withContext nodes.map { node ->
                NodeInfo(
                    id = node.id,
                    displayName = node.displayName,
                    isNearby = node.isNearby
                )
            }
        } catch (e: Exception) {
            e.printStackTrace()
            return@withContext emptyList()
        }
    }

    /**
     * Data class to hold node information
     */
    data class NodeInfo(
        val id: String,
        val displayName: String,
        val isNearby: Boolean
    )
}