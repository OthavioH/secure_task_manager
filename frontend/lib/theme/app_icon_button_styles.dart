import 'package:flutter/material.dart';

class AppIconButtonStyles {
  static final AppIconButtonStyles _instance = AppIconButtonStyles._internal();

  AppIconButtonStyles._internal();

  factory AppIconButtonStyles() {
    return _instance;
  }

  ButtonStyle negativeActionStyle(BuildContext context) {
    return IconButton.styleFrom(
      foregroundColor: Theme.of(context).colorScheme.error,
      side: BorderSide(
        color: Theme.of(context).colorScheme.error,
        width: 1.5,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      // minimumSize: const Size(50, 42),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    );
  }

  ButtonStyle? primaryActionStyle(ColorScheme colorScheme) {
    return IconButton.styleFrom(
      foregroundColor: colorScheme.onPrimaryContainer,
      side: BorderSide(
        color: colorScheme.onPrimaryContainer,
        width: 1.5,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    );
  }
}
