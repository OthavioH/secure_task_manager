
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextTheme {

  static TextTheme get lightTextTheme => GoogleFonts.rubikTextTheme(
    ThemeData.light().textTheme,
  );
  static TextTheme get darkTextTheme => GoogleFonts.rubikTextTheme(
    ThemeData.dark().textTheme,
  );
}