class FlightInfo {
  Aircraft? aircraft;
  Airline? airline;
  Arrival? arrival;
  String? codeshareStatus;
  Departure? departure;
  GreatCircleDistance? greatCircleDistance;
  bool? isCargo;
  String? lastUpdatedUtc;
  String? number;
  String? status;
  String flightNumber;
  String? image;
  String id;

  FlightInfo({
    this.aircraft,
    this.airline,
    this.arrival,
    this.codeshareStatus,
    this.departure,
    this.greatCircleDistance,
    this.isCargo,
    this.lastUpdatedUtc,
    this.number,
    this.status,
    this.image,
    required this.flightNumber,
    required this.id,
  });

  FlightInfo.fromJson(Map<String, dynamic> json)
      : flightNumber = json['flight_no'],
        id = json['id'] {
    aircraft = json['aircraft'] != null ? Aircraft.fromJson(json['aircraft']) : null;
    airline = json['airline'] != null ? Airline.fromJson(json['airline']) : null;
    arrival = json['arrival'] != null ? Arrival.fromJson(json['arrival']) : null;
    codeshareStatus = json['codeshareStatus'];
    departure = json['departure'] != null ? Departure.fromJson(json['departure']) : null;
    greatCircleDistance = json['greatCircleDistance'] != null ? GreatCircleDistance.fromJson(json['greatCircleDistance']) : null;
    isCargo = json['isCargo'];
    lastUpdatedUtc = json['lastUpdatedUtc'];
    number = json['number'];
    status = json['status'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (aircraft != null) {
      data['aircraft'] = aircraft!.toJson();
    }
    if (airline != null) {
      data['airline'] = airline!.toJson();
    }
    if (arrival != null) {
      data['arrival'] = arrival!.toJson();
    }
    data['codeshareStatus'] = codeshareStatus;
    if (departure != null) {
      data['departure'] = departure!.toJson();
    }
    if (greatCircleDistance != null) {
      data['greatCircleDistance'] = greatCircleDistance!.toJson();
    }
    data['isCargo'] = isCargo;
    data['lastUpdatedUtc'] = lastUpdatedUtc;
    data['number'] = number;
    data['status'] = status;
    data['image'] = image;
    data['id'] = id;
    return data;
  }
}

class Aircraft {
  String model;
  String reg;
  String modeS;

  Aircraft({
    required this.model,
    required this.modeS,
    required this.reg,
  });

  Aircraft.fromJson(Map<String, dynamic> json)
      : model = json['model'],
        reg = json['reg'],
        modeS = json['modeS'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['model'] = model;
    data['modeS'] = modeS;
    data['reg'] = reg;
    return data;
  }
}

class Airline {
  String? iata;
  String? icao;
  String? name;

  Airline({this.iata, this.icao, this.name});

  Airline.fromJson(Map<String, dynamic> json) {
    iata = json['iata'];
    icao = json['icao'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['iata'] = iata;
    data['icao'] = icao;
    data['name'] = name;
    return data;
  }
}

class Arrival {
  Airport? airport;
  PredictedTime? predictedTime;
  List<String>? quality;
  PredictedTime? revisedTime;
  PredictedTime? scheduledTime;
  String? terminal;

  Arrival({this.airport, this.predictedTime, this.quality, this.revisedTime, this.scheduledTime, this.terminal});

  Arrival.fromJson(Map<String, dynamic> json) {
    airport = json['airport'] != null ? Airport.fromJson(json['airport']) : null;
    predictedTime = json['predictedTime'] != null ? PredictedTime.fromJson(json['predictedTime']) : null;
    quality = json['quality'].cast<String>();
    revisedTime = json['revisedTime'] != null ? PredictedTime.fromJson(json['revisedTime']) : null;
    scheduledTime = json['scheduledTime'] != null ? PredictedTime.fromJson(json['scheduledTime']) : null;
    terminal = json['terminal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (airport != null) {
      data['airport'] = airport!.toJson();
    }
    if (predictedTime != null) {
      data['predictedTime'] = predictedTime!.toJson();
    }
    data['quality'] = quality;
    if (revisedTime != null) {
      data['revisedTime'] = revisedTime!.toJson();
    }
    if (scheduledTime != null) {
      data['scheduledTime'] = scheduledTime!.toJson();
    }
    data['terminal'] = terminal;
    return data;
  }
}

class Airport {
  String? countryCode;
  String? iata;
  String? icao;
  Location? location;
  String? municipalityName;
  String? name;
  String? shortName;
  String? timeZone;

