import 'package:edgiprep/utils/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:google_fonts/google_fonts.dart';

Widget lessonQuestionResponse(String text, bool selected, {String image = ""}) {
  return LayoutBuilder(
    builder: (context, constraints) {
      bool isTablet = DeviceUtils.isTablet(context);
      bool isSmallTablet = DeviceUtils.isSmallTablet(context);
      double fontSize = isTablet
          ? 24.sp
          : isSmallTablet
              ? 26.sp
              : 28.sp;

      double height = isTablet
          ? 36.r
          : isSmallTablet
              ? 38.r
              : 40.r;

      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // icon
          Column(
            children: [
              SizedBox(
                height: 25.h,
              ),
              Container(
                width: height,
                height: height,
                decoration: BoxDecoration(
                  color: selected
                      ? const Color.fromRGBO(73, 161, 249, 1)
                      : const Color.fromRGBO(214, 220, 233, 1),
                  borderRadius: BorderRadius.circular(40.r),
                ),
              ),
            ],
          ),
          SizedBox(
            width: 25.w,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 25.h, horizontal: 35.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(
                  width: 4.r,
                  color: selected
                      ? const Color.fromRGBO(73, 161, 249, 1)
                      : Colors.white,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text
                  if (text != "")
                    HtmlWidget(
                      text,
                      textStyle: GoogleFonts.inter(
                        fontSize: fontSize,
                        fontWeight: FontWeight.w700,
                        color: selected
                            ? const Color.fromRGBO(73, 161, 249, 1)
                            : const Color.fromRGBO(92, 101, 120, 1),
                      ),
                      customWidgetBuilder: (element) {
                        if (element.localName == "span" &&
                            element.classes.contains("ql-formula")) {
                          String? latexExpression =
                              element.attributes["data-value"];

                          if (latexExpression != null) {
                            return Math.tex(
                              latexExpression,
                              textStyle: GoogleFonts.inter(
                                fontSize: fontSize,
                                fontWeight: FontWeight.w700,
                                color: selected
                                    ? const Color.fromRGBO(73, 161, 249, 1)
                                    : const Color.fromRGBO(92, 101, 120, 1),
                              ),
                            );
                          }
                        }
                        return null;
                      },
                    ),

                  // Image
                  if (image != "")
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (text != "")
                          SizedBox(
                            height: 20.h,
                          ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20.r),
                          child: Image.network(
                            image,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ],
      );
    },
  );
}
