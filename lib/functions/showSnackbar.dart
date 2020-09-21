import 'package:flutter/material.dart';

showSnackbar(context, String message) {
  return SnackBar(
    content: Text("$message"),
    duration: Duration(seconds: 2),
  );
}
