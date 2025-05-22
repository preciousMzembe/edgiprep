import 'package:cached_network_svg_image/cached_network_svg_image.dart';
import 'package:edgiprep/utils/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

Widget searchResult(
    Color background, String icon, String subject, String topic) {
  return LayoutBuilder(
    builder: (context, constraints) {
      bool isTablet = DeviceUtils.isTablet(context);
      bool isSmallTablet = DeviceUtils.isSmallTablet(context);

      double nameSize = isTablet
          ? 24.sp
          : isSmallTablet
              ? 26.sp
              : 28.sp;

      double textSize = isTablet
          ? 18.sp
          : isSmallTablet
              ? 20.sp
              : 22.sp;

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
                Column(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.r),
                        child: Container(
                          padding: EdgeInsets.all(40.r),
                          color: background,
                          child: CachedNetworkSVGImage(
                            icon,
                            height: 40.h,
                            width: 40.h,
                            colorFilter:
                                ColorFilter.mode(Colors.white, BlendMode.srcIn),
                            errorWidget: SvgPicture.asset(
                              "icons/subject.svg",
                              height: 40.h,
                              width: 40.h,
                              colorFilter: ColorFilter.mode(
                                  Colors.white, BlendMode.srcIn),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                // details
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 30.w,
                      vertical: 15.h,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // name
                              Text(
                                subject,
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
                                topic,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.inter(
                                  fontSize: textSize,
                                  fontWeight: FontWeight.w500,
                                  color:
                                      const Color.fromARGB(255, 105, 112, 126),
                                ),
                              ),

                              const Expanded(
                                child: SizedBox(),
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
