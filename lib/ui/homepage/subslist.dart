import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive/hive.dart';
import 'package:jiffy/jiffy.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:provider/provider.dart';
import 'package:substracker/database/new_sub.dart';
import 'package:substracker/models/expenses.dart';
import 'package:substracker/models/numofsubs.dart';
import 'package:substracker/models/sort.dart';
import 'package:substracker/ui/subinfo/subinfo.dart';
import 'package:auto_size_text/auto_size_text.dart';

class SubsList extends StatefulWidget {
  @override
  _SubsListState createState() => _SubsListState();
}

class _SubsListState extends State<SubsList> {
  getRealDate(DateTime d, String pNo, String pType, bool sortType) {
    DateTime realDays;
    if (pType == 'Day') {
      realDays = Jiffy(d).add(days: int.parse(pNo));
    } else if (pType == 'Week') {
      realDays = Jiffy(d).add(weeks: int.parse(pNo));
    } else if (pType == 'Year') {
      realDays = Jiffy(d).add(years: int.parse(pNo));
    } else {
      realDays = Jiffy(d).add(months: int.parse(pNo));
    }
    while (realDays.isBefore(DateTime.now())) {
      if (pType == 'Day') {
        realDays = Jiffy(realDays).add(days: int.parse(pNo));
      } else if (pType == 'Week') {
        realDays = Jiffy(realDays).add(weeks: int.parse(pNo));
      } else if (pType == 'Year') {
        realDays = Jiffy(realDays).add(years: int.parse(pNo));
      } else {
        realDays = Jiffy(realDays).add(months: int.parse(pNo));
      }
    }
    if (sortType == true) {
      return realDays;
    }

    var r = 'Next Payment: ${realDays.day}-${realDays.month}-${realDays.year}';
    return r.toString();
  }

  final Color c1 = const Color(0xFFFEB692);
  final Color c2 = const Color(0xFFEA5455);
  @override
  Widget build(BuildContext context) {
    var box = Hive.box('subs');

    final db = Provider.of<MyDatabase>(context);
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.92,
        child: Column(
          children: [
            Expanded(
              child: subsListType(db, box),
            )
          ],
        ),
      ),
    );
  }

  StreamBuilder<List<Sub>> subsListType(MyDatabase db, Box box) {
    final s = Provider.of<Sort>(context);

    if (s.sorts == 'all') {
      return StreamBuilder(
        stream: db.getSubs(),
        builder: (context, AsyncSnapshot<List<Sub>> snapshot) {
          final subs = snapshot.data ?? List(0);

          return allSubsList(context, box, subs, db, 'EXPENSES');
        },
      );
    } else if (s.sorts == 'Paid') {
      return StreamBuilder(
        stream: db.getPaidSubs(),
        builder: (context, AsyncSnapshot<List<Sub>> snapshot) {
          final subs = snapshot.data ?? List(0);

          return allSubsList(context, box, subs, db, 'PAID');
        },
      );
    } else if (s.sorts == 'Upcoming') {
      return StreamBuilder(
        stream: db.getSubsUpcoming(),
        builder: (context, AsyncSnapshot<List<Sub>> snapshot) {
          final subs = snapshot.data ?? List(0);
          subs.sort((a, b) {
            return getRealDate(a.payDate, a.periodNo, a.periodType, true)
                .compareTo(
                    getRealDate(b.payDate, b.periodNo, b.periodType, true));
          });
          return allSubsList(context, box, subs, db, 'EXPENSES');
        },
      );
    } else {
      return StreamBuilder(
        stream: db.getPendingSubs(),
        builder: (context, AsyncSnapshot<List<Sub>> snapshot) {
          final subs = snapshot.data ?? List(0);
          return allSubsList(context, box, subs, db, 'PENDING');
        },
      );
    }
  }

  Widget allSubsList(BuildContext context, Box box, List<Sub> subs,
      MyDatabase db, String name) {
    final exp = Provider.of<Expenses>(context);
    final num = Provider.of<NumOfSubs>(context);
    if (subs.length == 0) {
      exp.setExpenses(0);
      num.totalSubs(0);
      return Center(
        child: Container(
          child: const Text(
              'You Have Not Added Any Subscriptions Yet. \n Click On The Below Button To Start!'),
        ),
      );
    }
    return Column(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.015),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [c1, c2]),
            borderRadius: const BorderRadius.all(
              const Radius.circular(10),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.13,
                width: MediaQuery.of(context).size.width * 0.43,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: Text(
                          '$name',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.normal,
                              letterSpacing: 1),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        child: Text(
                          exp.expenses == null
                              ? '0.00' + '\$'
                              : exp.expenses.toStringAsFixed(2) + '\$',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                              letterSpacing: 1),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.002),
              Container(
                height: MediaQuery.of(context).size.height * 0.13,
                width: MediaQuery.of(context).size.width * 0.43,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,
                      child: const Center(
                        child: const AutoSizeText(
                          'SUBSCRIPTIONS',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.normal,
                              letterSpacing: 1),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        child: Text(
                          num.nm.toString(),
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                              letterSpacing: 1),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        Expanded(
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: subs.length,
            itemBuilder: (_, index) {
              final item = subs[index];
              double sum = 0;
              subs.forEach((element) {
                sum = sum + element.subsPrice;
              });

              exp.setExpenses(sum);
              num.totalSubs(subs.length);

              return Slidable(
                actionPane: const SlidableDrawerActionPane(),
                actionExtentRatio: 0.25,
                secondaryActions: <Widget>[
                  IconSlideAction(
                    caption: 'Delete',
                    color: const Color(0xFFEE244D),
                    icon: LineAwesomeIcons.trash_o,
                    onTap: () {
                      db.deleteTask(item);
                    },
                  ),
                ],
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ListTile(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => SubInfo(
                                  name: item.subsName,
                                  firstPayment: item.payDate,
                                  charges: item.subsPrice,
                                  periodNo: item.periodNo,
                                  notes: item.notes,
                                  periodType: item.periodType,
                                  payStatus: item.payStatus,
                                  payDate: item.payDate,
                                  payMethod: item.payMethod,
                                  category: item.category,
                                  id: item.id,
                                  initialCharges: (item.subsPrice),
                                ))),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(item.subsName),
                        Text(item.subsPrice.toStringAsFixed(2) + '\$'),
                      ],
                    ),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          getRealDate(item.payDate, item.periodNo,
                              item.periodType, false),
                          style: const TextStyle(fontSize: 16),
                        ),
                        Text(item.periodNo.toString() == '1'
                            ? 'Per ${item.periodType}'
                            : 'Per ${item.periodNo} ${item.periodType}s')
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
