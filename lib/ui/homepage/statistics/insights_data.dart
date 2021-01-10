// import 'package:flutter/material.dart';
// import 'package:line_awesome_icons/line_awesome_icons.dart';
// import 'package:provider/provider.dart';
// import 'package:substracker/database/new_sub.dart';
// import 'package:substracker/models/insights_sort.dart';
// import 'package:substracker/models/subsdatalist.dart';
// import 'package:substracker/ui/homepage/subslist.dart';
// import 'package:substracker/widgets/appbarTitleText.dart';
// import 'package:substracker/ui/homepage/homepage.dart';

// class InsightsDataPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: AppBarTitleText(
//           title: 'Insights',
//         ),
//         leading: IconButton(
//           icon: const Icon(LineAwesomeIcons.arrow_left),
//           tooltip: 'Go Back',
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//         actions: [
//           Builder(builder: (BuildContext context) {
//             return IconButton(
//               icon: const Icon(LineAwesomeIcons.angle_down),
//               tooltip: 'Sort Menu',
//               onPressed: () {
//                 bottSheet(context, 'insights');
//               },
//             );
//           }),
//         ],
//       ),
//       body: InsightsDataPageBody(),
//     );
//   }
// }

// class InsightsDataPageBody extends StatefulWidget {
//   @override
//   _InsightsDataPageBodyState createState() => _InsightsDataPageBodyState();
// }

// class _InsightsDataPageBodyState extends State<InsightsDataPageBody> {
//   @override
//   Widget build(BuildContext context) {
//     final db = Provider.of<MyDatabase>(context);
//     return Container(
//       child: buildInsightsData(db),
//     );
//   }

//   StreamBuilder<List<Sub>> buildInsightsData(MyDatabase db) {
//     final i = Provider.of<InsightsSort>(context);
//     return StreamBuilder(
//         stream: db.getSubs(),
//         builder: (context, AsyncSnapshot<List<Sub>> snapshot) {
//           final subs = snapshot.data ?? List(0);
//           List<String> payMethod = List<String>();
//           List<String> category = List<String>();
//           subs.forEach((element) {
//             if (element.payMethod == null && element.category == null) {
//             } else {
//               payMethod.add(element.payMethod);
//               category.add(element.category);
//             }
//             payMethod = payMethod.toSet().toList();
//             category = category.toSet().toList();
//           });
//           payMethod.removeWhere((element) => element == null);
//           category.removeWhere((element) => element == null);
//           print(payMethod.toString());
//           print(category.toString());
//           return Container();
//         });
//   }
// }
