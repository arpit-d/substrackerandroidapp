import 'package:flutter/material.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:substracker/ui/constants/title_c.dart';

class ArchiveBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          //color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(10.0),
              topRight: const Radius.circular(10.0))),
      //height: MediaQuery.of(context).size.width * 0.92,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildSizedBox(context),
          Center(
            child: GradientText(
              'Archived Subscriptions',
              gradient: titleGradient,
              style: const TextStyle(
                  fontSize: 25,
                  //fontFamily: 'Allura',
                  letterSpacing: 1.4,
                  fontWeight: FontWeight.bold),
            ),
          ),
          buildSizedBox(context),
          Divider(),
          buildSizedBox(context),
          Container(
            width: MediaQuery.of(context).size.width * 0.90,
            child: Center(
              child: Text(
                "Archive subscriptions is a list of subscriptions which are temporarily paused & are not counted as a part of your overall expenses. To unarchive a subscription, just swipe to the left!",
                style: const TextStyle(fontSize: 19),
              ),
            ),
          ),
          buildSizedBox(context),
        ],
      ),
    );
  }

  SizedBox buildSizedBox(BuildContext context) =>
      SizedBox(height: MediaQuery.of(context).size.height * 0.02);
}
