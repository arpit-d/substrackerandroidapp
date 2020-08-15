import 'package:flutter/material.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:provider/provider.dart';
import 'package:random_color/random_color.dart';
import 'package:substracker/database/new_sub.dart';
import 'package:substracker/models/subsdatalist.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:substracker/ui/apptheme/theme.dart';

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
        title: GradientText(
          'Statistics',
          gradient: const LinearGradient(colors: [
            Color(0xFFFEB692),
            Color(0xFFEA5455),
          ]),
          style: const TextStyle(
              fontSize: 32,
              fontFamily: 'Allura',
              letterSpacing: 1.4,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
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
      : this.color = new charts.Color(
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
    double w = MediaQuery.of(context).size.width;
    final subsProvider = Provider.of<SubsDataList>(context);
    final theme = Provider.of<ThemeNotifier>(context);

    List<Sub> subs = List();
    subs = subsProvider.listData;

    List<SubStatData> subsStat = List();
    double sum = 0;
    subs.forEach((element) {
      var a = SubStatData(
        element.subsName,
        element.subsPrice.toString(),
        _randomColor.randomColor(colorBrightness: ColorBrightness.dark),
      );
      sum = sum + element.subsPrice;
      subsStat.add(a);
    });
    print(sum.toString());

    List<charts.Series<SubStatData, String>> series = List();
    series = [
      new charts.Series<SubStatData, String>(
          colorFn: (SubStatData clickData, _) => (clickData.color),
          domainFn: (SubStatData clickData, _) => (clickData.subsPrice),
          measureFn: (SubStatData clickData, _) =>
              double.parse(clickData.subsPrice),
          id: 'Stats',
          labelAccessorFn: (SubStatData s, _) =>
              ' ${s.subsName} ' +
              '\n' +
              (double.parse(s.subsPrice) / sum * 100).toStringAsFixed(2) +
              '%',
          data: subsStat),
    ];

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text('aaa'),
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
                              color: charts.MaterialPalette.white, fontSize: 13)
                          : charts.TextStyleSpec(
                              color: charts.MaterialPalette.black,
                              fontSize: 13),
                      labelPosition: charts.ArcLabelPosition.outside)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}