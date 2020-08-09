import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:jiffy/jiffy.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:provider/provider.dart';
import 'package:substracker/database/new_sub.dart';
import 'package:substracker/ui/homepage/archived/archive_bottomsheet.dart';
import 'package:substracker/ui/subinfo/subinfo.dart';

class ArchiveSubs extends StatelessWidget {
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

  @override
  Widget build(BuildContext context) {
    final db = Provider.of<MyDatabase>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(LineAwesomeIcons.arrow_left),
          tooltip: 'Go Back',
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(LineAwesomeIcons.info_circle),
            onPressed: () {
              return showModalBottomSheet(
                shape: RoundedRectangleBorder(
                    borderRadius: const BorderRadius.only(
                        topLeft: const Radius.circular(10.0),
                        topRight: const Radius.circular(10.0))),
                context: context,
                builder: (BuildContext bc) {
                  return ArchiveBottomSheet();
                },
              );
            },
          ),
        ],
        title: GradientText(
          'Archive',
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
      body: StreamBuilder(
        stream: db.getArchiveSubs(),
        builder: (context, AsyncSnapshot<List<Sub>> snapshot) {
          final subs = snapshot.data ?? List(0);
          if (subs.length == 0) {
            return Center(
              child: Container(
                child: const Text(
                    'You Have Not Added Any Subscriptions Yet. \n Click On The Below Button To Start!'),
              ),
            );
          }
          return Container(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                Expanded(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: subs.length,
                    itemBuilder: (_, index) {
                      final item = subs[index];

                      return Slidable(
                        actionPane: const SlidableDrawerActionPane(),
                        actionExtentRatio: 0.25,
                        secondaryActions: <Widget>[
                          IconSlideAction(
                            caption: 'Unarchive',
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
                                  archive: 'false');
                              db.updateSub(sub);
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
                                    title: const Text(
                                        "Delete subscription record?"),
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
                          margin: const EdgeInsets.fromLTRB(5, 7, 5, 7),
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
                                Text(item.subsPrice.toStringAsFixed(2) +
                                    item.currency),
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
            ),
          );
        },
      ),
    );
  }
}
