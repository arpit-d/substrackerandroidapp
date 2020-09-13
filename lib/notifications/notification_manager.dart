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
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);

    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);

    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: onSelectNotification,
      // onDidReceiveLocalNotification: onDidReceiveLocalNotification(
      //     1, 'Reminder', 'Subscription Payment Reminder', 'test')
    );
  }

  Future onSelectNotification(String payload) async {
    print('Notification clicked');
    return Future.value(0);
  }

  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    print('hello');
  }

  Future noti(DateTime d, String subsName, String time, String price) async {
    var random = Random.secure();

    var value = random.nextInt(1000000000);
    var scheduledNotificationDateTime =
        DateTime.now().add(Duration(seconds: 10));
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      '$subsName',
      'Reminder',
      'Subscription Payment Reminder',
      importance: Importance.Max,
      visibility: NotificationVisibility.Public,
      priority: Priority.Max,
    );
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    NotificationDetails platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.schedule(
        value,
        'Subsription Payment Reminder',
        'Please Pay Your Bill of $price For $subsName Which Ends $time',
        scheduledNotificationDateTime,
        platformChannelSpecifics);
    print('Notification set at' +
        scheduledNotificationDateTime.toIso8601String());
  }

  void removeReminder(int notificationId) {
    flutterLocalNotificationsPlugin.cancel(notificationId);
  }
}
