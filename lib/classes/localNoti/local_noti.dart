import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import "package:timezone/timezone.dart" as tz;

class NotificationsApp {
  final FlutterLocalNotificationsPlugin fluterLocalNotificationPlugin =
      FlutterLocalNotificationsPlugin();

  init() {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation("America/Mexico_City"));

    const AndroidInitializationSettings initializationSettingsandroid =
        AndroidInitializationSettings("ic_launcher");

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsandroid,
    );

    this.fluterLocalNotificationPlugin.initialize(initializationSettings);
  }

  Future<void> showNotification() async {
    const AndroidNotificationDetails androidPlatformChanellSpecifics =
        AndroidNotificationDetails("your Channel", "your Name",
            channelDescription: "channel Description",
            priority: Priority.max,
            importance: Importance.max);

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChanellSpecifics);
    //Channel Ios

    await this.fluterLocalNotificationPlugin.show(0, "this is a Notification",
        "inside Notification UwU", platformChannelSpecifics);
  }
}
