package fyi.procrastinator.aero.database.entity

import androidx.room.ColumnInfo
import androidx.room.Embedded
import androidx.room.Entity
import androidx.room.ForeignKey
import androidx.room.Index
import androidx.room.PrimaryKey
import androidx.room.Relation

@Entity(
    tableName = "tracked_flights",
    foreignKeys = [
        ForeignKey(
            entity = Airline::class,
            parentColumns = ["uid"],
            childColumns = ["airline_uid"],
            onDelete = ForeignKey.CASCADE,
            onUpdate = ForeignKey.CASCADE
        )
    ],
    indices = [
        Index("airline_uid"),
        Index(value = ["flight_no", "flight_date"], unique = true)
    ]
)
data class TrackedFlight(
    @PrimaryKey(autoGenerate = true)
    @ColumnInfo(name = "flight_id")
    val flightId: Long = 0,
    @ColumnInfo(name = "airline_uid")
    val airlineUid: Int,
    @ColumnInfo(name = "flight_no")
    val flightNumber: String,
    @ColumnInfo(name = "ident_iata")
    val identIata: String?,
    @ColumnInfo(name = "ident_icao")
    val identIcao: String?,
    @ColumnInfo(name = "flight_date")
    val flightDateEpochSeconds: Long,
    @ColumnInfo(name = "departure_airport_iata")
    val departureAirportIata: String,
    @ColumnInfo(name = "departure_city")
    val departureCity: String,
    @ColumnInfo(name = "arrival_airport_iata")
    val arrivalAirportIata: String,
    @ColumnInfo(name = "arrival_city")
    val arrivalCity: String,
)

data class TrackedFlightWithAirline(
    @Embedded val flight: TrackedFlight,
    @Relation(
        parentColumn = "airline_uid",
        entityColumn = "uid"
    )
    val airline: Airline
)
