import 'package:flutter/material.dart';

class AppProgressIndicatorTheme {

  static const ProgressIndicatorThemeData _baseTheme = ProgressIndicatorThemeData(
    strokeWidth: 1.5,
    constraints: BoxConstraints(
      maxHeight: 16,
      maxWidth: 16,
    ),
  );

  static ProgressIndicatorThemeData lightTheme = _baseTheme;

  static ProgressIndicatorThemeData darkTheme = _baseTheme;
}
