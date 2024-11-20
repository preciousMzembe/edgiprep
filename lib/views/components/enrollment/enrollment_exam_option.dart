import 'package:edgiprep/views/components/enrollment/enrollment_option_selected_mark.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:edgiprep/utils/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

Widget enrollmentExamOption(BuildContext context, bool selected, String name) {
  return LayoutBuilder(
    builder: (context, constraints) {
      bool isTablet = DeviceUtils.isTablet(context);
      bool isSmallTablet = DeviceUtils.isSmallTablet(context);

      double fontSize = isTablet
          ? 26.sp
          : isSmallTablet
              ? 28.sp
              : 34.sp;

      return Container(
        width: (MediaQuery.of(context).size.width - 220.w) / 2,
        padding: EdgeInsets.all(20.r),
        decoration: BoxDecoration(
          color: selected ? selectedExamColor : Colors.white,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Padding(
          padding: EdgeInsets.all(10.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // mark
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  enrollmentOptionSelectedMark(Colors.white),
                ],
              ),
              Expanded(
                child: SizedBox(
                  height: 100.h,
                ),
              ),
              Text(
                name,
                style: GoogleFonts.inter(
                  fontSize: fontSize,
                  fontWeight: FontWeight.w700,
                  color: selected ? Colors.white : unselectedExamColor,
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
