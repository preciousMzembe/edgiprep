import 'package:edgiprep/db/boxes.dart';
import 'package:edgiprep/db/notification/notification.dart';
import 'package:edgiprep/db/reminder/reminder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:permission_handler/permission_handler.dart';

class NotificationService extends GetxService {
  // Create a singleton instance
  static final NotificationService _instance = NotificationService._internal();

  factory NotificationService() => _instance;

  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  RxBool doneChangeTime = false.obs;
  RxBool newNotification = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();

    // Initialize time zones
    tz.initializeTimeZones();

    // Android-specific initialization
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings settings = InitializationSettings(
      android: androidSettings,
    );

    // Initialize the plugin
    await _notificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        // Handle notification tap (optional)
        debugPrint("Notification tapped: ${response.payload}");
      },
    );

    // Request notification permissions
    await requestNotificationPermission();

    // set default time
    setDefaultTime();

    checkBatteryOptimization();
  }

  static const platform = MethodChannel('battery_optimization');

  Future<void> checkBatteryOptimization() async {
    try {
      final isIgnoring =
          await platform.invokeMethod('isIgnoringBatteryOptimizations');
      if (!isIgnoring) {
        await platform.invokeMethod('requestIgnoreBatteryOptimizations');
      } else {
        debugPrint('Battery optimization is already exempted.');
      }
    } catch (e) {
      debugPrint('Error requesting battery optimization exemption: $e');
    }
  }

  Future<void> requestNotificationPermission() async {
    // Check and request permission
    final status = await Permission.notification.status;
    if (status.isDenied || status.isPermanentlyDenied) {
      await Permission.notification.request();
    }
  }

  // Schedule a daily reminder
  Future<void> scheduleDailyReminder({
    required DateTime time,
  }) async {
    final malawiTimeZone = tz.getLocation('Africa/Blantyre');
    final now = tz.TZDateTime.now(malawiTimeZone);

    final scheduleTime = tz.TZDateTime(
      malawiTimeZone,
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
    );

    try {
      await _notificationsPlugin.zonedSchedule(
        265,
        "It's Study Time! 📚✨",
        "Small steps lead to big achievements. Start your session now!",
        scheduleTime,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'daily_reminder_channel',
            'Daily Reminder',
            channelDescription: 'Daily reminders for EdgiPrep',
            importance: Importance.high,
            priority: Priority.high,
            playSound: true,
            enableLights: true,
            enableVibration: true,
            visibility: NotificationVisibility.public,
            showWhen: true,
          ),
        ),
        androidScheduleMode: AndroidScheduleMode.inexact,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
      );
      debugPrint("Notification scheduled successfully.");
    } catch (e) {
      debugPrint("Error scheduling notification: $e");
    }
  }

  /// Cancel a specific notification
  Future<void> cancelReminder() async {
    await _notificationsPlugin.cancel(265);
    debugPrint("Notification with id 265 canceled.");
  }

  // Show notification
  Future<void> showNotification(int id, String title, String message) async {
    try {
      await _notificationsPlugin.show(
        id,
        title,
        message,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'notification_channel',
            'User Notifications Channel',
            channelDescription: 'Channel for user notifications',
            importance: Importance.high,
            priority: Priority.high,
            playSound: true,
          ),
        ),
      );
      debugPrint("user notification shown successfully.");
    } catch (e) {
      debugPrint("Error showing user notification: $e");
    }
  }

  // time settings
  Future<void> setDefaultTime() async {
    if (reminderBox.isEmpty) {
      Reminder reminder = Reminder(time: "09:00 AM", set: false);

      await reminderBox.clear();
      await reminderBox.add(reminder);
    }

    doneChangeTime.value = !doneChangeTime.value;
  }

  Future<Reminder> getReminder() async {
    return reminderBox.values.first;
  }

  Future<void> changeTime(String time) async {
    if (reminderBox.isEmpty) {
      Reminder reminder = Reminder(time: time, set: false);

      await reminderBox.clear();
      await reminderBox.add(reminder);
    } else {
      Reminder reminder = reminderBox.values.first;

      Reminder newReminder = Reminder(time: time, set: reminder.set);
      await reminderBox.clear();
      await reminderBox.add(newReminder);

      // reset timer if set is true
      if (reminder.set) {
        DateTime parsedTime = DateFormat.jm().parse(time);

        scheduleDailyReminder(
          time: parsedTime,
        );
      }
    }

    doneChangeTime.value = !doneChangeTime.value;
  }

  Future<void> changeState() async {
    if (reminderBox.isNotEmpty) {
      Reminder reminder = reminderBox.values.first;

      Reminder newReminder = Reminder(time: reminder.time, set: !reminder.set);
      await reminderBox.clear();
      await reminderBox.add(newReminder);

      // set reminder
      if (newReminder.set) {
        DateTime parsedTime = DateFormat.jm().parse(reminder.time);

        scheduleDailyReminder(
          time: parsedTime,
        );
      } else {
        // cancel reminder
        cancelReminder();
      }
    }

    doneChangeTime.value = !doneChangeTime.value;
  }

  // general notifications
  Future<void> sendNewNotification(int id, String title, String message) async {
    UserNotification notification = UserNotification(
      title: title,
      message: message,
      seen: false,
      time: DateTime.now(),
    );

    await notificationBox.add(notification);

    showNotification(id, title, message);

    newNotification.value = !newNotification.value;
  }

  Future<bool> checkNewNotification() async {
    bool notificationFound = false;

    for (UserNotification notification in notificationBox.values) {
      if (notification.seen == false) {
        notificationFound = true;
      }
    }

    return notificationFound;
  }

  Future<List<UserNotification>> getNotifications() async {
    List<UserNotification> notifications =
        notificationBox.values.cast<UserNotification>().toList();

    return notifications;
  }

  Future<void> openNotifications() async {
    for (UserNotification notification in notificationBox.values) {
      notification.seen = true;
    }

    newNotification.value = !newNotification.value;
  }

  Future<void> deleteNotifications() async {
    await notificationBox.clear();

    newNotification.value = !newNotification.value;
  }
}
