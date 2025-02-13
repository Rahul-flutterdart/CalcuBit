// notification_service.dart
import 'dart:io';

import 'package:android_intent_plus/android_intent.dart';
import 'package:android_intent_plus/flag.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

class NotificationService {
  final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();
  Future<void> _requestExactAlarmPermission() async {
    if (Platform.isAndroid) {
      final intent = AndroidIntent(
        action: 'android.settings.REQUEST_SCHEDULE_EXACT_ALARM',
        flags: <int>[Flag.FLAG_ACTIVITY_NEW_TASK],
      );
      await intent.launch();
    }
  }
  Future<void> init() async {
    const AndroidInitializationSettings androidSettings =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings settings =
    InitializationSettings(android: androidSettings);

    await _notificationsPlugin.initialize(settings);

    // ✅ Request Notification Permission (For Android 13+)
    final androidImplementation = _notificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();

    if (androidImplementation != null) {
      bool? granted = await androidImplementation.requestNotificationsPermission();
      print("🔔 Notification Permission Granted: $granted");
      _requestExactAlarmPermission();
      await androidImplementation.createNotificationChannel(
        const AndroidNotificationChannel(
          'expense_channel',
          'Expense Notifications',
          description: 'Used for Expense Reminder Notifications',
          importance: Importance.max,
        ),
      );
    }

    tz.initializeTimeZones();
  }




  Future<void> showNotification({required String title, required String body}) async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'expense_channel', // ✅ Use the created channel ID
      'Expense Notifications',
      channelDescription: 'Used for Expense Reminder Notifications',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      enableVibration: true,
    );

    const NotificationDetails details = NotificationDetails(android: androidDetails);

    await _notificationsPlugin.show(
      0, // Notification ID
      title,
      body,
      details,
    );

  }

  Future<void> scheduleNotification({
    required String title,
    required String body,
    required DateTime scheduledTime,  // ✅ The time when notification should trigger
  }) async {
    final tz.TZDateTime tzScheduledTime = tz.TZDateTime.from(scheduledTime, tz.local); // ✅ Convert time

    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'expense_channel', // ✅ Channel ID
      'Expense Notifications', // ✅ Channel Name
      channelDescription: 'Used for Expense Reminder Notifications',
      importance: Importance.max, // ✅ Make it high priority
      priority: Priority.high,
      playSound: true,
      enableVibration: true,
    );

    const NotificationDetails details = NotificationDetails(android: androidDetails);

    await _notificationsPlugin.zonedSchedule(
      1, // ✅ Unique notification ID
      title, // ✅ Notification Title
      body,  // ✅ Notification Body
      tzScheduledTime, // ✅ The time it should be shown
      details,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      // androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      // uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      androidScheduleMode: AndroidScheduleMode.inexact,// ✅ Works even in Doze Mode
    );
  }

}
