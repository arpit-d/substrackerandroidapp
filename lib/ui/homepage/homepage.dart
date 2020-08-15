import 'package:flutter/material.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:substracker/ui/homepage/bottomsheetmenu.dart';
import 'package:substracker/ui/homepage/drawer.dart';
import 'package:substracker/ui/homepage/subslist.dart';
import 'package:substracker/ui/newsubpage/newsubpage.dart';
import 'package:substracker/ui/homepage/filterbottomsheet.dart';

class HomePage extends StatelessWidget {
  void _bottSheet(context, String type) async {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            // side: BorderSide.canMerge(a, b)
            borderRadius: const BorderRadius.only(
                topLeft: const Radius.circular(10.0),
                topRight: const Radius.circular(10.0))),
        context: context,
        builder: (BuildContext bc) {
          if (type == 'filter') {
            return FilterBottomSheet();
          }
          return ModalContent();
        });
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final Color c1 = const Color(0xFFFEB692);
  final Color c2 = const Color(0xFFEA5455);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        actions: <Widget>[
          Builder(builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(LineAwesomeIcons.filter),
              tooltip: 'Filter Menu',
              onPressed: () {
                _bottSheet(context, 'filter');
              },
            );
          }),
          Builder(builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(LineAwesomeIcons.angle_down),
              tooltip: 'Sort Menu',
              onPressed: () {
                _bottSheet(context, 'sort');
              },
            );
          }),
        ],
        title: GradientText(
          'Substracker',
          gradient: LinearGradient(colors: [c1, c2]),
          style: const TextStyle(
              fontSize: 32,
              fontFamily: 'Allura',
              letterSpacing: 1.4,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(LineAwesomeIcons.bars),
              tooltip: 'Open Drawer',
              onPressed: () => Scaffold.of(context).openDrawer(),
            );
          },
        ),
      ),
      floatingActionButton: SizedBox(
        // fit: BoxFit.cover,
        child: Container(
          constraints: BoxConstraints.tightFor(
              width: MediaQuery.of(context).size.width * 0.14,
              height: MediaQuery.of(context).size.height * 0.09),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(colors: [c1, c2]),
          ),
          child: IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => NewSubForm()));
            },
            icon: const Icon(
              LineAwesomeIcons.pencil,
              size: 30,
              color: Colors.white,
            ),
            tooltip: 'Add New Subscription',
          ),
        ),
      ),
      body: SubsList(),
    );
  }
}
