import 'package:edgiprep/controllers/challenge/challenge_controller.dart';
import 'package:edgiprep/controllers/lesson/lesson_controller.dart';
import 'package:edgiprep/controllers/mock/mock_controller.dart';
import 'package:edgiprep/controllers/past%20paper/paper_controller.dart';
import 'package:edgiprep/controllers/quiz/quiz_controller.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:edgiprep/utils/device_utils.dart';
import 'package:edgiprep/views/components/subjects/subjects_back.dart';
import 'package:edgiprep/views/screens/appraisal/challenge.dart';
import 'package:edgiprep/views/screens/appraisal/mock.dart';
import 'package:edgiprep/views/screens/appraisal/paper.dart';
import 'package:edgiprep/views/screens/appraisal/quiz.dart';
import 'package:edgiprep/views/screens/subjects/lesson.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class LoadSlides extends StatefulWidget {
  final String title;
  final String message;
  final String type;
  const LoadSlides(
      {super.key,
      required this.title,
      required this.message,
      required this.type});

  @override
  State<LoadSlides> createState() => _LoadSlidesState();
}

class _LoadSlidesState extends State<LoadSlides> {
  LessonController lessonController = Get.find<LessonController>();
  QuizController quizController = Get.find<QuizController>();
  PaperController paperController = Get.find<PaperController>();
  MockController mockController = Get.find<MockController>();
  ChallengeController challengeController = Get.find<ChallengeController>();

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      lessonController.restartLesson();
      quizController.restartLesson();
      paperController.restartLesson();
      mockController.restartLesson();
      challengeController.restartLesson();

      Get.back();

      if (widget.type == "lesson") {
        Get.to(() => const Lesson());
      } else if (widget.type == "quiz") {
        Get.to(() => const Quiz());
      } else if (widget.type == "paper") {
        Get.to(() => const Paper());
      } else if (widget.type == "mock") {
        Get.to(() => const Mock());
      } else if (widget.type == "challenge") {
        Get.to(() => const Challenge());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isTablet = DeviceUtils.isTablet(context);
        bool isSmallTablet = DeviceUtils.isSmallTablet(context);

        double titleSize = isTablet
            ? 34.sp
            : isSmallTablet
                ? 36.sp
                : 38.sp;

        double subtitleSize = isTablet
            ? 18.sp
            : isSmallTablet
                ? 20.sp
                : 22.sp;

        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (bool didPop, other) async {
            if (didPop) {
              return;
            }
          },
          child: Scaffold(
            backgroundColor: appbarColor,
            body: SafeArea(
              child: Container(
                color: backgroundColor,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: 30.h,
                      ),
                      // back

                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: subjectsBack(
                                const Color.fromRGBO(52, 74, 106, 1)),
                          ),
                        ],
                      ),
                      // body
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Lottie.asset(
                              'icons/loading.json',
                              height: 200.h,
                            ),
                            Text(
                              widget.title,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.inter(
                                fontSize: titleSize,
                                fontWeight: FontWeight.w800,
                                color: const Color.fromRGBO(52, 74, 106, 1),
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 40.w),
                              child: Text(
                                widget.message,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inter(
                                  fontSize: subtitleSize,
                                  fontWeight: FontWeight.w400,
                                  color: const Color.fromRGBO(92, 101, 120, 1),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
