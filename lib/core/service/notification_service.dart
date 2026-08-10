import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/standalone.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  NotificationService({required this.flutterLocalNotificationsPlugin}) {
    tz.initializeTimeZones();
  }

  Future<void> showNotificationWithActions() async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
          '11',
          'todos_tasks',
          channelDescription: 'This channel created for notification Todos App',
          importance: Importance.max,
          priority: Priority.high,
          ticker: 'ticker',
        );
    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );
    await flutterLocalNotificationsPlugin.show(
      id: 0,
      title: 'plain title',
      body: 'plain body',
      notificationDetails: notificationDetails,
      payload: 'item x',
    );
  }

  Future<void> createSheduleNotification({
    bool? importance,
    String? tickerText,
    required TZDateTime todoDateTime,
    String? title = "Some task",
    required int taskId,
  }) async {
    importance ??= false;
    tickerText ??= "Create shedule notification";
    // todoDateTime ??= TZDateTime.now(tz.local);
    final AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
          "13",
          "todos_app_shedule_notification_channel",
          importance: importance ? Importance.max : Importance.high,
          priority: Priority.high,
          ticker: tickerText,
        );
    final NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id: taskId,
      title: title,
      // scheduledDate: tz.TZDateTime.now(tz.local).add(Duration(seconds: 3)),   notificationDetails: notificationDetails, androidScheduleMode: AndroidScheduleMode.alarmClock);
      scheduledDate: todoDateTime.isBefore(TZDateTime.now(tz.local))
          ? tz.TZDateTime.now(tz.local).add(Duration(seconds: 1))
          : todoDateTime,
      notificationDetails: notificationDetails,
      androidScheduleMode: AndroidScheduleMode.alarmClock,
    );
  }

  Future<void> cancel(int taskId) async {
    if (taskId == -1) return;
    await flutterLocalNotificationsPlugin.cancel(id: taskId);
  }
}
