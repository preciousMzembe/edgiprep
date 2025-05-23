import 'package:edgiprep/views/components/enrollment/enrollment_option_selected_mark.dart';
import 'package:edgiprep/views/components/premium/premium_fade_text.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:edgiprep/utils/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

Widget premiumPriceOption(String price) {
  return LayoutBuilder(
    builder: (context, constraints) {
      bool isTablet = DeviceUtils.isTablet(context);
      bool isSmallTablet = DeviceUtils.isSmallTablet(context);

      double fontSize = isTablet
          ? 24.sp
          : isSmallTablet
              ? 26.sp
              : 28.sp;

      double verticalPadding = isTablet
          ? 16.r
          : isSmallTablet
              ? 18.r
              : 20.r;

      double horizontalPadding = isTablet
          ? 34.r
          : isSmallTablet
              ? 32.r
              : 30.r;

      return Container(
        padding: EdgeInsets.symmetric(
          vertical: verticalPadding,
          horizontal: horizontalPadding,
        ),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22.r),
            border: Border.all(
              width: 2.r,
              color: selectedExamColor,
            )),
        child: Padding(
          padding: EdgeInsets.all(15.r),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "MK $price Annually",
                      style: GoogleFonts.inter(
                        fontSize: fontSize,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    premiumFadeText(
                        "Go to premium with only MK $price per year"),
                  ],
                ),
              ),

              // mark
              SizedBox(
                width: 30.w,
              ),
              enrollmentOptionSelectedMark(selectedExamColor),
            ],
          ),
        ),
      );
    },
  );
}
