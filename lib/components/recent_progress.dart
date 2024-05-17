import 'package:edgiprep/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';

class RecentProgress extends StatefulWidget {
  const RecentProgress({super.key});

  @override
  State<RecentProgress> createState() => _RecentProgressState();
}

class _RecentProgressState extends State<RecentProgress> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "Recent Progress",
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
          "Your recent performance history.",
          style: TextStyle(
            fontSize: 25.sp,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),

        // tests
        SizedBox(
          height: 30.h,
        ),
        const DailyTest(
          subject: "Biology",
          topic: "Parts of nonflowering plants",
          percent: .7,
        ),
        SizedBox(
          height: 20.h,
        ),
        const DailyTest(
          subject: "History",
          topic: "Mwenemutapa kingdom",
          percent: .91,
        ),
      ],
    );
  }
}

class DailyTest extends StatelessWidget {
  final String subject;
  final String topic;
  final double percent;
  const DailyTest(
      {super.key,
      required this.subject,
      required this.topic,
      required this.percent});

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
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // subject
                    Text(
                      subject,
                      style: GoogleFonts.nunito(
                        fontSize: 35.sp,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    // topic
                    Text(
                      topic,
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
