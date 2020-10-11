import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:substracker/ui/settings/settings.dart';

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

    var initializationSettingsIOS = IOSInitializationSettings();

    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);

    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: onSelectNotification,
    );
  }

  Future onSelectNotification(s) async {
    return SettingsPage();
  }

  Future addNotifications(int notiId, DateTime d, String subsName, String time,
      String price) async {
    // var testNotiTime = DateTime.now().add(Duration(minutes: 1));

    var scheduledNotificationDateTime = d;
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      '$subsName',
      'Reminder',
      'Subscription Payment Reminder',
      importance: Importance.Max,
      visibility: NotificationVisibility.Public,
      priority: Priority.Max,
      enableLights: true,
      styleInformation: BigTextStyleInformation(''),
    );
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    NotificationDetails platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.schedule(
      notiId,
      'Subsription Payment Reminder',
      'Please Pay Your Bill of $price For $subsName Which Ends $time',
      scheduledNotificationDateTime,
      platformChannelSpecifics,
    );
    print('Notification set at' +
        scheduledNotificationDateTime.toIso8601String());
  }

  void removeReminder(int notificationId) {
    flutterLocalNotificationsPlugin.cancel(notificationId);
    print('Notification with $notificationId deleted');
  }
}
