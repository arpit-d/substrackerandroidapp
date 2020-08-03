import 'package:flutter/material.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';

class ArchiveSubs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(LineAwesomeIcons.arrow_left),
          tooltip: 'Go Back',
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: GradientText(
          'Archived Subscriptions',
          gradient: LinearGradient(colors: [
            Color(0xFFFEB692),
            Color(0xFFEA5455),
          ]),
          style: const TextStyle(
              fontSize: 32,
              fontFamily: 'Allura',
              letterSpacing: 1.4,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
    );
  }
}