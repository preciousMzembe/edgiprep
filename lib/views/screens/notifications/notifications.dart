import 'package:edgiprep/controllers/notification/notification_controller.dart';
import 'package:edgiprep/db/notification/notification.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:edgiprep/views/components/notifications/notification_box.dart';
import 'package:edgiprep/views/components/notifications/notifications_day.dart';
import 'package:edgiprep/views/components/notifications/notifications_delete_icon.dart';
import 'package:edgiprep/views/components/notifications/notifications_empty.dart';
import 'package:edgiprep/views/components/settings/settings_back_button.dart';
import 'package:edgiprep/views/components/settings/settings_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  NotificationController notificationController =
      Get.find<NotificationController>();

  Map<String, List<UserNotification>> notifications = {};
  String date = "";

  // Groups notifications by their date (ignoring time)
  Map<String, List<UserNotification>> groupByDate(
      List<UserNotification> notifications) {
    final Map<String, List<UserNotification>> grouped = {};

    for (UserNotification notification in notifications) {
      String date = notification.date;

      if (!grouped.containsKey(date)) {
        grouped[date] = [];
      }

      grouped[date]!.add(notification);
    }

    return grouped;
  }

  @override
  void initState() {
    super.initState();

    setState(() {
      notifications = groupByDate(notificationController.notifications);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appbarColor,
      body: SafeArea(
        child: Obx(() {
          return Container(
            color: backgroundColor,
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: ListView(
              children: [
                SizedBox(
                  height: 30.h,
                ),
                // back and icon
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: settingsBackButton(),
                        ),
                        settingsTitle("Notifications")
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        notificationController.deleteNotifications();
                      },
                      child: notificationsDeleteIcon(FontAwesomeIcons.trashCan),
                    ),
                  ],
                ),

                SizedBox(
                  height: 50.h,
                ),

                // empty
                if (notificationController.notifications.isEmpty)
                  notificationsEmpty(),

                // day and notifications
                if (notificationController.notifications.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ...notifications.entries.map((group) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            notificationsDay(group.key),
                            ...group.value.map((notification) {
                              return notificationBox(
                                notification.title,
                                notification.message,
                                notification.time,
                              );
                            }),
                          ],
                        );
                      }),
                    ],
                  ),

                SizedBox(
                  height: 100.h,
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
