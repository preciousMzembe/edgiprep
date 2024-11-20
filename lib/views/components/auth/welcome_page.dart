import 'package:edgiprep/views/components/auth/welcome_fade_text.dart';
import 'package:edgiprep/views/components/auth/welcome_title_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget welcomePage(String title, String subTitle, String image) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      welcomeTitleText(title),
      SizedBox(height: 30.h),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.w),
        child: welcomeFadeText(
          subTitle,
        ),
      ),
      SizedBox(height: 60.h),
      Expanded(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 30.h),
          child: Image.asset(image, fit: BoxFit.contain),
        ),
      ),
    ],
  );
}
