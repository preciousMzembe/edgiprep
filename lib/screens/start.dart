import 'package:edgiprep/questionTabs/quizLessonTab.dart';
import 'package:edgiprep/questionTabs/testTab.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:edgiprep/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Start extends StatelessWidget {
  final TestMode testMode;
  final bool lessonDone;
  const Start({super.key, required this.testMode, this.lessonDone = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 30.w,
            vertical: 20.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // close
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(
                      FontAwesomeIcons.xmark,
                      size: 40.h,
                    ),
                  ),
                ],
              ),
              // body
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // image
                    Container(
                      padding: EdgeInsets.all(50.h),
                      decoration: BoxDecoration(
                        color: progressColor,
                        borderRadius: BorderRadius.circular(500.r),
                      ),
                      child: Image.asset(
                        testMode == TestMode.test
                            ? "icons/start_test.png"
                            : "icons/start_quiz.png",
                        width: 100.w,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Visibility(
                      visible: testMode == TestMode.quiz,
                      child: Text(
                        "Let's See How Much \n You Remember",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.nunito(
                          fontSize: 50.sp,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    Visibility(
                      visible: testMode == TestMode.test,
                      child: Text(
                        "Ready to Test \n Yourself?",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.nunito(
                          fontSize: 50.sp,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    Visibility(
                      visible: testMode == TestMode.lesson,
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: GoogleFonts.nunito(
                            color: Colors.black,
                            fontSize: 50.sp,
                            fontWeight: FontWeight.w900,
                          ),
                          children: [
                            TextSpan(
                              text: lessonDone
                                  ? "Ready to Review On \n"
                                  : "Ready to Practice On \n",
                            ),
                            TextSpan(
                              text: "Nonfloweing Plants",
                              style: TextStyle(color: secondaryColor),
                            ),
                            const TextSpan(
                              text: "?",
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // continue
              MaterialButton(
                color: Colors.white,
                height: 100.h,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100.r),
                ),
                onPressed: () {
                  if (testMode == TestMode.test) {
                    Get.to(() => const TestTab());
                  } else {
                    Get.to(() => const QuizLessonTab());
                  }
                },
                child: Text(
                  "Continue",
                  style: GoogleFonts.nunito(
                    color: primaryColor,
                    fontSize: 40.sp,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
