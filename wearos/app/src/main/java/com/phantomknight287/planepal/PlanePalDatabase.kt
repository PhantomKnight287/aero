package com.phantomknight287.planepal

import android.content.Context
import androidx.room.Database
import androidx.room.Room
import androidx.room.RoomDatabase
import androidx.room.TypeConverters
import com.phantomknight287.planepal.converters.DateConverter
import com.phantomknight287.planepal.entities.Flight
import com.phantomknight287.planepal.entities.FlightDao


@Database(entities = [Flight::class], version = 1)
@TypeConverters(DateConverter::class)
abstract class PlanePalDatabase : RoomDatabase() {
    abstract fun flightsDao(): FlightDao


    companion object {
        // Volatile ensures the instance is immediately visible to other threads
        @Volatile
        private var INSTANCE: PlanePalDatabase? = null

        // Thread-safe method to get database instance
        fun getDatabase(context: Context): PlanePalDatabase {
            // If instance already exists, return it
            return INSTANCE ?: synchronized(this) {
                // Double-checked locking pattern
                INSTANCE ?: buildDatabase(context).also { INSTANCE = it }
            }
        }

        // Create database instance
        private fun buildDatabase(context: Context): PlanePalDatabase {
            return Room.databaseBuilder(
                context.applicationContext,
                PlanePalDatabase::class.java,
                "plane_pal_database"
            )
                .fallbackToDestructiveMigration()
                .build()
        }
    }
}