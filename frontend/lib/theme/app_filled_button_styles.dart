import 'package:flutter/material.dart';

class AppFilledButtonStyles {
  static final AppFilledButtonStyles _instance = AppFilledButtonStyles._internal();

  AppFilledButtonStyles._internal();

  factory AppFilledButtonStyles() {
    return _instance;
  }

  ButtonStyle defaultTheme(ColorScheme theme) {
    return ElevatedButton.styleFrom(
      backgroundColor: theme.primary,
      foregroundColor: theme.onPrimary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      minimumSize: const Size(50, 42),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    );
  }
}
