import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:math';

class NotificationManager {
  var flutterLocalNotificationsPlugin;

  NotificationManager() {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    initNotifications();
  }

  getNotificationInstance() {
    return flutterLocalNotificationsPlugin;
  }

  deleteNoti() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  void initNotifications() {
    var initializationSettingsAndroid =
        AndroidInitializationSettings('@drawable/noti');

    var initializationSettingsIOS = IOSInitializationSettings(
       );

    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);

    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: onSelectNotification,
     
    );
  }

  Future onSelectNotification(String payload) async {
    print('test');
    return Future.value(0);
  }


  Future noti(DateTime d, String subsName, String time, String price) async {
    var testNotiTime = DateTime.now().add(Duration(minutes: 6));
    var random = Random.secure();
    var value = random.nextInt(1000000000);
    var scheduledNotificationDateTime = testNotiTime;
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      '$subsName',
      'Reminder',
      'Subscription Payment Reminder',
      importance: Importance.Max,
      visibility: NotificationVisibility.Public,
      priority: Priority.Max,
      enableLights: true
      
    );
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    NotificationDetails platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.schedule(
        value,
        'Subsription Payment Reminder',
        'Please Pay Your Bill of $price For $subsName Which Ends $time',
        scheduledNotificationDateTime,
        platformChannelSpecifics, );
    print('Notification set at' +
        scheduledNotificationDateTime.toIso8601String());
  }

  void removeReminder(int notificationId) {
    flutterLocalNotificationsPlugin.cancel(notificationId);
  }
}
