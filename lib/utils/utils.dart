import 'package:flutter/material.dart';

class Utils {
  static snackBar(String message, BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 2),
      action: SnackBarAction(label: "OK", onPressed: () {}),
      content: Text(message),
      behavior: SnackBarBehavior.floating,
    ));
  }
}
