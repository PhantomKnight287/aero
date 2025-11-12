import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:aero/interceptors/auth.dart';
import 'package:openapi/openapi.dart';

const SECONDARY_TEXT_COLOR = Color(0xff808080);

const API_URL = kDebugMode
    ? "https://planepal.procrastinator.fyi"
    : "https://aero.procrastinator.fyi";
const AUTH_TOKEN_KEY = "token";
const MAPBOX_API_KEY =
    "pk.eyJ1IjoicGhhbnRvbWtuaWdodDI4NyIsImEiOiJjbGt5MWlid2cxOXB6M3FyemJmbHQ4ZHUzIn0.m0G4VTc_PzvaS2QTxUlcTQ";

const METHOD_CHANNEL = "fyi.procrastinator.aero/planepal";

final openapi = Openapi(
  dio: Dio(
    BaseOptions(
      baseUrl: API_URL,
    ),
  ),
  interceptors: [
    AuthInterceptor(),
  ],
);

const MONTHS = [
  "January", // 0
  "February", // 1
  "March", // 2
  "April", // 3
  "May", // 4
  "June", // 5
  "July", // 6
  "August", // 7
  "September", // 8
  "October", // 9
  "November", // 10
  "December" // 11
];
