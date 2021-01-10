import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:provider/provider.dart';
import 'package:random_color/random_color.dart';
import 'package:substracker/database/new_sub.dart';
import 'package:substracker/models/subsdatalist.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:substracker/ui/apptheme/theme.dart';
import 'package:substracker/widgets/appbarTitleText.dart';

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
        actions: [],
        title: AppBarTitleText(
          title: 'Insights',
        ),
      ),
      body: StatsDataBody(),
    );
  }
}

class SubStatData {
  final String subsName;
  final String subsPrice;
  final charts.Color color;

  SubStatData(this.subsName, this.subsPrice, Color color)
      : this.color = charts.Color(
            r: color.red, g: color.green, b: color.blue, a: color.alpha);
}

class StatsDataBody extends StatefulWidget {
  @override
  _StatsDataBodyState createState() => _StatsDataBodyState();
}

class _StatsDataBodyState extends State<StatsDataBody> {
  RandomColor _randomColor = RandomColor();

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    // double w = MediaQuery.of(context).size.width;
    final subsProvider = Provider.of<SubsDataList>(context);
    final theme = Provider.of<ThemeNotifier>(context);

    List<Sub> subs = List();
    subs = subsProvider.listData;

    List<SubStatData> subsStat = List();
    double sum = 0;
    double yearly = 0;
    double weekly = 0;

    subs.forEach((element) {
      double monthlySpend = element.subsPrice;
      if (element.periodType == 'Month') {
        monthlySpend = monthlySpend / int.parse(element.periodNo);
      } else if (element.periodType == 'Year') {
        monthlySpend = monthlySpend / (12 * int.parse(element.periodNo));
      } else if (element.periodType == "Week") {
        monthlySpend = monthlySpend * (4.34524 / int.parse(element.periodNo));
      } else if (element.periodType == "Day") {
        monthlySpend = monthlySpend * (30 / int.parse(element.periodNo));
      }

      sum = sum + monthlySpend;
      yearly = sum * 12;
      weekly = yearly / 52.1429;
      SubStatData _subStatData = SubStatData(
        element.subsName,
        monthlySpend.toString(),
        _randomColor.randomColor(colorBrightness: ColorBrightness.dark),
      );
      subsStat.add(_subStatData);
    });

    List<charts.Series<SubStatData, String>> series = List();
    series = [
      charts.Series<SubStatData, String>(
          colorFn: (SubStatData s, _) => (s.color),
          domainFn: (SubStatData s, _) => (s.subsPrice),
          measureFn: (SubStatData s, _) => double.parse(s.subsPrice),
          id: 'Stats',
          labelAccessorFn: (SubStatData s, _) =>
              ' ${s.subsName} ' +
              '\n' +
              (double.parse(s.subsPrice) / sum * 100).toStringAsFixed(2) +
              '%',
          data: subsStat),
    ];
    if (subs.length == 0) {
      return Center(
        child: Container(
          child: const Text(
            '''You Have Not Added Any Subscriptions Yet.''',
            style: const TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.92,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Container(
              height: h * 0.27,
              child: charts.PieChart(
                series,
                animate: true,
                defaultRenderer: charts.ArcRendererConfig(
                  arcWidth: 62,
                  arcRendererDecorators: [
                    charts.ArcLabelDecorator(
                        outsideLabelStyleSpec: theme.darkTheme
                            ? charts.TextStyleSpec(
                                color: charts.MaterialPalette.white,
                                fontSize: 13)
                            : charts.TextStyleSpec(
                                color: charts.MaterialPalette.black,
                                fontSize: 13),
                        labelPosition: charts.ArcLabelPosition.outside)
                  ],
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'AVG WEEKLY EXPENSES -',
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
                Text(
                  weekly.toStringAsFixed(2) + '\$',
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                )
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'AVG MONTHLY EXPENSES -',
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
                Text(
                  sum.toStringAsFixed(2) + '\$',
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                )
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'AVG YEARLY EXPENSES -',
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
                Text(
                  yearly.toStringAsFixed(2) + '\$',
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                )
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
          ],
        ),
      ),
    );
  }
}
