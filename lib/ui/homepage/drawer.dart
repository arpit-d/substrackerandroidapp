import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:provider/provider.dart';
import 'package:substracker/ui/apptheme/theme.dart';
import 'package:substracker/ui/homepage/archived/archive.dart';
import 'package:substracker/ui/settings/settings.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  final Color c1 = const Color(0xFFFEB692);

  final Color c2 = const Color(0xFFEA5455);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [c1, c2]),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: const <Widget>[],
            ),
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
            leading: const Icon(LineAwesomeIcons.archive),
            title: const Text('Archived '),
            onTap: () {
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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => SettingsPage()));
            },
          ),
        ],
      ),
    );
  }
}
