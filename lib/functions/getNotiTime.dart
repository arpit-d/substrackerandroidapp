import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:substracker/notifications/notification_manager.dart';

getNotificationTimings(DateTime createdAt, int i) {
  String notiId;
  if (createdAt.hour < 12) {
    notiId = '-' +
        createdAt.hour.toString() +
        createdAt.minute.toString() +
        createdAt.second.toString() +
        createdAt.day.toString() +
        i.toString();
  } else {
    notiId = createdAt.hour.toString() +
        createdAt.minute.toString() +
        createdAt.second.toString() +
        createdAt.day.toString() +
        i.toString();
  }

  return int.parse(notiId);
}

removeNotifications(DateTime createdAt) {
  NotificationManager _noti = NotificationManager();
  for (int i = 0; i < 12; i++) {
    int notiId = getNotificationTimings(createdAt, i);
    
    _noti.removeReminder(notiId);
  }
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
  DateTime realDays;
  NotificationManager _noti = NotificationManager();
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
     
      _noti.addNotifications(notiId, a.subtract(Duration(days: 1)), subsName,
          'Tomorrow', subsPrice.toString());
    } else if (noti == "Same") {
      await _noti.addNotifications(
          notiId, a, subsName, 'Today', subsPrice.toString());
    } else {
      
    }
    payDate = realDays;
  }
}
