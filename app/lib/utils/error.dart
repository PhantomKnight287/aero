import 'package:dio/dio.dart';
import 'package:toastification/toastification.dart';
import 'package:flutter/material.dart';
import 'package:aero/ui/tokens.dart';

getErrorMessage(dynamic error, [String? message]) {
  if (error is String) {
    return error;
  } else if (error is Map) {
    if (error['message'] is List) {
      return error['message'][0];
    } else {
      return error['message'];
    }
  } else {
    return message ?? 'Something went wrong';
  }
}

ToastificationItem showErrorToast(dynamic error) {
  final message = error is DioException
      ? getErrorMessage(error.response?.data)
      : getErrorMessage(error, 'An unexpected error occurred');
  return toastification.show(
    title: const Text(
      "An error occurred",
    ),
    description: Text(message),
    type: ToastificationType.error,
    style: ToastificationStyle.minimal,
    autoCloseDuration: const Duration(
      seconds: 3,
    ),
    showProgressBar: false,
  );
}

ToastificationItem showSuccessToast({String? title, String? description}) {
  return toastification.show(
    title: title != null
        ? Text(
            title,
          )
        : null,
    description: description != null ? Text(description) : null,
    type: ToastificationType.success,
    style: ToastificationStyle.minimal,
    autoCloseDuration: const Duration(
      seconds: 3,
    ),
    showProgressBar: false,
  );
}

/// Neutral information toast (e.g. explaining a setting that just changed).
ToastificationItem showInfoToast({required String title, String? description}) {
  return toastification.show(
    title: Text(title, style: AeroText.heading),
    description:
        description != null ? Text(description, style: AeroText.caption) : null,
    type: ToastificationType.info,
    style: ToastificationStyle.minimal,
    autoCloseDuration: const Duration(seconds: 3),
    showProgressBar: false,
  );
}
