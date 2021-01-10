import 'package:flutter/material.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:provider/provider.dart';
import 'package:substracker/models/insights_sort.dart';
import 'package:substracker/ui/constants/title_c.dart';

class InsightsBottomSheet extends StatefulWidget {
  @override
  _InsightsBottomSheetState createState() => _InsightsBottomSheetState();
}

class _InsightsBottomSheetState extends State<InsightsBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Consumer<InsightsSort>(
        builder: (BuildContext context, InsightsSort s, Widget child) {
      return Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildSizedBox(context),
            Center(
              child: GradientText(
                'Sort',
                gradient: gradient,
                style: const TextStyle(
                    fontSize: 25,
                    //fontFamily: 'Allura',
                    letterSpacing: 1.4,
                    fontWeight: FontWeight.bold),
              ),
            ),
            buildSizedBox(context),
            Divider(),
            ListTile(
              title: const Text('All'),
              leading: const Icon(
                LineAwesomeIcons.list_ul,
                //color: const Color(0xFF2d2d2d),
              ),
              onTap: () {
                s.changeSortType('all');
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: const Text('Category'),
              leading: const Icon(
                LineAwesomeIcons.check_circle_o,
              ),
              onTap: () {
                s.changeSortType('category');

                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: const Text('Payment Method'),
              leading: const Icon(
                LineAwesomeIcons.times,
              ),
              onTap: () {
                s.changeSortType('paymentMethod');
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    });
  }

  SizedBox buildSizedBox(BuildContext context) =>
      SizedBox(height: MediaQuery.of(context).size.height * 0.02);
}
