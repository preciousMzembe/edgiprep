import 'package:cached_network_svg_image/cached_network_svg_image.dart';
import 'package:edgiprep/views/components/enrollment/enrollment_option_selected_mark.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:edgiprep/utils/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

Widget enrollmentSubjectOption(
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
              ? 24.sp
              : 26.sp;

      double iconSize = isTablet
          ? 36.r
          : isSmallTablet
              ? 38.r
              : 40.r;

      double padding = isTablet
          ? 16.r
          : isSmallTablet
              ? 18.r
              : 20.r;

      return Container(
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
          color: selected ? selectedExamColor : Colors.white,
          borderRadius: BorderRadius.circular(16.r),
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
                  CachedNetworkSVGImage(
                    icon,
                    height: iconSize,
                    width: iconSize,
                    colorFilter: ColorFilter.mode(
                        selected
                            ? Colors.white
                            : const Color.fromRGBO(191, 198, 216, 1),
                        BlendMode.srcIn),
                    errorWidget: SvgPicture.asset(
                      "icons/subject.svg",
                      height: iconSize,
                      width: iconSize,
                      colorFilter: ColorFilter.mode(
                          selected
                              ? Colors.white
                              : const Color.fromRGBO(191, 198, 216, 1),
                          BlendMode.srcIn),
                    ),
                  ),
                  SizedBox(
                    width: 30.w,
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

              // mark
              enrollmentOptionSelectedMark(Colors.white),
            ],
          ),
        ),
      );
    },
  );
}
