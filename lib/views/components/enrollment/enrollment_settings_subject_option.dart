import 'package:edgiprep/views/components/enrollment/enrollment_option_selected_mark.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:edgiprep/utils/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

Widget enrollmentSettingsSubjectOption(
  bool selected,
  String name,
  String icon,
) {
  return LayoutBuilder(
    builder: (context, constraints) {
      bool isTablet = DeviceUtils.isTablet(context);
      bool isSmallTablet = DeviceUtils.isSmallTablet(context);

      double fontSize = isTablet
          ? 22.sp
          : isSmallTablet
              ? 22.sp
              : 26.sp;

      double iconSize = isTablet
          ? 30.r
          : isSmallTablet
              ? 35.r
              : 40.r;

      double padding = isTablet
          ? 12.r
          : isSmallTablet
              ? 14.r
              : 20.r;

      return Container(
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
          color:
              selected ? Colors.white : const Color.fromRGBO(244, 245, 249, 1),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
              width: 2.r,
              color: selected
                  ? const Color.fromRGBO(73, 161, 249, 1)
                  : Colors.transparent),
        ),
        child: Padding(
          padding: EdgeInsets.all(10.r),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'icons/$icon',
                    height: iconSize,
                    width: iconSize,
                    colorFilter: ColorFilter.mode(
                        selected
                            ? const Color.fromRGBO(73, 161, 249, 1)
                            : const Color.fromRGBO(191, 198, 216, 1),
                        BlendMode.srcIn),
                  ),
                  SizedBox(
                    width: 30.w,
                  ),
                  Text(
                    name,
                    style: GoogleFonts.inter(
                      fontSize: fontSize,
                      fontWeight: FontWeight.w700,
                      color: selected
                          ? const Color.fromRGBO(73, 161, 249, 1)
                          : unselectedExamColor,
                    ),
                  ),
                ],
              ),

              // mark
              enrollmentOptionSelectedMark(
                selected
                    ? const Color.fromRGBO(73, 161, 249, 1)
                    : Colors.transparent,
              ),
            ],
          ),
        ),
      );
    },
  );
}
