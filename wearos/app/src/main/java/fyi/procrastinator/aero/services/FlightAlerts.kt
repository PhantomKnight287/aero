package fyi.procrastinator.aero.services

import android.Manifest
import android.annotation.SuppressLint
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import androidx.core.app.NotificationCompat
import androidx.core.app.NotificationManagerCompat
import androidx.core.content.ContextCompat
import fyi.procrastinator.aero.R
import fyi.procrastinator.aero.presentation.MainActivity

/** Buzz + notification for a flight change (gate, belt, delay, cancellation). */
object FlightAlerts {
    private const val CHANNEL = "flight_changes"

    @SuppressLint("MissingPermission") // checked just below
    fun post(context: Context, flightKey: String, title: String, changes: List<String>) {
        if (changes.isEmpty()) return
        if (ContextCompat.checkSelfPermission(context, Manifest.permission.POST_NOTIFICATIONS)
            != PackageManager.PERMISSION_GRANTED
        ) return

        val nm = context.getSystemService(NotificationManager::class.java)
        nm.createNotificationChannel(
            NotificationChannel(CHANNEL, "Flight changes", NotificationManager.IMPORTANCE_HIGH)
                .apply {
                    description = "Gate changes, delays and cancellations"
                    enableVibration(true)
                }
        )
        val open = PendingIntent.getActivity(
            context, 0, Intent(context, MainActivity::class.java), PendingIntent.FLAG_IMMUTABLE,
        )
        val notification = NotificationCompat.Builder(context, CHANNEL)
            .setSmallIcon(R.drawable.ic_flight)
            .setContentTitle(title)
            .setContentText(changes.joinToString(" · "))
            .setStyle(NotificationCompat.BigTextStyle().bigText(changes.joinToString("\n")))
            .setCategory(NotificationCompat.CATEGORY_STATUS)
            .setPriority(NotificationCompat.PRIORITY_HIGH)
            .setAutoCancel(true)
            .setContentIntent(open)
            .build()
        // One notification per flight: a newer change replaces the older one.
        NotificationManagerCompat.from(context).notify(flightKey.hashCode(), notification)
    }
}
