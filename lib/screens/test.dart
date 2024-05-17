import 'package:edgiprep/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
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
                    "Challenge Your Knowledge",
                    style: GoogleFonts.nunito(
                      fontSize: 50.sp,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    "Measure your knowledge with comprehensive tests.",
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
            SizedBox(
              height: 400.h,
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    width: 400.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40.r),
                    ),
                    margin: EdgeInsets.only(
                      right: 20.w,
                      left: index == 0 ? 30.w : 0.w,
                    ),
                    padding: EdgeInsets.all(30.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                index == 0
                                    ? "Mock Test"
                                    : index == 1
                                        ? "Past Papers"
                                        : "Challenge",
                                style: GoogleFonts.nunito(
                                  fontSize: 40.sp,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Expanded(
                                child: Text(
                                  "A mock exam, also known as a practice or trial examination, serves as a simulated test designed to mimic the format, structure, and conditions of a real exam.",
                                  // maxLines: 4,
                                  // overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 25.sp,
                                    fontWeight: FontWeight.bold,
                                    color: textColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
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
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    width: 15.w,
                  );
                },
              ),
            ),

            // results
            SizedBox(
              height: 40.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: Text(
                "Results From Tests",
                style: GoogleFonts.nunito(
                  fontSize: 40.sp,
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                ),
              ),
            ),
            // results
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: Column(
                children: [
                  SizedBox(
                    height: 30.h,
                  ),
                  const TestResult(
                    subject: 'Biology Mock',
                    percent: .6,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  const TestResult(
                    subject: 'Biology 2023',
                    percent: .5,
                  ),
                  SizedBox(
                    height: 100.h,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class TestResult extends StatelessWidget {
  final String subject;
  final double percent;
  const TestResult({super.key, required this.subject, required this.percent});

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
                child: Text(
                  subject,
                  style: GoogleFonts.nunito(
                    fontSize: 35.sp,
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                width: 20.w,
              ),
              Text(
                "${(percent * 100).toStringAsFixed(1)}%",
                style: GoogleFonts.nunito(
                  fontSize: 45.sp,
                  fontWeight: FontWeight.w800,
                  color: Colors.black,
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
            percent: percent,
            barRadius: Radius.circular(30.r),
            progressColor: primaryColor,
            backgroundColor: progressColor,
          ),
        ],
      ),
    );
  }
}
