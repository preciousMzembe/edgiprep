import 'package:edgiprep/controllers/challenge/challenge_controller.dart';
import 'package:edgiprep/controllers/mock/mock_controller.dart';
import 'package:edgiprep/controllers/past_paper/paper_controller.dart';
import 'package:edgiprep/controllers/quiz/quiz_controller.dart';
import 'package:edgiprep/services/stats/stats_service.dart';
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
    StatsService statsService = Get.find<StatsService>();
    QuizController quizController = Get.find<QuizController>();
    PaperController paperController = Get.find<PaperController>();
    MockController mockController = Get.find<MockController>();
    ChallengeController challengeController = Get.find<ChallengeController>();

    String title = "";
    int questions = 0;
    String scores = "0.0";
    String status = "No Questions";
    int xps = 0;

    Map<String, dynamic> getStudentGrade(
        int correctAnswers, int totalQuestions) {
      if (totalQuestions == 0) {
        return {"percentage": "0.0", "grade": "No Questions"};
      }

      double percentage = (correctAnswers / totalQuestions) * 100;
      String grade;

      if (percentage >= 90) {
        grade = "Excellent";
      } else if (percentage >= 75) {
        grade = "Very Good";
      } else if (percentage >= 60) {
        grade = "Good";
      } else if (percentage >= 40) {
        grade = "Average";
      } else if (percentage >= 20) {
        grade = "Poor";
      } else {
        grade = "Very Poor";
      }

      return {"percentage": percentage.toStringAsFixed(1), "grade": grade};
    }

    Map images = {
      "Very Poor": "images/vpoor.png",
      "Poor": "images/poor.png",
      "Average": "images/average.png",
      "Good": "images/good.png",
      "Very Good": "images/vgood.png",
      "Excellent": "images/excellent.png",
    };

    return LayoutBuilder(
      builder: (context, constraints) {
        bool isTablet = DeviceUtils.isTablet(context);
        bool isSmallTablet = DeviceUtils.isSmallTablet(context);

        double imageHeight = isTablet
            ? 36.sp
            : isSmallTablet
                ? 38.sp
                : 230.h;

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
          xps = quizController.getCorrectAnswers();
          title = "Quiz";

          Map grades = getStudentGrade(xps, questions);

          scores = grades['percentage'];
          status = grades['grade'];

          // save quiz score
          quizController.saveQuizScore(xps);
        } else if (type == "paper") {
          questions = paperController.getNumberOfQuestions();
          xps = paperController.getCorrectAnswers();
          title = "Paper";

          Map grades = getStudentGrade(xps, questions);
          scores = grades['percentage'];
          status = grades['grade'];

          // save paper score
          paperController.saveTestScore(double.parse(scores));
        } else if (type == "mock") {
          questions = mockController.getNumberOfQuestions();
          xps = mockController.getCorrectAnswers();
          title = "Mock";

          Map grades = getStudentGrade(xps, questions);
          scores = grades['percentage'];
          status = grades['grade'];

          // save mock score
          mockController.saveTestScore(double.parse(scores));
        } else if (type == "challenge") {
          questions = challengeController.getNumberOfQuestions();
          xps = challengeController.getCorrectAnswers();
          title = "Challenge";

          Map grades = getStudentGrade(xps, questions);

          scores = grades['percentage'];
          status = grades['grade'];

          // save quiz score
          challengeController.saveQuizScore(xps);
        }

        // save xps
        if (xps > 0) {
          statsService.saveXps(xps);
        }

        // Update Streak
        statsService.saveStreak();

        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (bool didPop, other) async {
            if (didPop) {
              return;
            }
            Get.back();
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
                                "Great Job, You've Completed the $title! Here's a summary of your performance.",
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
                                      // images
                                      Stack(
                                        children: [
                                          Image.asset(
                                              "images/lesson_completed_background.png",
                                              fit: BoxFit.contain),
                                          Positioned(
                                            top: 0,
                                            left: 0,
                                            right: 0,
                                            bottom: 0,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  images[status],
                                                  height: imageHeight,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),

                                      // details
                                      SizedBox(
                                        height: 40.h,
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