  Airport({this.countryCode, this.iata, this.icao, this.location, this.municipalityName, this.name, this.shortName, this.timeZone});

  Airport.fromJson(Map<String, dynamic> json) {
    countryCode = json['countryCode'];
    iata = json['iata'];
    icao = json['icao'];
    location = json['location'] != null ? Location.fromJson(json['location']) : null;
    municipalityName = json['municipalityName'];
    name = json['name'];
    shortName = json['shortName'];
    timeZone = json['timeZone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['countryCode'] = countryCode;
    data['iata'] = iata;
    data['icao'] = icao;
    if (location != null) {
      data['location'] = location!.toJson();
    }
    data['municipalityName'] = municipalityName;
    data['name'] = name;
    data['shortName'] = shortName;
    data['timeZone'] = timeZone;
    return data;
  }
}

class Location {
  double? lat;
  double? lon;

  Location({this.lat, this.lon});

  Location.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lon = json['lon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['lat'] = lat;
    data['lon'] = lon;
    return data;
  }
}

class PredictedTime {
  String? local;
  String? utc;

  PredictedTime({this.local, this.utc});

  PredictedTime.fromJson(Map<String, dynamic> json) {
    local = json['local'];
    utc = json['utc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['local'] = local;
    data['utc'] = utc;
    return data;
  }
}

class Departure {
  Airport? airport;
  String? gate;
  List<String>? quality;
  PredictedTime? revisedTime;
  PredictedTime? runwayTime;
  PredictedTime? scheduledTime;
  String? terminal;

  Departure({
    this.airport,
    this.gate,
    this.quality,
    this.revisedTime,
    this.runwayTime,
    this.scheduledTime,
    this.terminal,
  });

  Departure.fromJson(Map<String, dynamic> json) {
    airport = json['airport'] != null ? Airport.fromJson(json['airport']) : null;
    gate = json['gate'];
    quality = json['quality'].cast<String>();
    revisedTime = json['revisedTime'] != null ? PredictedTime.fromJson(json['revisedTime']) : null;
    runwayTime = json['runwayTime'] != null ? PredictedTime.fromJson(json['runwayTime']) : null;
    scheduledTime = json['scheduledTime'] != null ? PredictedTime.fromJson(json['scheduledTime']) : null;
    terminal = json['terminal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (airport != null) {
      data['airport'] = airport!.toJson();
    }
    data['gate'] = gate;
    data['quality'] = quality;
    if (revisedTime != null) {
      data['revisedTime'] = revisedTime!.toJson();
    }
    if (runwayTime != null) {
      data['runwayTime'] = runwayTime!.toJson();
    }
    if (scheduledTime != null) {
      data['scheduledTime'] = scheduledTime!.toJson();
    }
    if (terminal != null) {
      data['terminal'] = terminal;
    }
    return data;
  }
}

class GreatCircleDistance {
  double? feet;
  double? km;
  double? meter;
  double? mile;
  double? nm;

  GreatCircleDistance({this.feet, this.km, this.meter, this.mile, this.nm});

  GreatCircleDistance.fromJson(Map<String, dynamic> json) {
    feet = json['feet'];
    km = json['km'];
    meter = json['meter'];
    mile = json['mile'];
    nm = json['nm'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['feet'] = feet;
    data['km'] = km;
    data['meter'] = meter;
    data['mile'] = mile;
    data['nm'] = nm;
    return data;
  }
}
