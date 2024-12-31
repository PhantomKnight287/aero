package com.phantomknight287.planepal.entities

import androidx.room.Dao
import androidx.room.Entity
import androidx.room.Insert
import androidx.room.PrimaryKey
import androidx.room.Query
import kotlinx.coroutines.flow.Flow
import java.util.Date
import java.time.Instant

@Entity(tableName = "flights")
data class Flight(
    @PrimaryKey()
    val id: String,
    val flightIata: String,
    val flightIcao: String,
    val date: Date,
    val origin: String,
    val destination: String,
)

@Dao
interface FlightDao {
    @Query("SELECT * FROM flights order by date DESC")
    fun getAllFlights(): Flow<List<Flight>>

    @Insert
    suspend fun insertFlight(flight: Flight)
}