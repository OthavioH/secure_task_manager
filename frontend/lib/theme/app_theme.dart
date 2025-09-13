import 'package:flutter/material.dart';
import 'package:simple_rpg_system/core/utils/size_utils.dart';
import 'package:simple_rpg_system/theme/app_filled_button_styles.dart';
import 'package:simple_rpg_system/theme/app_outlined_button_styles.dart';
import 'package:simple_rpg_system/theme/app_text_theme.dart';

class AppTheme {
  AppTheme._();

  static Color get seedColor => Colors.deepPurple;

  static ThemeData get lightTheme {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: Brightness.light,
    );
    return ThemeData.light().copyWith(
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.surface,
      appBarTheme: const AppBarThemeData(
        actionsPadding: EdgeInsets.symmetric(horizontal: SizeUtils.kHorizontalPadding),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        constraints: BoxConstraints(
          maxWidth: 80,
          minWidth: 50,
        ),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        constraints: BoxConstraints(minHeight: 100, maxHeight: 400, maxWidth: 600)
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: AppFilledButtonStyles().defaultTheme(colorScheme),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: AppOutlinedButtonStyles().defaultTheme(colorScheme),
      ),
      textTheme: AppTextTheme.lightTextTheme,
    );
  }

  static ThemeData get darkTheme {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: Brightness.dark,
    );
    return ThemeData.dark().copyWith(
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.surface,
      textTheme: AppTextTheme.darkTextTheme,
      appBarTheme: const AppBarThemeData(
        actionsPadding: EdgeInsets.symmetric(horizontal: SizeUtils.kHorizontalPadding),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        constraints: BoxConstraints(minHeight: 100, maxHeight: 400, maxWidth: 600)
      ),
      inputDecorationTheme: const InputDecorationTheme(
        constraints: BoxConstraints(
          maxWidth: 80,
          minWidth: 50,
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: AppFilledButtonStyles().defaultTheme(colorScheme),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: AppOutlinedButtonStyles().defaultTheme(colorScheme),
      ),
    );
  }
}
