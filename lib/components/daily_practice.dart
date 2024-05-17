import 'package:edgiprep/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class DailyPractice extends StatefulWidget {
  const DailyPractice({super.key});

  @override
  State<DailyPractice> createState() => _DailyPracticeState();
}

class _DailyPracticeState extends State<DailyPractice> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "Daily Practice",
          style: GoogleFonts.nunito(
            fontSize: 40.sp,
            fontWeight: FontWeight.w900,
            color: Colors.black,
          ),
        ),
        SizedBox(
          height: 5.h,
        ),
        Text(
          "Take 5 minutes test to build learning habit.",
          style: TextStyle(
            fontSize: 25.sp,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),

        // tests
        SizedBox(
          height: 40.h,
        ),
        const DailyTest(),
      ],
    );
  }
}

class DailyTest extends StatelessWidget {
  const DailyTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 40.h,
        vertical: 40.h,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40.r),
        // border: Border.all(
        //   color: grayColor,
        //   width: 2.w,
        // ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Biology",
                  style: GoogleFonts.nunito(
                    fontSize: 35.sp,
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  "Nonflowering plants",
                  style: TextStyle(
                    fontSize: 25.sp,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 20.w,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MaterialButton(
                color: secondaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(700.r),
                ),
                height: 70.h,
                onPressed: () {},
                child: Center(
                  child: Text(
                    "Start",
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 25.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
