import 'package:flutter/material.dart';

void showCustomToast(BuildContext context, String message) {
  final scaffoldKey = ScaffoldMessenger.of(context);

  scaffoldKey.showSnackBar(
    SnackBar(
      content: Text(message),
      duration: Duration(seconds: 2), // Adjust the duration as needed
    ),
  );
}
