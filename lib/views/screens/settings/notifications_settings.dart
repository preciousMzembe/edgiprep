import 'package:edgiprep/utils/constants.dart';
import 'package:edgiprep/views/components/notifications/notification_settings_box.dart';
import 'package:edgiprep/views/components/settings/settings_back_button.dart';
import 'package:edgiprep/views/components/settings/settings_icon.dart';
import 'package:edgiprep/views/components/settings/settings_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class NotificationsSettings extends StatefulWidget {
  const NotificationsSettings({super.key});

  @override
  State<NotificationsSettings> createState() => _NotificationsSettingsState();
}

class _NotificationsSettingsState extends State<NotificationsSettings> {
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
                      settingsTitle("Reminder Settings")
                    ],
                  ),
                  settingsIcon(FontAwesomeIcons.bell),
                ],
              ),

              SizedBox(
                height: 50.h,
              ),

              // reminder
              notificationSettingsBox(
                  "Daily Reminder", "Turn on / off daily reminder", "switch"),

              // time
              SizedBox(
                height: 30.h,
              ),
              notificationSettingsBox("Time", "Set when to remind you", "time"),

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
