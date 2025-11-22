package fyi.procrastinator.aero.database.entity

import androidx.room.Entity
import androidx.room.PrimaryKey

@Entity
data class Airline(
    @PrimaryKey val uid: Int,
    val name: String?,
    val icao: String?,
    val iata: String?,
    val image: String?
)