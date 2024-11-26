import 'package:edgiprep/controllers/auth/auth_controller.dart';
import 'package:edgiprep/db/notification/notification.dart';
import 'package:edgiprep/db/reminder/reminder.dart';
import 'package:edgiprep/services/notification/notification_service.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationController extends GetxController {
  AuthController authController = Get.find<AuthController>();
  NotificationService notificationService = Get.find<NotificationService>();
  RxBool set = false.obs;
  Rx<Reminder?> reminder = Rx<Reminder?>(null);
  RxString settingsTime = "08:00 AM".obs;
  RxList<UserNotification> notifications = <UserNotification>[].obs;
  RxBool newNotifications = false.obs;

  @override
  void onInit() {
    super.onInit();

    // listen to change in user exams fetch
    ever(notificationService.doneChangeTime, (_) async {
      fetchReminder();
    });

    // listen to user to get notifications
    ever(authController.user, (_) async {
      sendNotifications();
      getNotifications();
      checkNewNotifications();
    });
    ever(notificationService.newNotification, (_) async {
      getNotifications();
      checkNewNotifications();
    });
  }

  Future<void> fetchReminder() async {
    reminder.value = await notificationService.getReminder();
    set.value = reminder.value!.set;
  }

  Future<void> changeTime() async {
    notificationService.changeTime(settingsTime.value);
  }

  void turnOnOff() {
    notificationService.changeState();
  }

  // general notifications
  Future<void> getNotifications() async {
    notifications.value = await notificationService.getNotifications();
  }

  Future<void> checkNewNotifications() async {
    newNotifications.value = await notificationService.checkNewNotification();
  }

  Future<void> deleteNotifications() async {
    await notificationService.deleteNotifications();

    getNotifications();
  }

  Future<void> openNotifications() async {
    await notificationService.openNotifications();
  }

  // send general notifications
  Future<void> sendNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    final firstTime = prefs.getInt('first_time') ?? 0;

    // daily reminder
    if (firstTime == 0) {
      notificationService.sendNewNotification(
        1,
        "Let's Stay Consistent! 🌟",
        "Turn on daily reminders in settings to stay aligned with your study goals.",
      );
    }

    // system update

    // subscription
  }
}
