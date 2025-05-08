import 'dart:ui';

import 'package:edgiprep/controllers/challenge/challenge_controller.dart';
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

class Challenge extends StatefulWidget {
  const Challenge({super.key});

  @override
  State<Challenge> createState() => _ChallengeState();
}

class _ChallengeState extends State<Challenge> {
  ChallengeController challengeController = Get.find<ChallengeController>();

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
          "Challenge",
          "You're about to leave the challenge. Your progress will be saved, and XPs earned will not be lost.",
        );

        challengeController.saveQuestionScores();
        challengeController
            .saveQuizScore(challengeController.getCorrectAnswers());
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
                            "Challenge",
                            "You're about to leave the challenge. Your progress will be saved, and XPs earned will not be lost.",
                          );

                          challengeController.saveQuestionScores();
                          challengeController.saveQuizScore(
                              challengeController.getCorrectAnswers());
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
                                padding: EdgeInsets.symmetric(horizontal: 0),
                                width: 300.w,
                                animation: true,
                                animationDuration: 500,
                                animateFromLastPercent: true,
                                lineHeight: 14.h,
                                // Calculate the percent with a check to prevent division errors
                                percent: challengeController.slides.isNotEmpty
                                    ? (challengeController
                                                .currentSlideIndex.value +
                                            1) /
                                        challengeController.slides.length
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
                            "${challengeController.currentSlideIndex.value + 1} / ${challengeController.slides.length}");
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
                      physics: const NeverScrollableScrollPhysics(),
                      controller: challengeController.pageController,
                      onPageChanged: (index) {
                        if (index <
                            challengeController.currentSlideIndex.value) {
                          challengeController.goToPreviousSlide();
                        } else {
                          challengeController.currentSlideIndex.value = index;
                        }
                      },
                      itemCount: challengeController.visibleSlides.length,
                      itemBuilder: (context, index) {
                        final slide = challengeController.visibleSlides[index];

                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30.w),
                          child: LessonSlide(
                            slide: slide,
                            type: "challenge",
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
                      bool isLast = challengeController.isLastSlide();

                      if (challengeController
                              .visibleSlides[
                                  challengeController.currentSlideIndex.value]
                              .question ==
                          null) {
                        // not a question
                        challengeController.goToNextSlide();
                      } else {
                        // has question
                        // check if answered
                        // if slide not marked done: mark else : go to next
                        if (challengeController
                            .visibleSlides[
                                challengeController.currentSlideIndex.value]
                            .slideDone) {
                          // next
                          challengeController.goToNextSlide();
                        } else if (challengeController
                                .visibleSlides[
                                    challengeController.currentSlideIndex.value]
                                .question
                                ?.userAnswerId
                                .trim() !=
                            "") {
                          // mark
                          challengeController.markSlideDone();

                          if (challengeController
                                  .visibleSlides[challengeController
                                      .currentSlideIndex.value]
                                  .question
                                  ?.correctAnswerId ==
                              challengeController
                                  .visibleSlides[challengeController
                                      .currentSlideIndex.value]
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
                            challengeController.goToNextSlide();
                          } else {
                            // wrong
                            await showModalBottomSheet(
                              backgroundColor: Colors.transparent,
                              context: context,
                              isScrollControlled: true,
                              isDismissible: false,
                              builder: (BuildContext context) => BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                                child: lessonIncorrect("challenge"),
                              ),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(0),
                                ),
                              ),
                            );
                            challengeController.goToNextSlide();
                          }
                        } else {
                          return;
                        }
                      }
                      // finish
                      if (isLast) {
                        // save progress first
                        challengeController.saveQuestionScores();
                        Get.to(() => const AppraisalFinish(
                              type: "challenge",
                            ));
                      }
                    },
                    child: Obx(() {
                      return normalButton(
                        challengeController
                                    .visibleSlides[challengeController
                                        .currentSlideIndex.value]
                                    .question ==
                                null
                            ? primaryColor
                            : challengeController
                                            .visibleSlides[challengeController
                                                .currentSlideIndex.value]
                                            .question !=
                                        null &&
                                    challengeController
                                            .visibleSlides[challengeController
                                                .currentSlideIndex.value]
                                            .question
                                            ?.userAnswerId
                                            .trim() !=
                                        ""
                                ? primaryColor
                                : const Color.fromRGBO(214, 220, 233, 1),
                        challengeController
                                    .visibleSlides[challengeController
                                        .currentSlideIndex.value]
                                    .question ==
                                null
                            ? Colors.white
                            : challengeController
                                            .visibleSlides[challengeController
                                                .currentSlideIndex.value]
                                            .question !=
                                        null &&
                                    challengeController
                                            .visibleSlides[challengeController
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
