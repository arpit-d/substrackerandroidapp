import 'package:flutter/material.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:provider/provider.dart';
import 'package:substracker/database/new_sub.dart';
import 'package:substracker/models/subsdatalist.dart';
import 'package:charts_flutter/flutter.dart' as charts;

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
  String subsName;
  String subsPrice;
  SubStatData(this.subsName, this.subsPrice);
}

class StatsDataBody extends StatefulWidget {
  @override
  _StatsDataBodyState createState() => _StatsDataBodyState();
}

class _StatsDataBodyState extends State<StatsDataBody> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    final subsProvider = Provider.of<SubsDataList>(context);

    List<Sub> subs = List();
    subs = subsProvider.listData;

    List<SubStatData> subsStat = List();
    double sum = 0;
    subs.forEach((element) {
      var a = SubStatData(element.subsName, element.subsPrice.toString());
      sum = sum + element.subsPrice;
      subsStat.add(a);
    });
    print(sum.toString());

    List<charts.Series<SubStatData, String>> series = List();
    series = [
      new charts.Series<SubStatData, String>(
        
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
            // width: w*0.7,
            child: charts.PieChart(
              
              series,
              animate: true,
              
              defaultRenderer: charts.ArcRendererConfig(
                arcWidth: 62,
                arcRendererDecorators: [
                  charts.ArcLabelDecorator(
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
