import 'package:edgiprep/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

void showSnackbar(
    BuildContext context, String title, String message, bool error) {
  final snackBar = SnackBar(
    content: Row(
      children: [
        // left box
        Container(
          height: 90.h,
          width: 90.h,
          color: error
              ? const Color.fromRGBO(232, 110, 99, 1)
              : const Color.fromRGBO(102, 203, 124, 1),
          child: Center(
            child: Container(
              height: 40.h,
              width: 40.h,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1.r,
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.circular(50.r),
              ),
              child: Center(
                // icon
                child: Icon(
                  error ? FontAwesomeIcons.xmark : FontAwesomeIcons.check,
                  size: 10,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 30.w,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // title
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),

                SizedBox(
                  height: 2.h,
                ),

                // message
                Text(
                  message,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color.fromRGBO(115, 115, 115, 1),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
    backgroundColor: Colors.white,
    padding: EdgeInsets.all(0),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    duration: const Duration(seconds: 2),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
