import 'package:flutter/material.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:substracker/ui/constants/title_c.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatelessWidget {
  final Uri _emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'arpitme199@gmail.com',
      queryParameters: {'subject': 'Bug report or Feature Request'});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(LineAwesomeIcons.arrow_left),
          tooltip: 'Go Back',
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: GradientText(
          'Settings',
          gradient: titleGradient,
          style: const TextStyle(
              fontSize: 32,
              fontFamily: 'Allura',
              letterSpacing: 1.4,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            const Divider(),
            ListTile(
              
              leading: Icon(LineAwesomeIcons.user),
              title: const Text('Contact Me!'),
              subtitle:
                  const Text('Reach out here for a bug, or a feature request'),
              onTap: () async {
                launch(_emailLaunchUri.toString());
              },
            ),
            const Divider(),
            const ListTile(
              leading: Icon(LineAwesomeIcons.thumbs_up),
              title: const Text('Rate App'),
              subtitle: const Text(
                  'Liked the app? Click here to rate it on Play Store'),
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
