import 'package:flutter/material.dart';

class AppInputDecorations {
  static final AppInputDecorations _instance = AppInputDecorations._internal();

  AppInputDecorations._internal();

  factory AppInputDecorations() {
    return _instance;
  }

  InputDecoration filledTheme(ColorScheme colorScheme) {
    return InputDecoration(
      filled: true,
      fillColor: colorScheme.surfaceContainerLowest,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    );
  }
}
