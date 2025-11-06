import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:openapi/openapi.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SearchResultsList extends StatelessWidget {
  final List<Object> results;
  final bool loading;
  final AirlineEntity? selectedAirline;
  final String? selectedFlightNumber;
  final TextEditingController flightController;
  final Function(AirportEntity) onAirportSelected;
  final Function(AirlineEntity) onAirlineSelected;
  final Function(String) onFlightNumberSelected;

  const SearchResultsList({
    super.key,
    required this.results,
    required this.loading,
    required this.selectedAirline,
    required this.selectedFlightNumber,
    required this.flightController,
    required this.onAirportSelected,
    required this.onAirlineSelected,
    required this.onFlightNumberSelected,
  });

  @override
  Widget build(BuildContext context) {
    if (selectedAirline != null) {
      return SizedBox.shrink();
    }

    if (loading && results.isEmpty) {
      return Skeletonizer(
        child: ListView.builder(
          itemBuilder: (context, index) {
            final item = index == 0
                ? AirportEntity((b) {
                    b
                      ..id = ""
                      ..ident = "VIDP"
                      ..isoCountry = "IN"
                      ..lat = '0'
                      ..long = '0'
                      ..name = "Indira Gandhi International Airport"
                      ..type = AirportType.largeAirport
                      ..continent = "IDK"
                      ..isoRegion = "DEL"
                      ..build();
                  })
                : AirlineEntity((b) {
                    b
                      ..id = ""
                      ..iata = "IC"
                      ..icao = "ICE"
                      ..name = "Air India"
                      ..build();
                  });
            if (index == 0) {
              final airport = item as AirportEntity;
              return ListTile(
                title: Text(airport.name),
                leading: Container(
                  width: 30,
                  height: 30,
                  color: Colors.green,
                ),
              );
            } else {
              final airline = item as AirlineEntity;
              return ListTile(
                title: Text(airline.name),
                leading: Container(
                  width: 24,
                  height: 18,
                  color: Colors.green,
                ),
              );
            }
          },
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: 2,
        ),
      );
    }

    if (selectedAirline != null &&
        flightController.text.isNotEmpty &&
        selectedFlightNumber == null) {
      return ListTile(
        title: Text(selectedAirline!.name),
        subtitle: Text(
          "${selectedAirline!.iata}${flightController.text.toUpperCase()} / ${selectedAirline!.icao}${flightController.text.toUpperCase()}",
        ),
        leading: selectedAirline!.image != null &&
                selectedAirline!.image!.isNotEmpty
            ? SvgPicture.network(
                selectedAirline!.image!,
                width: 24,
                height: 18,
              )
            : CachedNetworkImage(
                imageUrl:
                    "https://airlabs.co/img/airline/m/${selectedAirline!.iata}.png",
                width: 24,
                height: 18,
                errorWidget: (context, url, error) {
                  return SizedBox(
                    height: 0,
                    width: 0,
                  );
                },
              ),
        onTap: () => onFlightNumberSelected(flightController.text),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final _item = results[index];
        final runtimeType = _item.runtimeType.toString();
        if (runtimeType == '_\$AirportEntity') {
          final airport = _item as AirportEntity;
          return ListTile(
            title: Text(airport.name),
            subtitle: Text(
              "${airport.iataCode != null && airport.iataCode!.isNotEmpty ? "${airport.iataCode} • " : ""}${airport.isoCountry} • ${airport.ident}",
            ),
            leading: CachedNetworkImage(
              imageUrl:
                  "https://flagcdn.com/h40/${airport.isoCountry.toLowerCase()}.jpg",
              width: 30,
              height: 30,
              errorWidget: (context, url, error) {
                return SizedBox(
                  height: 0,
                  width: 0,
                );
              },
            ),
            onTap: () => onAirportSelected(airport),
          );
        } else {
          final airline = _item as AirlineEntity;
          return ListTile(
            title: Text(airline.name),
            subtitle: Text("${airline.iata} • ${airline.icao}"),
            leading: airline.image != null && airline.image!.isNotEmpty
                ? SvgPicture.network(
                    airline.image!,
                    width: 24,
                    height: 18,
                  )
                : CachedNetworkImage(
                    imageUrl:
                        "https://airlabs.co/img/airline/m/${airline.iata}.png",
                    width: 24,
                    height: 18,
                    errorWidget: (context, url, error) {
                      return SizedBox(
                        height: 0,
                        width: 0,
                      );
                    },
                  ),
            onTap: () => onAirlineSelected(airline),
          );
        }
      },
      itemCount: results.length,
      physics: NeverScrollableScrollPhysics(),
    );
  }
}

