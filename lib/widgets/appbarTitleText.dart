import 'package:flutter/material.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:substracker/ui/constants/title_c.dart';

class AppBarTitleText extends StatelessWidget {
  final String title;
  const AppBarTitleText({this.title});

  @override
  Widget build(BuildContext context) {
    return GradientText(
      '$title',
      gradient: gradient,
      style: const TextStyle(
          fontSize: 32,
          fontFamily: 'Allura',
          letterSpacing: 1.4,
          fontWeight: FontWeight.bold),
    );
  }
}