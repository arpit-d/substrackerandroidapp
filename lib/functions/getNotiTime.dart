import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:substracker/database/new_sub.dart';
import 'package:substracker/notifications/notification_manager.dart';

getNotificationTimings(DateTime createdAt, int i) {
  String notiId = createdAt.hour.toString() +
      createdAt.minute.toString() +
      createdAt.second.toString() +
      createdAt.millisecond.toString().substring(0, 2) +
      i.toString();

  return int.parse(notiId);
}

Future<void> setNotification(
    String periodType,
    DateTime payDate,
    String periodNo,
    String subsName,
    double subsPrice,
    String noti,
    TimeOfDay notiTime,
    DateTime createdAt) async {
  NotificationManager _noti = NotificationManager();
  DateTime realDays;
  for (int i = 0; i < 12; i++) {
    if (periodType == 'Day') {
      realDays = Jiffy(payDate).add(
        days: int.parse(periodNo),
      );
    } else if (periodType == 'Week') {
      realDays = Jiffy(payDate).add(
        weeks: int.parse(periodNo),
      );
    } else if (periodType == 'Year') {
      realDays = Jiffy(payDate).add(
        years: int.parse(periodNo),
      );
    } else {
      realDays = Jiffy(payDate).add(
        months: int.parse(periodNo),
      );
    }
    int notiId = getNotificationTimings(createdAt, i);

    var a =
        realDays.add(Duration(hours: notiTime.hour, minutes: notiTime.minute));

    if (noti == "One") {
      print(a.subtract(Duration(days: 1)));
      _noti.addNotifications(notiId, a.subtract(Duration(days: 1)), subsName,
          'Tomorrow', subsPrice.toString());
    } else if (noti == "Same") {
      await _noti.addNotifications(
          notiId, a, subsName, 'Today', subsPrice.toString());
    } else {
      print('no');
    }
    payDate = realDays;
  }
}
