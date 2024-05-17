import 'package:edgiprep/screens/subject.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class Learn extends StatefulWidget {
  const Learn({super.key});

  @override
  State<Learn> createState() => _LearnState();
}

class _LearnState extends State<Learn> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: 30.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Your Academic Journey",
                style: GoogleFonts.nunito(
                  fontSize: 50.sp,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(
                "Discover your academic potential and growth.",
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
          height: 35.h,
        ),
        // search
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: TextField(
            cursorColor: primaryColor,
            decoration: InputDecoration(
              prefixIcon: Padding(
                padding: EdgeInsets.only(
                  left: 50.w,
                  right: 30.w,
                ),
                child: const Icon(
                  FontAwesomeIcons.magnifyingGlass,
                  color: Color.fromARGB(255, 139, 139, 139),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(90.0),
                borderSide: BorderSide(
                  color: primaryColor,
                  // color: Color.fromARGB(255, 139, 139, 139),
                  width: 2.0,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(90.0),
                borderSide: BorderSide(
                  color: primaryColor,
                  // color: Color.fromARGB(255, 139, 139, 139),
                  width: 2.0,
                ),
              ),
              hintText: 'Search',
            ),
          ),
        ),
        SizedBox(
          height: 10.h,
        ),

        // subjects
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 30.w,
            ),
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                SizedBox(
                  height: 30.h,
                ),
                const LearnSubject(
                  subject: "Biology",
                  percent: .6,
                ),
                SizedBox(
                  height: 20.h,
                ),
                const LearnSubject(
                  subject: "History",
                  percent: .3,
                ),
                SizedBox(
                  height: 20.h,
                ),
                const LearnSubject(
                  subject: "Social Studies",
                  percent: .5,
                ),
                SizedBox(
                  height: 100.h,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class LearnSubject extends StatefulWidget {
  final String subject;
  final double percent;
  const LearnSubject({super.key, required this.subject, required this.percent});

  @override
  State<LearnSubject> createState() => _LearnSubjectState();
}

class _LearnSubjectState extends State<LearnSubject> {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //  subject
                    Text(
                      widget.subject,
                      style: GoogleFonts.nunito(
                        fontSize: 35.sp,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              MaterialButton(
                color: secondaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(700.r),
                ),
                height: 70.h,
                onPressed: () {
                  Get.to(() => const Subject());
                },
                child: Center(
                  child: Text(
                    "Continue",
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
          SizedBox(
            height: 30.h,
          ),
          LinearPercentIndicator(
            padding: const EdgeInsets.all(0),
            animation: true,
            lineHeight: 25.h,
            animationDuration: 2000,
            // percent
            percent: widget.percent,
            barRadius: Radius.circular(30.r),
            progressColor: primaryColor,
            backgroundColor: progressColor,
          ),
        ],
      ),
    );
  }
}
