import 'dart:ui';

import 'package:edgiprep/controllers/quiz/quiz_controller.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:edgiprep/views/components/general/normal_button.dart';
import 'package:edgiprep/views/components/lesson/lesson_close.dart';
import 'package:edgiprep/views/components/lesson/lesson_close_button.dart';
import 'package:edgiprep/views/components/lesson/lesson_correct.dart';
import 'package:edgiprep/views/components/lesson/lesson_incorrect.dart';
import 'package:edgiprep/views/components/lesson/lesson_slide.dart';
import 'package:edgiprep/views/components/lesson/lesson_slides_number.dart';
import 'package:edgiprep/views/screens/appraisal/appraisal_finish.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  QuizController quizController = Get.find<QuizController>();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, other) async {
        if (didPop) {
          return;
        }
        showCloseLesson(
          context,
          "Quiz",
          "You're about to leave the quiz. Your progress will not be saved, but XPs earned will not be lost.",
        );
      },
      child: Scaffold(
        backgroundColor: appbarColor,
        body: SafeArea(
          child: Container(
            color: backgroundColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // indicator
                SizedBox(
                  height: 30.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // close
                      GestureDetector(
                        onTap: () {
                          showCloseLesson(
                            context,
                            "Quiz",
                            "You're about to leave the quiz. Your progress will not be saved, but XPs earned will not be lost.",
                          );
                        },
                        child: lessonCloseButton(),
                      ),

                      // progress
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Obx(() {
                              return LinearPercentIndicator(
                                width: 300.w,
                                animation: true,
                                animationDuration: 500,
                                animateFromLastPercent: true,
                                lineHeight: 14.h,
                                // Calculate the percent with a check to prevent division errors
                                percent: quizController.slides.isNotEmpty
                                    ? (quizController.currentSlideIndex.value +
                                            1) /
                                        quizController.slides.length
                                    : 0.0, // default to 0 if no slides
                                barRadius: Radius.circular(20.r),
                                backgroundColor: Colors.white,
                                progressColor:
                                    const Color.fromRGBO(73, 161, 249, 1),
                              );
                            }),
                          ],
                        ),
                      ),

                      // slides number
                      Obx(() {
                        return lessonSlidesNumber(
                            "${quizController.currentSlideIndex.value + 1} / ${quizController.slides.length}");
                      }),
                    ],
                  ),
                ),
                SizedBox(
                  height: 40.h,
                ),

                // slides
                Expanded(
                  child: Obx(
                    () => PageView.builder(
                      // scrollDirection: Axis.vertical,
                      physics: const NeverScrollableScrollPhysics(),
                      controller: quizController.pageController,
                      onPageChanged: (index) {
                        if (index < quizController.currentSlideIndex.value) {
                          quizController.goToPreviousSlide();
                        } else {
                          quizController.currentSlideIndex.value = index;
                        }
                      },
                      itemCount: quizController.visibleSlides.length,
                      itemBuilder: (context, index) {
                        final slide = quizController.visibleSlides[index];

                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30.w),
                          child: LessonSlide(
                            slide: slide,
                            type: "quiz",
                          ),
                        );
                      },
                    ),
                  ),
                ),

                // button
                SizedBox(
                  height: 30.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  child: GestureDetector(
                    onTap: () async {
                      // check if is last slide
                      bool isLast = quizController.isLastSlide();

                      if (quizController
                              .visibleSlides[
                                  quizController.currentSlideIndex.value]
                              .question ==
                          null) {
                        // not a question
                        quizController.goToNextSlide();
                      } else {
                        // has question
                        // check if answered
                        // if slide not marked done: mark else : go to next
                        if (quizController
                            .visibleSlides[
                                quizController.currentSlideIndex.value]
                            .slideDone) {
                          // next
                          quizController.goToNextSlide();
                        } else if (quizController
                                .visibleSlides[
                                    quizController.currentSlideIndex.value]
                                .question
                                ?.userAnswerId
                                .trim() !=
                            "") {
                          if (quizController
                                  .visibleSlides[
                                      quizController.currentSlideIndex.value]
                                  .question
                                  ?.correctAnswerId ==
                              quizController
                                  .visibleSlides[
                                      quizController.currentSlideIndex.value]
                                  .question
                                  ?.userAnswerId) {
                            // correct
                            await showModalBottomSheet(
                              backgroundColor: Colors.transparent,
                              context: context,
                              isScrollControlled: true,
                              isDismissible: false,
                              builder: (BuildContext context) => BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                                child: lessonCorrect(),
                              ),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(0),
                                ),
                              ),
                            );
                            quizController.goToNextSlide();
                          } else {
                            // wrong
                            await showModalBottomSheet(
                              backgroundColor: Colors.transparent,
                              context: context,
                              isScrollControlled: true,
                              isDismissible: false,
                              builder: (BuildContext context) => BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                                child: lessonIncorrect("quiz"),
                              ),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(0),
                                ),
                              ),
                            );
                            quizController.goToNextSlide();
                          }
                        }
                      }
                      // finish
                      if (isLast) {
                        Get.to(() => const AppraisalFinish(
                              type: "quiz",
                            ));
                      }
                    },
                    child: Obx(() {
                      return normalButton(
                        quizController
                                    .visibleSlides[
                                        quizController.currentSlideIndex.value]
                                    .question ==
                                null
                            ? primaryColor
                            : quizController
                                            .visibleSlides[quizController
                                                .currentSlideIndex.value]
                                            .question !=
                                        null &&
                                    quizController
                                            .visibleSlides[quizController
                                                .currentSlideIndex.value]
                                            .question
                                            ?.userAnswerId
                                            .trim() !=
                                        ""
                                ? primaryColor
                                : const Color.fromRGBO(214, 220, 233, 1),
                        quizController
                                    .visibleSlides[
                                        quizController.currentSlideIndex.value]
                                    .question ==
                                null
                            ? Colors.white
                            : quizController
                                            .visibleSlides[quizController
                                                .currentSlideIndex.value]
                                            .question !=
                                        null &&
                                    quizController
                                            .visibleSlides[quizController
                                                .currentSlideIndex.value]
                                            .question
                                            ?.userAnswerId
                                            .trim() !=
                                        ""
                                ? Colors.white
                                : Colors.black,
                        "Continue",
                        20,
                      );
                    }),
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
