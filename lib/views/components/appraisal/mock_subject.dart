import 'package:cached_network_svg_image/cached_network_svg_image.dart';
import 'package:edgiprep/utils/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

Widget mockSubject(Color background, String icon, String name, int mocks) {
  return LayoutBuilder(
    builder: (context, constraints) {
      bool isTablet = DeviceUtils.isTablet(context);
      bool isSmallTablet = DeviceUtils.isSmallTablet(context);

      double nameSize = isTablet
          ? 28.sp
          : isSmallTablet
              ? 30.sp
              : 32.sp;

      double textSize = isTablet
          ? 16.sp
          : isSmallTablet
              ? 18.sp
              : 20.sp;

      double questionsSize = isTablet
          ? 14.sp
          : isSmallTablet
              ? 16.sp
              : 18.sp;

      // button
      double containerSize = isTablet
          ? 44.h
          : isSmallTablet
              ? 46.h
              : 48.h;
      double iconSize = isTablet
          ? 22.h
          : isSmallTablet
              ? 24.h
              : 26.h;

      return ClipRRect(
        borderRadius: BorderRadius.circular(20.r),
        child: Container(
          color: Colors.white,
          child: IntrinsicHeight(
            child: Row(
              children: [
                // image
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.r),
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(60.r),
                          color: background,
                          child: CachedNetworkSVGImage(
                            icon,
                            height: 60.h,
                            width: 60.h,
                            colorFilter:
                                ColorFilter.mode(Colors.white, BlendMode.srcIn),
                            errorWidget: SvgPicture.asset(
                              "icons/subject.svg",
                              height: 60.h,
                              width: 60.h,
                              colorFilter: ColorFilter.mode(
                                  Colors.white, BlendMode.srcIn),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // details
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 30.w,
                      vertical: 15.h,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // name
                              Text(
                                name,
                                style: GoogleFonts.inter(
                                  fontSize: nameSize,
                                  fontWeight: FontWeight.w800,
                                  color: const Color.fromRGBO(52, 74, 106, 1),
                                ),
                              ),

                              // text
                              SizedBox(
                                height: 4.h,
                              ),
                              Text(
                                "Dive into $name exam",
                                style: GoogleFonts.inter(
                                  fontSize: textSize,
                                  fontWeight: FontWeight.w500,
                                  color: const Color.fromRGBO(161, 168, 183, 1),
                                ),
                              ),

                              const Expanded(
                                child: SizedBox(),
                              ),

                              // questions
                              Text(
                                "$mocks Mock${mocks != 1 ? 's' : ''}",
                                style: GoogleFonts.inter(
                                  fontSize: questionsSize,
                                  fontWeight: FontWeight.w700,
                                  color: const Color.fromRGBO(35, 131, 226, 1),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // button
                        SizedBox(
                          width: 30.w,
                        ),
                        Container(
                          width: containerSize,
                          height: containerSize,
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(247, 248, 251, 1),
                            border: Border.all(
                              width: 1.0,
                              color: const Color.fromRGBO(234, 237, 244, 1),
                            ),
                            borderRadius: BorderRadius.circular(60.r),
                          ),
                          child: Center(
                            child: Icon(
                              FontAwesomeIcons.angleRight,
                              size: iconSize,
                              color: const Color.fromRGBO(191, 198, 216, 1),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
