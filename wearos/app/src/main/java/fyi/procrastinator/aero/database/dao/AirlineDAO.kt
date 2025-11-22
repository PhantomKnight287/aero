package fyi.procrastinator.aero.database.dao

import androidx.room.Dao
import androidx.room.Insert
import androidx.room.OnConflictStrategy
import androidx.room.Query
import fyi.procrastinator.aero.database.entity.Airline

@Dao
interface AirlineDAO {
    @Insert(onConflict = OnConflictStrategy.REPLACE)
    suspend fun upsertAirline(airline: Airline)

    @Query("SELECT * from Airline")
    fun getAll(): List<Airline>

    @Query("Select * from Airline where name=:name")
    fun getAirlineWithName(name:String):List<Airline>

    @Query("Select * from Airline where iata=:iata")
    fun getAirlineByIATA(iata:String):List<Airline>

    @Query("Select * from Airline where icao=:icao")
    fun getAirlineByICAO(icao:String):List<Airline>
}