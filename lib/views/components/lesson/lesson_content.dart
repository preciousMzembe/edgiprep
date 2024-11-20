import 'package:edgiprep/models/lesson/slide_content_model.dart';
import 'package:edgiprep/models/lesson/slide_media_model.dart';
import 'package:edgiprep/utils/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

Widget lessonContent(SlideContentModel? slideContent) {
  return LayoutBuilder(
    builder: (context, constraints) {
      bool isTablet = DeviceUtils.isTablet(context);
      bool isSmallTablet = DeviceUtils.isSmallTablet(context);

      double titleFont = isTablet
          ? 16.sp
          : isSmallTablet
              ? 18.sp
              : 20.sp;

      double headingFont = isTablet
          ? 34.sp
          : isSmallTablet
              ? 36.sp
              : 38.sp;

      double contentFont = isTablet
          ? 18.sp
          : isSmallTablet
              ? 20.sp
              : 22.sp;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // title
          Text(
            "Content",
            style: GoogleFonts.inter(
              fontSize: titleFont,
              fontWeight: FontWeight.w700,
              color: const Color.fromRGBO(35, 131, 226, 1),
            ),
          ),

          // question
          SizedBox(
            height: 15.h,
          ),
          Text(
            slideContent!.title,
            style: GoogleFonts.inter(
              fontSize: headingFont,
              fontWeight: FontWeight.w700,
              color: const Color.fromRGBO(52, 74, 106, 1),
            ),
          ),

          // content
          if (slideContent.text != null && slideContent.text?.trim() != "")
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 30.h,
                ),
                Text(
                  slideContent.text ?? "",
                  style: GoogleFonts.inter(
                    fontSize: contentFont,
                    fontWeight: FontWeight.w400,
                    color: const Color.fromRGBO(17, 25, 37, 1),
                  ),
                ),
              ],
            ),

          // image
          if (slideContent.slideMedia != null &&
              slideContent.slideMedia?.mediaType == MediaType.image)
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 50.h,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.r),
                  child: Image.asset(
                    "images/biology_lesson.jpg",
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),

          // question
          SizedBox(
            height: 50.h,
          ),
        ],
      );
    },
  );
}
