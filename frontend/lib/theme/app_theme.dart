import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:simple_rpg_system/core/utils/size_utils.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: Colors.blue,
      brightness: Brightness.light,
    );
    return ThemeData.light().copyWith(
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.surface,
      appBarTheme: AppBarThemeData(
        actionsPadding: EdgeInsets.symmetric(horizontal: SizeUtils.kHorizontalPadding),
        centerTitle: true,
      ),
      inputDecorationTheme: InputDecorationTheme(
        constraints: BoxConstraints(
          maxWidth: 80,
          minWidth: 50,
        ),
      )
    );
  }

  static ThemeData get darkTheme {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: Colors.blue,
      brightness: Brightness.dark,
    );
    return ThemeData.dark().copyWith(
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.surface,
      appBarTheme: AppBarThemeData(
        actionsPadding: EdgeInsets.symmetric(horizontal: SizeUtils.kHorizontalPadding),
        centerTitle: true,
      ),
      bottomSheetTheme: BottomSheetThemeData(
        constraints: BoxConstraints(minHeight: 100, maxHeight: 400, maxWidth: 600)
      ),
      inputDecorationTheme: InputDecorationTheme(
        constraints: BoxConstraints(
          maxWidth: 80,
          minWidth: 50,
        ),
      )
    );
  }
}
