import 'package:edgiprep/utils/device_utils.dart';
import 'package:edgiprep/views/components/general/normal_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:google_fonts/google_fonts.dart';

Widget lessonCorrect(String explanation) {
  return LayoutBuilder(
    builder: (context, constraints) {
      bool isTablet = DeviceUtils.isTablet(context);
      bool isSmallTablet = DeviceUtils.isSmallTablet(context);

      double titleFontSize = isTablet
          ? 46.sp
          : isSmallTablet
              ? 48.sp
              : 50.sp;
      double subtitleFontSize = isTablet
          ? 18.sp
          : isSmallTablet
              ? 20.sp
              : 22.sp;

      double answerTitleSize = isTablet
          ? 16.sp
          : isSmallTablet
              ? 18.sp
              : 20.sp;

      double explanationSize = isTablet
          ? 18.sp
          : isSmallTablet
              ? 20.sp
              : 22.sp;

      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.h),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30.r),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
              color: const Color.fromRGBO(195, 241, 205, 1),
              padding: EdgeInsets.symmetric(
                horizontal: 50.w,
                vertical: 50.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 30.h,
                  ),
                  // icon
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30.r),
                        child: SvgPicture.asset(
                          'icons/happy.svg',
                          height: 130.r,
                          width: 130.r,
                        ),
                      ),
                    ],
                  ),

                  // title
                  SizedBox(
                    height: 30.h,
                  ),
                  Text(
                    "Great Work",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.w800,
                      color: const Color.fromRGBO(102, 203, 124, 1),
                    ),
                  ),

                  // subtitle
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 80.w),
                    child: Text(
                      "Correct answer! You've earned 1 XP. Keep it up!",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontSize: subtitleFontSize,
                        fontWeight: FontWeight.w600,
                        color: const Color.fromRGBO(92, 101, 120, 1),
                      ),
                    ),
                  ),

                  // Explanation
                  if (explanation.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          height: 30.h,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(30.r),
                          child: Container(
                            color: Colors.white,
                            padding: EdgeInsets.symmetric(
                              vertical: 40.h,
                              horizontal: 40.w,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  "Explanation",
                                  style: GoogleFonts.inter(
                                    fontSize: answerTitleSize,
                                    fontWeight: FontWeight.w700,
                                    color:
                                        const Color.fromRGBO(102, 203, 124, 1),
                                  ),
                                ),
                                SizedBox(
                                  height: 8.h,
                                ),
                                if (explanation.isNotEmpty)
                                  HtmlWidget(
                                    explanation,
                                    textStyle: GoogleFonts.inter(
                                      fontSize: explanationSize,
                                      fontWeight: FontWeight.w500,
                                      color:
                                          const Color.fromRGBO(17, 25, 37, 1),
                                    ),
                                    customWidgetBuilder: (element) {
                                      if (element.localName == "span" &&
                                          element.classes
                                              .contains("ql-formula")) {
                                        String? latexExpression =
                                            element.attributes["data-value"];

                                        if (latexExpression != null) {
                                          return Math.tex(
                                            latexExpression,
                                            textStyle: GoogleFonts.inter(
                                              fontSize: explanationSize,
                                              fontWeight: FontWeight.w500,
                                              color: const Color.fromRGBO(
                                                  17, 25, 37, 1),
                                            ),
                                          );
                                        }
                                      }
                                      return null;
                                    },
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                  // button
                  SizedBox(
                    height: 40.h,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: normalButton(
                      const Color.fromRGBO(102, 203, 124, 1),
                      Colors.white,
                      "Continue",
                      100,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
