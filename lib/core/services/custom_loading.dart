import 'package:buisness_test/main.dart';
import 'package:flutter/material.dart';

class Loading {
  static bool isLoading = false;

  static void show() {
    isLoading = true;
    showDialog(
      context: navigationKey.currentState!.context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  static void hide() {
    if (!isLoading) return;
    isLoading = false;
    Navigator.pop(navigationKey.currentState!.context);
  }
}
