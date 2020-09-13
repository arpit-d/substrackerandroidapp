import 'package:flutter/material.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:substracker/ui/constants/title_c.dart';

class TitleText extends StatelessWidget {
  final String title;
  const TitleText(this.title);
  @override
  Widget build(BuildContext context) {
    return GradientText(
      '$title',
      gradient: titleGradient,
      style: const TextStyle(
          fontSize: 25, letterSpacing: 1.4, fontWeight: FontWeight.bold),
    );
  }
}
