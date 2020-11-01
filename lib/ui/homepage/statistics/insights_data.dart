import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:provider/provider.dart';
import 'package:substracker/database/new_sub.dart';
import 'package:substracker/models/subsdatalist.dart';
import 'package:substracker/ui/homepage/subslist.dart';
import 'package:substracker/widgets/appbarTitleText.dart';
import 'package:substracker/ui/homepage/homepage.dart';

class InsightsDataPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarTitleText(
          title: 'Insights',
        ),
        leading: IconButton(
          icon: const Icon(LineAwesomeIcons.arrow_left),
          tooltip: 'Go Back',
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          Builder(builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(LineAwesomeIcons.angle_down),
              tooltip: 'Sort Menu',
              onPressed: () {
               // bottSheet(context, 'sort');
              },
            );
          }),
        ],
      ),
      body: InsightsDataPageBody(),
    );
  }
}

class InsightsDataPageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
