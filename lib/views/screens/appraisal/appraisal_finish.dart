import 'package:edgiprep/controllers/challenge/challenge_controller.dart';
import 'package:edgiprep/controllers/mock/mock_controller.dart';
import 'package:edgiprep/controllers/past%20paper/paper_controller.dart';
import 'package:edgiprep/controllers/quiz/quiz_controller.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:edgiprep/utils/device_utils.dart';
import 'package:edgiprep/views/components/general/normal_button.dart';
import 'package:edgiprep/views/components/lesson/lesson_back_button.dart';
import 'package:edgiprep/views/components/lesson/lesson_completed_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AppraisalFinish extends StatelessWidget {
  final String type;
  const AppraisalFinish({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    QuizController quizController = Get.find<QuizController>();
    PaperController paperController = Get.find<PaperController>();
    MockController mockController = Get.find<MockController>();
    ChallengeController challengeController = Get.find<ChallengeController>();

    String title = "";
    int questions = 0;
    double scores = 80;
    String status = "Good";
    int xps = 0;

    return LayoutBuilder(
      builder: (context, constraints) {
        bool isTablet = DeviceUtils.isTablet(context);
        bool isSmallTablet = DeviceUtils.isSmallTablet(context);

        double titleSize = isTablet
            ? 36.sp
            : isSmallTablet
                ? 38.sp
                : 40.sp;

        double subtitleSize = isTablet
            ? 18.sp
            : isSmallTablet
                ? 20.sp
                : 22.sp;

        double afterTextSize = isTablet
            ? 16.sp
            : isSmallTablet
                ? 18.sp
                : 20.sp;

        if (type == "quiz") {
          questions = quizController.getNumberOfQuestions();
          scores = 80;
          status = "Good";
          xps = quizController.getCorrectAnswers();
          title = "Quiz";
        } else if (type == "paper") {
          questions = paperController.getNumberOfQuestions();
          scores = 80;
          status = "Good";
          xps = paperController.getCorrectAnswers();
          title = "Paper";
        } else if (type == "mock") {
          questions = mockController.getNumberOfQuestions();
          scores = 80;
          status = "Good";
          xps = mockController.getCorrectAnswers();
          title = "Exam";
        } else if (type == "challenge") {
          questions = challengeController.getNumberOfQuestions();
          scores = 80;
          status = "Good";
          xps = challengeController.getCorrectAnswers();
          title = "Challenge";
        }

        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (bool didPop, other) async {
            if (didPop) {
              return;
            }
            Get.back();
            Get.back();
          },
          child: Scaffold(
            backgroundColor: primaryColor,
            body: SafeArea(
              child: Stack(
                children: [
                  // background
                  Container(
                    color: backgroundColor,
                  ),
                  Container(
                    height: 550.h,
                    color: primaryColor,
                  ),

                  // body
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: ListView(
                            children: [
                              // back
                              SizedBox(
                                height: 30.h,
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Get.back();
                                      Get.back();
                                    },
                                    child: lessonBackButton(),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 50.h,
                              ),
                              // title
                              Text(
                                "$title Completed",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inter(
                                  fontSize: titleSize,
                                  fontWeight: FontWeight.w700,
                                  color: const Color.fromRGBO(255, 255, 255, 1),
                                ),
                              ),

                              // subtitle
                              SizedBox(
                                height: 10.h,
                              ),
                              Text(
                                "Great Job, You've Completed the title! Here's a summary of your performance.",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inter(
                                  fontSize: subtitleSize,
                                  fontWeight: FontWeight.w400,
                                  color: const Color.fromRGBO(252, 255, 255, 1),
                                ),
                              ),

                              // details
                              SizedBox(
                                height: 50.h,
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20.r),
                                child: Container(
                                  color: Colors.white,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 50.w,
                                    vertical: 40.h,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      // image
                                      Image.asset("images/lesson_completed.png",
                                          fit: BoxFit.contain),

                                      // details
                                      SizedBox(
                                        height: 40.h,
                                      ),
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      lessonCompletedDetail(
                                        "Total Questions",
                                        "$questions Questions",
                                        true,
                                      ),
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      lessonCompletedDetail(
                                        "Scores",
                                        "$scores %",
                                        true,
                                      ),
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      lessonCompletedDetail(
                                        "Achievent Status",
                                        status,
                                        true,
                                      ),
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      lessonCompletedDetail(
                                        "Xps Earned",
                                        "$xps XPs",
                                        false,
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              // after text
                              SizedBox(
                                height: 30.h,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 50.w),
                                child: Text(
                                  "Keep up the good work! You're one step closer to mastering the subject.",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.inter(
                                    fontSize: afterTextSize,
                                    fontWeight: FontWeight.w400,
                                    color:
                                        const Color.fromRGBO(92, 101, 120, 1),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 100.h,
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.back();
                            Get.back();
                          },
                          child: normalButton(
                            primaryColor,
                            Colors.white,
                            "Continue to Next $title",
                            20,
                          ),
                        ),
                        SizedBox(
                          height: 30.h,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
