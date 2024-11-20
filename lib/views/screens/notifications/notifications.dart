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
  bool empty = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appbarColor,
      body: SafeArea(
        child: Container(
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
                  notificationsDeleteIcon(FontAwesomeIcons.trashCan),
                ],
              ),

              SizedBox(
                height: 50.h,
              ),

              // empty
              if (empty) notificationsEmpty(),

              // day and notifications
              if (!empty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    notificationsDay("Today"),
                    notificationBox(
                      "Daily Reminder",
                      "Take a quick quiz today and track your progress. Every question brings you one step closer to success!",
                      "27 minutes ago",
                    ),
                    notificationBox(
                      "System Update",
                      "We've made some exciting improvements to enhance your learning experience!🎉  Update now and continue prepping smarter! 💡Let's keep moving towards exam success!",
                      "3:00 AM",
                    ),
                    notificationsDay("Yesterday"),
                    notificationBox(
                      "Subscription",
                      "Unlock your full potential with EdgiPrep Premium! 🚀 Upgrade now and take your exam preparation to the next level! 💪\nDon't miss out — success is just a step away! 🏆",
                      "8:30 PM",
                    ),
                  ],
                ),

              SizedBox(
                height: 100.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
