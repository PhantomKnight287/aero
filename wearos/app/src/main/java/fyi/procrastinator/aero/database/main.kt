package fyi.procrastinator.aero.database

import android.content.Context
import androidx.room.Database
import androidx.room.Room
import androidx.room.RoomDatabase
import androidx.room.TypeConverters
import fyi.procrastinator.aero.database.converters.DateConverter
import fyi.procrastinator.aero.database.dao.AirlineDAO
import fyi.procrastinator.aero.database.dao.TrackedFlightDao
import fyi.procrastinator.aero.database.entity.Airline
import fyi.procrastinator.aero.database.entity.TrackedFlight

@Database(entities = [Airline::class, TrackedFlight::class], version = 1)
@TypeConverters(DateConverter::class)
abstract class AeroDatabase : RoomDatabase() {
    abstract fun airlineDao(): AirlineDAO
    abstract fun trackedFlightDao(): TrackedFlightDao

    companion object {
        @Volatile
        private var INSTANCE: AeroDatabase? = null

        fun getDatabase(context: Context): AeroDatabase {
            return INSTANCE ?: synchronized(this) {
                INSTANCE ?: buildDatabase(context).also { INSTANCE = it }
            }
        }

        private fun buildDatabase(context: Context): AeroDatabase {
            return Room.databaseBuilder(
                context.applicationContext,
                AeroDatabase::class.java,
                "aero"
            ).fallbackToDestructiveMigration().build()
        }
    }
}