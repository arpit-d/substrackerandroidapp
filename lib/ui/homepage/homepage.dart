import 'package:flutter/material.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:provider/provider.dart';
import 'package:substracker/functions/showSnackbar.dart';
import 'package:substracker/ui/apptheme/theme.dart';
import 'package:substracker/ui/homepage/bottomsheetmenu.dart';
import 'package:substracker/ui/homepage/statistics/statistics_data.dart';
import 'package:substracker/ui/homepage/subslist.dart';
import 'package:substracker/ui/newsubpage/newsubpage.dart';
import 'package:substracker/ui/homepage/filterbottomsheet.dart';
import 'package:substracker/ui/settings/settings.dart';

import 'archived/archive.dart';

class HomePage extends StatelessWidget {
  void _bottSheet(context, String type) async {
    showModalBottomSheet(
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
      key: scaffoldKey,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [c1, c2]),
              ),
              child: Container(),
            ),
            Consumer<ThemeNotifier>(
              builder: (context, notifier, child) => SwitchListTile(
                secondary: const Icon(LineAwesomeIcons.moon_o),
                activeColor: c2,
                title: const Text("Dark Mode"),
                onChanged: (val) {
                  notifier.toggleTheme();
                },
                value: notifier.darkTheme,
              ),
            ),
            ListTile(
              leading: const Icon(LineAwesomeIcons.bar_chart),
              title: const Text('Insights'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => StatsData()));
              },
            ),
            ListTile(
              leading: const Icon(LineAwesomeIcons.archive),
              title: const Text('Archived'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => ArchiveSubs()));
              },
            ),
            ListTile(
              leading: const Icon(LineAwesomeIcons.cog),
              title: const Text('Settings'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => SettingsPage()));
              },
            ),
          ],
        ),
      ),
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
              onPressed: () => scaffoldKey.currentState.openDrawer(),
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
          child: Builder(builder: (BuildContext context) {
            return IconButton(
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NewSubForm()),
                );

                if (result == 'Success')
                  Scaffold.of(context)
                    ..removeCurrentSnackBar()
                    ..showSnackBar(showSnackbar(
                        context, 'Subscription Added Succesfully!'));
              },
              icon: const Icon(
                LineAwesomeIcons.pencil,
                size: 30,
                color: Colors.white,
              ),
              tooltip: 'Add New Subscription',
            );
          }),
        ),
      ),
      body: SubsList(),
    );
  }
}
