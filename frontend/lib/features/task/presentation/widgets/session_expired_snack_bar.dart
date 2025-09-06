import 'package:flutter/material.dart';

showSessionExpiredSnackBar(BuildContext context) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('Your session has expired!'),
    ),
  );
}
