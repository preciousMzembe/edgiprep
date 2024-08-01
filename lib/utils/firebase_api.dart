import 'package:edgiprep/controllers/user_controller.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

class FirebaseApi {
  UserController userController = Get.find<UserController>();
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final fcmToken = await _firebaseMessaging.getToken();

    userController.changeDeviceId(fcmToken!);
  }
}
