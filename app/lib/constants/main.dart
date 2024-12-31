import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:plane_pal/interceptors/auth.dart';
import 'package:openapi/openapi.dart';

const SECONDARY_TEXT_COLOR = Color(0xff808080);

const API_URL = "https://planepal.procrastinator.fyi";
const AUTH_TOKEN_KEY = "token";

const METHOD_CHANNEL = "com.phantomknight287.planepal/planepal";

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
