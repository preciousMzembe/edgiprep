import 'package:edgiprep/controllers/notification/notification_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationSwitch extends StatefulWidget {
  const NotificationSwitch({super.key});

  @override
  State<NotificationSwitch> createState() => _NotificationSwitchState();
}

class _NotificationSwitchState extends State<NotificationSwitch> {
  NotificationController notificationController =
      Get.find<NotificationController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Transform.scale(
        scale: 0.8,
        child: Switch(
          value: notificationController.set.value,
          activeColor: Colors.white,
          activeTrackColor: const Color.fromRGBO(73, 161, 249, 1),
          inactiveThumbColor: Colors.white,
          inactiveTrackColor: const Color.fromRGBO(255, 128, 158, 1),
          trackOutlineColor: const WidgetStatePropertyAll(Colors.transparent),
          onChanged: (value) {
            notificationController.turnOnOff();
          },
        ),
      );
    });
  }
}
