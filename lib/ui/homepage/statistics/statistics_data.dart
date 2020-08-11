import 'package:flutter/material.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';

class StatsData extends StatelessWidget {
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
          'Statistics',
          gradient: const LinearGradient(colors: [
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
      body: StatsDataBody(),
    );
  }
}

class StatsDataBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
      child: Text('data'),
    ));
  }
}
