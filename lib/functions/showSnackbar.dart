import 'package:flutter/material.dart';

showSnackbar(context, String message) {
  return SnackBar(
    content: Text(
      "$message",
      style: TextStyle(color: Colors.white),
    ),
    backgroundColor: const Color(0xFFEA5455),
    duration: Duration(seconds: 2),
  );
}
