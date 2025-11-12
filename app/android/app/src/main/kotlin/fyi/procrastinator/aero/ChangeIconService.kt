package fyi.procrastinator.aero

import android.app.Service
import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.os.IBinder
import android.util.Log
import io.flutter.BuildConfig

// Source - https://stackoverflow.com/a
// Posted by Dmitry Kopytov, modified by community. See post 'Timeline' for change history
// Retrieved 2025-11-09, License - CC BY-SA 4.0

class ChangeAppIconService : Service() {
    // Alias names without the dot prefix (as stored in SharedPreferences)
    private val aliases = arrayOf("DEFAULT",
        "ZERO_TWO",
        "ZERO_THREE",
        "ZERO_FOUR",
        "ZERO_FIVE",
        "ZERO_SIX",
        "ONE_ONE",
        "ONE_TWO",
        "ONE_THREE",
        "ONE_FOUR",
        "ONE_FIVE",
        "ONE_SIX")

    override fun onBind(intent: Intent?): IBinder? = null

    override fun onTaskRemoved(rootIntent: Intent?) {
        changeAppIcon(applicationContext)
        stopSelf()
    }

    fun changeAppIcon(context: Context, iconId: String? = null) {
        val aliasName = if (iconId != null) {
            iconId
        } else {
            // Try to read from Flutter SharedPreferences
            // Flutter stores SharedPreferences with "FlutterSharedPreferences" file name
            // and keys are prefixed with "flutter."
            val sp = context.getSharedPreferences("FlutterSharedPreferences", MODE_PRIVATE)
            sp.getString("flutter.selected_app_icon", "DEFAULT") ?: "DEFAULT"
        }

        // Only apply icon change if explicitly requested (iconId != null)
        // or if we're in release build (auto-apply on startup)
        // In debug builds, don't auto-apply on startup to avoid interfering with debugger
        val isDebugBuild = BuildConfig.DEBUG
        if (iconId != null || !isDebugBuild) {
            if (!isAliasEnabled(context, aliasName)) {
                setAliasEnabled(context, aliasName)
            }
        } else {
            // Debug build: Just ensure DEFAULT is enabled for debugger compatibility
            // Don't change to stored preference automatically
            ensureDefaultEnabledForDebugger(context)
        }
    }
    
    /**
     * In debug builds, ensure DEFAULT alias is always enabled for debugger compatibility
     */
    private fun ensureDefaultEnabledForDebugger(context: Context) {
        try {
            val defaultComponent = getComponentName(context, "DEFAULT")
            val state = context.packageManager.getComponentEnabledSetting(defaultComponent)
            if (state != PackageManager.COMPONENT_ENABLED_STATE_ENABLED) {
                context.packageManager.setComponentEnabledSetting(
                    defaultComponent,
                    PackageManager.COMPONENT_ENABLED_STATE_ENABLED,
                    PackageManager.DONT_KILL_APP
                )
                Log.d(TAG, "Ensured DEFAULT alias is enabled for debugger")
            }
        } catch (e: Exception) {
            Log.e(TAG, "Error ensuring DEFAULT alias is enabled", e)
        }
    }

    companion object {
        private const val TAG = "ChangeAppIconService"
    }

    /**
     * Constructs ComponentName for the activity-alias.
     * The manifest now uses fully qualified names: fyi.procrastinator.aero.DEFAULT
     * 
     * We construct ComponentName using the package name and the full qualified class name.
     * Since we use fully qualified names in the manifest, we need to match exactly.
     */
    private fun getComponentName(context: Context, aliasName: String): ComponentName {
        val packageName = context.packageName
        // Remove any dot prefix if present (aliasName from Dart is "DEFAULT", "ZERO_TWO", etc.)
        val cleanAliasName = aliasName.removePrefix(".")
        
        // Construct the full qualified class name: packageName.aliasName
        // e.g., "fyi.procrastinator.aero.DEFAULT"
        val fullClassName = "$packageName.$cleanAliasName"
        
        // Use ComponentName with package name and full qualified class name
        // This matches exactly what's in the manifest
        return ComponentName(packageName, fullClassName)
    }

    private fun isAliasEnabled(context: Context, aliasName: String): Boolean {
        return try {
            val componentName = getComponentName(context, aliasName)
            val state = context.packageManager.getComponentEnabledSetting(componentName)
            state == PackageManager.COMPONENT_ENABLED_STATE_ENABLED
        } catch (e: Exception) {
            Log.e(TAG, "Error checking if alias is enabled: $aliasName", e)
            false
        }
    }

    private fun setAliasEnabled(context: Context, aliasName: String) {
        val packageManager = context.packageManager
        Log.d(TAG, "Changing app icon to: $aliasName")
        
        // Always enable only the selected alias and disable all others
        // This ensures only one app icon appears at a time
        aliases.forEach { alias ->
            try {
                val componentName = getComponentName(context, alias)
                val action = if (alias == aliasName)
                    PackageManager.COMPONENT_ENABLED_STATE_ENABLED
                else
                    PackageManager.COMPONENT_ENABLED_STATE_DISABLED

                packageManager.setComponentEnabledSetting(
                    componentName,
                    action,
                    PackageManager.DONT_KILL_APP
                )
            } catch (e: IllegalArgumentException) {
                Log.e(TAG, "Failed to set component state for alias: $alias - ${e.message}")
            } catch (e: Exception) {
                Log.e(TAG, "Unexpected error setting component state for alias: $alias", e)
            }
        }
        Log.d(TAG, "App icon changed successfully to: $aliasName")
    }
}
