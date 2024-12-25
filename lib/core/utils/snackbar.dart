import 'package:flutter/material.dart';

void showSnackBar(
  BuildContext context, {
  required String message,
  bool isError = false,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Text(message),
      showCloseIcon: true,
      closeIconColor: Colors.white,
      backgroundColor: isError ? Colors.red : Colors.green,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
      margin: const EdgeInsets.all(0),
    ),
  );
}
