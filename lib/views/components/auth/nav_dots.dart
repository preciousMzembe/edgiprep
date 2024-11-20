import 'package:edgiprep/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget navDot(bool active) {
  return Container(
    width: 22.h,
    height: 22.h,
    decoration: BoxDecoration(
      color: active ? primaryColor : Colors.transparent,
      border: Border.all(
        width: 2.r,
        color: primaryColor,
      ),
      borderRadius: BorderRadius.circular(24.r),
    ),
  );
}
