import 'package:flutter/material.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:provider/provider.dart';
import 'package:substracker/models/sort.dart';

class ModalContent extends StatefulWidget {
  @override
  _ModalContentState createState() => _ModalContentState();
}

class _ModalContentState extends State<ModalContent> {
  final Color c1 = const Color(0xFFFEB692);
  final Color c2 = const Color(0xFFEA5455);
  @override
  Widget build(BuildContext context) {
    return Consumer<Sort>(
        builder: (BuildContext context, Sort s, Widget child) {
      return Container(
        //  height: MediaQuery.of(context).size.height*0.3,
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
                'Sort',
                gradient: LinearGradient(colors: [c1, c2]),
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
                s.changeSort('all');
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: const Text('Paid'),
              leading: const Icon(
                LineAwesomeIcons.check_circle_o,
                // color: const Color(0xFF2d2d2d),
              ),
              onTap: () {
                s.changeSort('Paid');
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: const Text('Pending'),
              leading: const Icon(
                LineAwesomeIcons.times,
                // color: const Color(0xFF2d2d2d),
              ),
              onTap: () {
                s.changeSort('Pending');
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: const Text('Upcoming'),
              leading: const Icon(
                LineAwesomeIcons.calendar_minus_o,
                // color: const Color(0xFF2d2d2d),
              ),
              onTap: () {
                s.changeSort('Upcoming');
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: const Text('Cost'),
              leading: const Icon(
                LineAwesomeIcons.money,
                // color: const Color(0xFF2d2d2d),
              ),
              onTap: () {
                s.changeSort('Cost');
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
