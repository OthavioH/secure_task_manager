import 'package:flutter/material.dart';
import 'package:simple_rpg_system/theme/progress_indicator_theme.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blue,
        brightness: Brightness.light,
      ),
      progressIndicatorTheme: AppProgressIndicatorTheme.lightTheme,
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blue,
        brightness: Brightness.dark,
      ),
      progressIndicatorTheme: AppProgressIndicatorTheme.darkTheme,
    );
  }
}
