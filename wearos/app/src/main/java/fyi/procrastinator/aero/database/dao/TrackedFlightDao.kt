package fyi.procrastinator.aero.database.dao

import androidx.room.Dao
import androidx.room.Insert
import androidx.room.OnConflictStrategy
import androidx.room.Query
import androidx.room.Transaction
import fyi.procrastinator.aero.database.entity.TrackedFlight
import fyi.procrastinator.aero.database.entity.TrackedFlightWithAirline
import kotlinx.coroutines.flow.Flow

@Dao
interface TrackedFlightDao {

    @Transaction
    @Query("SELECT * FROM tracked_flights ORDER BY flight_date DESC, flight_id DESC")
    fun getTrackedFlights(): Flow<List<TrackedFlightWithAirline>>

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    suspend fun upsertTrackedFlight(flight: TrackedFlight)

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    suspend fun upsertTrackedFlights(flights: List<TrackedFlight>)

    @Query("DELETE FROM tracked_flights WHERE flight_id = :flightId")
    suspend fun deleteTrackedFlight(flightId: Long)

    @Query("DELETE FROM tracked_flights")
    suspend fun clearTrackedFlights()
}


