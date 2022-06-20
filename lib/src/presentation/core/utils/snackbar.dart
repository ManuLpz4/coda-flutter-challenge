import 'package:flutter/material.dart';

void showErrorSnackBar(BuildContext context, String message) {
  final scaffoldMessenger = ScaffoldMessenger.of(context);
  final snackBar = SnackBar(
    backgroundColor: Colors.red,
    content: Text(message),
  );

  scaffoldMessenger.clearSnackBars();
  scaffoldMessenger.showSnackBar(snackBar);
}
