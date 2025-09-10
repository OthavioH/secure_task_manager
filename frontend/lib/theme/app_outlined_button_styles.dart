import 'package:flutter/material.dart';

class AppOutlinedButtonStyles {
  static final AppOutlinedButtonStyles _instance = AppOutlinedButtonStyles._internal();

  AppOutlinedButtonStyles._internal();

  factory AppOutlinedButtonStyles() {
    return _instance;
  }

  ButtonStyle defaultTheme(ColorScheme theme) {
    return OutlinedButton.styleFrom(
      foregroundColor: theme.onSurface,
      side: BorderSide(
        color: theme.outline,
        width: 1.5,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      minimumSize: const Size(50, 42),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    );
  }
  ButtonStyle primaryStyle(BuildContext context) {
    return OutlinedButton.styleFrom(
      foregroundColor: Theme.of(context).colorScheme.primary,
      side: BorderSide(
        color: Theme.of(context).colorScheme.primary,
        width: 1.5,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      minimumSize: const Size(50, 42),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    );
  }

  ButtonStyle negativeActionStyle(BuildContext context) {
    return OutlinedButton.styleFrom(
      foregroundColor: Theme.of(context).colorScheme.error,
      side: BorderSide(
        color: Theme.of(context).colorScheme.error,
        width: 1.5,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      minimumSize: const Size(50, 42),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    );
  }
}
