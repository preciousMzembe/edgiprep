import 'package:edgiprep/utils/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

Widget enrollmentSettingsExamOption(String name) {
  return LayoutBuilder(
    builder: (context, constraints) {
      bool isTablet = DeviceUtils.isTablet(context);
      bool isSmallTablet = DeviceUtils.isSmallTablet(context);

      double nameSize = isTablet
          ? 22.sp
          : isSmallTablet
              ? 24.sp
              : 26.sp;

      return ClipRRect(
        borderRadius: BorderRadius.circular(20.r),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 40.w,
            vertical: 30.h,
          ),
          color: Colors.white,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  name,
                  style: GoogleFonts.inter(
                    fontSize: nameSize,
                    fontWeight: FontWeight.w700,
                    color: const Color.fromRGBO(92, 101, 120, 1),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
