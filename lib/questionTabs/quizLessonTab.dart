import 'package:edgiprep/questionTabs/answer.dart';
import 'package:edgiprep/questionTabs/retry_prompt.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';

class QuizLessonTab extends StatefulWidget {
  const QuizLessonTab({super.key});

  @override
  State<QuizLessonTab> createState() => _QuizLessonTabState();
}

class _QuizLessonTabState extends State<QuizLessonTab> {
  List answers = [
    "Glucose (C₆H₁₂O₆)",
    "Carbon dioxide (CO₂)",
    "Water (H₂O)",
    "Adenosine triphosphate (ATP)",
  ];

  int _selected = -1;

  void _changeSelected(int index) {
    setState(() {
      _selected = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 30.h,
            ),
            // top
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // close
                      IconButton(
                        onPressed: () {
                          // show popup before closing
                          Get.back();
                          Get.back();
                        },
                        icon: Icon(
                          FontAwesomeIcons.xmark,
                          size: 40.h,
                        ),
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      Expanded(
                        child: Text(
                          "Nonflowering Plants",
                          // textAlign: TextAlign.center,
                          style: GoogleFonts.nunito(
                            fontSize: 35.sp,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      // report question
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          FontAwesomeIcons.solidFlag,
                          size: 30.h,
                        ),
                      ),
                    ],
                  ),
                  // progress
                  SizedBox(
                    height: 20.h,
                  ),
                  LinearPercentIndicator(
                    padding: const EdgeInsets.all(0),
                    animation: true,
                    lineHeight: 15.h,
                    animationDuration: 2000,
                    // percent
                    percent: .5,
                    barRadius: Radius.circular(30.r),
                    progressColor: primaryColor,
                    backgroundColor: progressColor,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  RichText(
                    text: TextSpan(
                      style: GoogleFonts.nunito(
                        color: Colors.black,
                        fontSize: 25.sp,
                        fontWeight: FontWeight.w900,
                      ),
                      children: [
                        TextSpan(
                          text: "10",
                          style: TextStyle(color: primaryColor),
                        ),
                        TextSpan(
                          text: "/20",
                          style: TextStyle(color: textColor),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // question and answers
            SizedBox(
              height: 10.h,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: ListView(
                  children: [
                    SizedBox(
                      height: 30.h,
                    ),
                    // question
                    Text(
                      "During photosynthesis, plants capture energy from sunlight and convert it into usable energy. Which of the following molecules is the PRIMARY product of the light-dependent reactions in photosynthesis?",
                      style: GoogleFonts.nunito(
                        fontSize: 35.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    // answers
                    SizedBox(
                      height: 80.h,
                    ),
                    for (int i = 0; i < answers.length; i++)
                      Column(
                        children: [
                          Answer(
                            answer: answers[i],
                            selected: _selected == i,
                            select: () {
                              _changeSelected(i);
                            },
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                        ],
                      ),

                    // bottom
                    SizedBox(
                      height: 100.h,
                    ),
                  ],
                ),
              ),
            ),

            // check and continue
            Visibility(
              visible: true,
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(
                  vertical: 40.h,
                  horizontal: 30.h,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // status
                    Row(
                      children: [
                        Container(
                          width: 50.h,
                          height: 50.h,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(50.r),
                          ),
                          child: Icon(
                            FontAwesomeIcons.xmark,
                            size: 25.h,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: 15.w,
                        ),
                        Text(
                          "Wrong",
                          style: GoogleFonts.nunito(
                            fontSize: 40.sp,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    // answer
                    Row(
                      children: [
                        Text(
                          "Answer: ",
                          style: GoogleFonts.nunito(
                            fontSize: 35.sp,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "Adenosine triphosphate (ATP)",
                            style: GoogleFonts.nunito(
                              fontSize: 30.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    // check
                    MaterialButton(
                      color: secondaryColor,
                      height: 100.h,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100.r),
                      ),
                      onPressed: () {
                        Get.to(() => const RetryPrompt());
                      },
                      child: Text(
                        "Continue",
                        style: GoogleFonts.nunito(
                          color: primaryColor,
                          fontSize: 40.sp,
                          fontWeight: FontWeight.w600,
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
    );
  }
}
