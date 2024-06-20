import 'dart:math';

import 'package:edgiprep/controllers/current_lesson_controller.dart';
import 'package:edgiprep/quizTabs/answer.dart';
import 'package:edgiprep/quizTabs/done.dart';
import 'package:edgiprep/quizTabs/retry_prompt.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';

class LessonTab extends StatefulWidget {
  const LessonTab({super.key});

  @override
  State<LessonTab> createState() => _LessonTabState();
}

class _LessonTabState extends State<LessonTab> {
  CurrentLessonController currentLessonController =
      Get.find<CurrentLessonController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      List<String> shuffledOptions = currentLessonController
          .questions[currentLessonController.currentQuestionIndex].options
          .toList();
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
                            currentLessonController.title,
                            maxLines: 1,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          height: 20.h,
                        ),
                        LinearPercentIndicator(
                          padding: const EdgeInsets.all(0),
                          // animation: true,
                          lineHeight: 15.h,
                          // animationDuration: 2000,
                          // percent
                          percent:
                              (currentLessonController.currentQuestionIndex +
                                      1) /
                                  currentLessonController.numberOfQuestions,
                          barRadius: Radius.circular(30.r),
                          progressColor: primaryColor,
                          backgroundColor: progressColor,
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        // progress numbers
                        RichText(
                          text: TextSpan(
                            style: GoogleFonts.nunito(
                              color: Colors.black,
                              fontSize: 25.sp,
                              fontWeight: FontWeight.w900,
                            ),
                            children: [
                              TextSpan(
                                text:
                                    "${currentLessonController.currentQuestionIndex + 1}",
                                style: TextStyle(color: primaryColor),
                              ),
                              TextSpan(
                                text:
                                    "/${currentLessonController.numberOfQuestions}",
                                style: TextStyle(color: textColor),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // question and answers
              SizedBox(
                height: 10.h,
              ),
              Expanded(
                child: LayoutBuilder(builder: (context, constraints) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    child: ListView(
                      children: [
                        SizedBox(
                          height: 30.h,
                        ),
                        // question
                        Text(
                          currentLessonController
                              .questions[
                                  currentLessonController.currentQuestionIndex]
                              .question,
                          style: GoogleFonts.nunito(
                            fontSize: 35.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),

                        // answers
                        SizedBox(
                          height: 80.h,
                        ),

                        for (int i = 0; i < shuffledOptions.length; i++)
                          Column(
                            children: [
                              Answer(
                                answer: shuffledOptions[i],
                                selected:
                                    currentLessonController.selectedIndex == i,
                                select: () {
                                  if (!currentLessonController.checkAnswer) {
                                    currentLessonController.setSelectedIndex(i);
                                  }
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
                  );
                }),
              ),

              // check and continue
              if (currentLessonController.selectedIndex >= 0)
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40.r),
                      topRight: Radius.circular(40.r)),
                  child: Container(
                    color: const Color.fromRGBO(47, 59, 98, 0.178),
                    padding: EdgeInsets.symmetric(
                      vertical: 40.h,
                      horizontal: 30.h,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // question status and answer
                        Visibility(
                          visible: currentLessonController.checkAnswer,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // status
                              Row(
                                children: [
                                  // icon
                                  if (currentLessonController.selectedIndex >=
                                      0)
                                    Container(
                                      width: 50.h,
                                      height: 50.h,
                                      decoration: BoxDecoration(
                                        color: shuffledOptions[
                                                    currentLessonController
                                                        .selectedIndex] ==
                                                currentLessonController
                                                    .questions[
                                                        currentLessonController
                                                            .currentQuestionIndex]
                                                    .answer
                                            ? Colors.green
                                            : Colors.red,
                                        borderRadius:
                                            BorderRadius.circular(50.r),
                                      ),
                                      child: Icon(
                                        shuffledOptions[currentLessonController
                                                    .selectedIndex] ==
                                                currentLessonController
                                                    .questions[
                                                        currentLessonController
                                                            .currentQuestionIndex]
                                                    .answer
                                            ? FontAwesomeIcons.check
                                            : FontAwesomeIcons.xmark,
                                        size: 25.h,
                                        color: Colors.white,
                                      ),
                                    ),
                                  SizedBox(
                                    width: 15.w,
                                  ),
                                  // correct or wrong
                                  if (currentLessonController.selectedIndex >=
                                      0)
                                    Text(
                                      shuffledOptions[currentLessonController
                                                  .selectedIndex] ==
                                              currentLessonController
                                                  .questions[
                                                      currentLessonController
                                                          .currentQuestionIndex]
                                                  .answer
                                          ? "Correct"
                                          : "Wrong",
                                      style: GoogleFonts.nunito(
                                        fontSize: 40.sp,
                                        fontWeight: FontWeight.w900,
                                        color: shuffledOptions[
                                                    currentLessonController
                                                        .selectedIndex] ==
                                                currentLessonController
                                                    .questions[
                                                        currentLessonController
                                                            .currentQuestionIndex]
                                                    .answer
                                            ? Colors.green
                                            : Colors.red,
                                      ),
                                    ),
                                ],
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              // answer
                              if (shuffledOptions[
                                      currentLessonController.selectedIndex] !=
                                  currentLessonController
                                      .questions[currentLessonController
                                          .currentQuestionIndex]
                                      .answer)
                                Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Answer: ",
                                          style: GoogleFonts.nunito(
                                            fontSize: 25.sp,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            currentLessonController
                                                .questions[
                                                    currentLessonController
                                                        .currentQuestionIndex]
                                                .answer,
                                            style: GoogleFonts.nunito(
                                              fontSize: 35.sp,
                                              fontWeight: FontWeight.w900,
                                              color: Colors.green,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                        // check
                        MaterialButton(
                          color: secondaryColor,
                          height: 100.h,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100.r),
                          ),
                          onPressed: () {
                            if (!currentLessonController.checkAnswer) {
                              // check
                              currentLessonController.setCheckAnswer(true);
                            } else {
                              // if last question
                              if (currentLessonController.isLastQuestion()) {
                                // mark
                                currentLessonController.answerSelected(
                                    shuffledOptions[
                                        currentLessonController.selectedIndex],
                                    currentLessonController
                                        .questions[currentLessonController
                                            .currentQuestionIndex]
                                        .answer);

                                // change page
                                // if (currentLessonController.score !=
                                //         currentLessonController
                                //             .questions.length) {

                                //   Get.to(() => const RetryPrompt());
                                // } else {
                                //   Get.to(() => const Done());
                                // }
                              } else {
                                // next question
                                currentLessonController.answerSelected(
                                    shuffledOptions[
                                        currentLessonController.selectedIndex],
                                    currentLessonController
                                        .questions[currentLessonController
                                            .currentQuestionIndex]
                                        .answer);
                              }
                            }
                          },
                          child: Text(
                            !currentLessonController.checkAnswer
                                ? "Check"
                                : shuffledOptions[currentLessonController
                                            .selectedIndex] !=
                                        currentLessonController
                                            .questions[currentLessonController
                                                .currentQuestionIndex]
                                            .answer
                                    ? "Got It"
                                    : "Continue",
                            style: GoogleFonts.nunito(
                              color: primaryColor,
                              fontSize: 40.sp,
                              fontWeight: FontWeight.w900,
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
    });
  }
}

class Question extends StatelessWidget {
  const Question({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        
      ],
    );
  }
}