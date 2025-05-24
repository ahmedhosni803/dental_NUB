import 'package:flutter/cupertino.dart';
import 'package:toastification/toastification.dart';

class CustomToast {
  static showSuccessToast(String message) {
    Toastification().show(
        title: Text(message),
        autoCloseDuration: Duration(seconds: 2),
        type: ToastificationType.success,
        applyBlurEffect: true
    );
  }
  static showErrorToast(String message) {
    Toastification().show(
        title: Text(message),
        autoCloseDuration: Duration(seconds: 2),
        type: ToastificationType.error,
        applyBlurEffect: true
    );
  }
}