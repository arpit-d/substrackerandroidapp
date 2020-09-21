import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive/hive.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:provider/provider.dart';
import 'package:substracker/database/new_sub.dart';
import 'package:substracker/functions/getDate.dart';
import 'package:substracker/models/expenses.dart';
import 'package:substracker/models/filter.dart';
import 'package:substracker/models/numofsubs.dart';
import 'package:substracker/models/sort.dart';
import 'package:substracker/models/subsdatalist.dart';
import 'package:substracker/ui/subinfo/subinfo.dart';
import 'package:auto_size_text/auto_size_text.dart';

import 'archived/archive.dart';

class SubsList extends StatefulWidget {
  @override
  _SubsListState createState() => _SubsListState();
}

class _SubsListState extends State<SubsList> {
  

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
    final filter = Provider.of<Filter>(context);

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
    } else if (s.sorts == 'Cost') {
      return StreamBuilder(
        stream: db.getSubsByCost(),
        builder: (context, AsyncSnapshot<List<Sub>> snapshot) {
          final subs = snapshot.data ?? List(0);
          subs.sort((a, b) {
            return b.subsPrice.compareTo(a.subsPrice);
          });
          return allSubsList(context, box, subs, db, 'EXPENSES');
        },
      );
    } else if (s.sorts == 'Upcoming') {
      return StreamBuilder(
        stream: db.getSubsUpcoming(),
        builder: (context, AsyncSnapshot<List<Sub>> snapshot) {
          final subs = snapshot.data ?? List(0);
          subs.sort((a, b) {
            return getRealDate(a.payDate, a.periodNo, a.periodType, true,
                    box.get('dateFormat', defaultValue: 'dd/MM/yy'))
                .compareTo(getRealDate(b.payDate, b.periodNo, b.periodType,
                    true, box.get('dateFormat', defaultValue: 'dd/MM/yy')));
          });
          return allSubsList(context, box, subs, db, 'EXPENSES');
        },
      );
    } else if (s.sorts == 'Pending') {
      return StreamBuilder(
        stream: db.getPendingSubs(),
        builder: (context, AsyncSnapshot<List<Sub>> snapshot) {
          final subs = snapshot.data ?? List(0);
          return allSubsList(context, box, subs, db, 'PENDING');
        },
      );
    } else if (s.sorts == 'pay') {
      return StreamBuilder(
        stream: db.getPayment(filter.getFilter),
        builder: (context, AsyncSnapshot<List<Sub>> snapshot) {
          final subs = snapshot.data ?? List(0);
          return allSubsList(
              context, box, subs, db, '${filter.getFilter}'.toUpperCase());
        },
      );
    } else {
      return StreamBuilder(
        stream: db.getCategories(filter.getFilter),
        builder: (context, AsyncSnapshot<List<Sub>> snapshot) {
          final subs = snapshot.data ?? List(0);
          return allSubsList(
              context, box, subs, db, '${filter.getFilter}'.toUpperCase());
        },
      );
    }
  }

  Widget allSubsList(BuildContext context, Box box, List<Sub> subs,
      MyDatabase db, String name) {
    final exp = Provider.of<Expenses>(context);
    final num = Provider.of<NumOfSubs>(context);
    final subsDataList = Provider.of<SubsDataList>(context);

    if (subs.length == 0) {
      // exp.setExpenses(0);
      // num.totalSubs(0);
      return Center(
        child: Container(
          child: const Text(
            '''You Have Not Added Any Subscriptions Yet. 
          Click On The Below Icon To Start!''',
            style: const TextStyle(fontSize: 18),
          ),
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
              subsDataList.setSubList(subs);
              return Slidable(
                actionPane: const SlidableDrawerActionPane(),
                actionExtentRatio: 0.25,
                secondaryActions: <Widget>[
                  IconSlideAction(
                    caption: 'Archive',
                    color: const Color(0xFFFFF000),
                    icon: LineAwesomeIcons.archive,
                    onTap: () {
                      final sub = Sub(
                          id: item.id,
                          subsPrice: item.subsPrice,
                          subsName: item.subsName,
                          notes: item.notes,
                          payStatus: item.payStatus,
                          payMethod: item.payMethod,
                          payDate: item.payDate,
                          periodNo: item.periodNo,
                          periodType: item.periodType,
                          category: item.category,
                          currency: '\$',
                          archive: 'true');
                      db.updateSub(sub);

                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: const Text('Subscription Archived!'),
                          action: SnackBarAction(
                            label: 'SEE ALL ARCHIVED',
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      ArchiveSubs(),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                  IconSlideAction(
                    caption: 'Delete',
                    color: const Color(0xFFFF0000),
                    icon: LineAwesomeIcons.trash_o,
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Delete subscription record?"),
                            content: const Text(
                                "Are you sure you want to delete this record? Action can't be reversed!"),
                            actions: <Widget>[
                              FlatButton(
                                child: const Text("YES"),
                                onPressed: () {
                                  db.deleteTask(item);
                                  Navigator.of(context).pop();
                                },
                              ),
                              FlatButton(
                                child: const Text("NO"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              )
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
                child: Card(
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
                        Text(item.subsPrice.toStringAsFixed(2) + item.currency),
                      ],
                    ),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          getRealDate(
                              item.payDate,
                              item.periodNo,
                              item.periodType,
                              false,
                              box.get('dateFormat', defaultValue: 'dd/MM/yy')),
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
