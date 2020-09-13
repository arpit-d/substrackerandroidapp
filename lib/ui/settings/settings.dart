import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:provider/provider.dart';
import 'package:substracker/models/dateformat.dart';
import 'package:substracker/models/sort.dart';
import 'package:substracker/ui/constants/title_c.dart';
import 'package:url_launcher/url_launcher.dart';

enum DateFormat { ddMMyy, MMddyy }

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  DateFormat format = DateFormat.ddMMyy;
  String dateFormatType = 'dd/MM/yy';
  final Uri _emailLaunchUri = Uri(
    scheme: 'mailto',
    path: 'btechcse3yr@gmail.com',
    queryParameters: {
      'subject': 'Bug report or Feature Request',
    },
  );

  getData() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    print('Running on ${androidInfo.model}');
  }

  @override
  Widget build(BuildContext context) {
    final box = Hive.box('subs');
    getData();
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
              leading: Icon(LineAwesomeIcons.calendar_o),
              trailing: Icon(LineAwesomeIcons.angle_right),
              title: const Text('Date Format'),
              // ignore: deprecated_member_use
              subtitle: WatchBoxBuilder(
                box: Hive.box('subs'),
                builder: (context, s) {
                  return Text(s.get('dateFormat'));
                },
              ),
              onTap: () async {
                return showModalBottomSheet(
                  shape: RoundedRectangleBorder(
                      borderRadius: const BorderRadius.only(
                          topLeft: const Radius.circular(10.0),
                          topRight: const Radius.circular(10.0))),
                  context: context,
                  builder: (BuildContext bc) {
                    return Consumer<DateFormatChanger>(builder:
                        (BuildContext context,
                            DateFormatChanger dateFormatChanger, Widget child) {
                      return StatefulBuilder(builder:
                          (BuildContext context, StateSetter setState) {
                        return Container(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              GradientText(
                                'Filter',
                                gradient: LinearGradient(
                                    colors: [Colors.red, Colors.blue]),
                                style: const TextStyle(
                                    fontSize: 25,
                                    letterSpacing: 1.4,
                                    fontWeight: FontWeight.bold),
                              ),
                              ListTile(
                                title: const Text('dd/MM/yy'),
                                leading: Radio(
                                  activeColor: const Color(0xFFEA5455),
                                  value: DateFormat.ddMMyy,
                                  groupValue: box.get('dateFormat')=='dd/MM/yy'?DateFormat.ddMMyy:DateFormat.MMddyy,
                                  onChanged: (value) {
                                    setState(() {
                                      dateFormatType = 'dd/MM/yy';
                                      format = DateFormat.ddMMyy;
                                      box.put('dateFormat', 'dd/MM/yy');
                                    });

                                    // dateFormatChanger
                                    //     .setDateFormat(dateFormatType);
                                  },
                                ),
                              ),
                              ListTile(
                                title: const Text('MM/dd/yy'),
                                leading: Radio(
                                  activeColor: const Color(0xFFEA5455),
                                  value: DateFormat.MMddyy,
                                  groupValue: box.get('dateFormat')=='dd/MM/yy'?DateFormat.ddMMyy:DateFormat.MMddyy,
                                  onChanged: (value) {
                                    setState(() {
                                      dateFormatType = 'MM/dd/yy';
                                      format = DateFormat.MMddyy;
                                      box.put('dateFormat', 'MM/dd/yy');
                                    });
                                    // print(box.get('dateFormat'));

                                    // dateFormatChanger
                                    //     .setDateFormat(dateFormatType);
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      });
                    });
                  },
                );
              },
            ),
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
            ListTile(
              leading: Icon(LineAwesomeIcons.thumbs_up),
              title: const Text('Rate App'),
              onTap: () => launch(
                  'https://play.google.com/store/apps/details?id=com.and.substracker'),
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
