import 'dart:ui';

import 'package:edgiprep/controllers/lesson/lesson_controller.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:edgiprep/views/components/general/normal_button.dart';
import 'package:edgiprep/views/components/lesson/lesson_close.dart';
import 'package:edgiprep/views/components/lesson/lesson_close_button.dart';
import 'package:edgiprep/views/components/lesson/lesson_correct.dart';
import 'package:edgiprep/views/components/lesson/lesson_incorrect.dart';
import 'package:edgiprep/views/components/lesson/lesson_slide.dart';
import 'package:edgiprep/views/components/lesson/lesson_slides_number.dart';
import 'package:edgiprep/views/screens/subjects/lesson_finish.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class LessonPlayer extends StatefulWidget {
  const LessonPlayer({super.key});

  @override
  State<LessonPlayer> createState() => _LessonPlayerState();
}

class _LessonPlayerState extends State<LessonPlayer> {
  LessonController lessonController = Get.find<LessonController>();

  @override
  void initState() {
    super.initState();

    // Schedule it to run after the first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        int index = lessonController.currentSlideIndex.value;
        lessonController.pageController
            .animateToPage(
          index,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        )
            .then((_) {
          lessonController.firstJump.value = false;
        });
      }
    });
  }

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
          "Lesson",
          "You're about to leave the lesson. Your progress will be saved, and you can continue from where you left off later.",
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
                            "Lesson",
                            "You're about to leave the lesson. Your progress will be saved, and you can continue from where you left off later.",
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
                                percent: lessonController.slides.isNotEmpty
                                    ? (lessonController
                                                .currentSlideIndex.value +
                                            1) /
                                        lessonController.slides.length
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
                            "${lessonController.currentSlideIndex.value + 1} / ${lessonController.slides.length}");
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
                      physics: const PageScrollPhysics(),
                      controller: lessonController.pageController,
                      onPageChanged: (index) {
                        if (index < lessonController.currentSlideIndex.value) {
                          if (!lessonController.firstJump.value) {
                            lessonController.goToPreviousSlide();
                          }
                        } else {
                          lessonController.currentSlideIndex.value = index;
                        }
                      },
                      itemCount: lessonController.visibleSlides.length,
                      itemBuilder: (context, index) {
                        final slide = lessonController.visibleSlides[index];

                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30.w),
                          child: LessonSlide(
                            slide: slide,
                            type: "lesson",
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
                      bool isLast = lessonController.isLastSlide();

                      if (lessonController
                              .visibleSlides[
                                  lessonController.currentSlideIndex.value]
                              .question ==
                          null) {
                        // not a question
                        lessonController.goToNextSlide();
                      } else {
                        // has question
                        // check if answered
                        // if slide not marked done: mark else : go to next
                        if (lessonController
                            .visibleSlides[
                                lessonController.currentSlideIndex.value]
                            .slideDone) {
                          // next
                          lessonController.goToNextSlide();
                        } else if (lessonController
                                .visibleSlides[
                                    lessonController.currentSlideIndex.value]
                                .question
                                ?.userAnswerId
                                .trim() !=
                            "") {
                          // mark
                          lessonController.markSlideDone();

                          if (lessonController
                                  .visibleSlides[
                                      lessonController.currentSlideIndex.value]
                                  .question
                                  ?.correctAnswerId ==
                              lessonController
                                  .visibleSlides[
                                      lessonController.currentSlideIndex.value]
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
                            lessonController.goToNextSlide();
                          } else {
                            // wrong
                            await showModalBottomSheet(
                              backgroundColor: Colors.transparent,
                              context: context,
                              isScrollControlled: true,
                              isDismissible: false,
                              builder: (BuildContext context) => BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                                child: lessonIncorrect("lesson"),
                              ),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(0),
                                ),
                              ),
                            );
                            lessonController.goToNextSlide();
                          }
                        }
                      }
                      // finish
                      if (isLast) {
                        Get.to(() => const LessonFinish());
                      }
                    },
                    child: Obx(() {
                      return normalButton(
                        lessonController
                                    .visibleSlides[lessonController
                                        .currentSlideIndex.value]
                                    .question ==
                                null
                            ? primaryColor
                            : lessonController
                                            .visibleSlides[lessonController
                                                .currentSlideIndex.value]
                                            .question !=
                                        null &&
                                    lessonController
                                            .visibleSlides[lessonController
                                                .currentSlideIndex.value]
                                            .question
                                            ?.userAnswerId
                                            .trim() !=
                                        ""
                                ? primaryColor
                                : const Color.fromRGBO(214, 220, 233, 1),
                        lessonController
                                    .visibleSlides[lessonController
                                        .currentSlideIndex.value]
                                    .question ==
                                null
                            ? Colors.white
                            : lessonController
                                            .visibleSlides[lessonController
                                                .currentSlideIndex.value]
                                            .question !=
                                        null &&
                                    lessonController
                                            .visibleSlides[lessonController
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
