import 'dart:math';

import 'package:edgiprep/controllers/current_quiz_controller.dart';
import 'package:edgiprep/questionTabs/answer.dart';
import 'package:edgiprep/questionTabs/retry_prompt.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';

class QuizTab extends StatefulWidget {
  const QuizTab({super.key});

  @override
  State<QuizTab> createState() => _QuizTabState();
}

class _QuizTabState extends State<QuizTab> {
  CurrentQuizController currentQuizController =
      Get.find<CurrentQuizController>();

  @override
  Widget build(BuildContext context) {
    List<String> shuffledOptions = currentQuizController
        .questions[currentQuizController.currentQuestionIndex].options
        .toList();
    shuffledOptions.shuffle(Random());
    return Obx(() {
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
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                            currentQuizController.title,
                            maxLines: 2,
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
                    SizedBox(
                      height: 20.h,
                    ),
                    LinearPercentIndicator(
                      padding: const EdgeInsets.all(0),
                      animation: true,
                      lineHeight: 15.h,
                      animationDuration: 2000,
                      // percent
                      percent: currentQuizController.currentQuestionIndex /
                          currentQuizController.numberOfQuestions,
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
                                "${currentQuizController.currentQuestionIndex}",
                            style: TextStyle(color: primaryColor),
                          ),
                          TextSpan(
                            text: "/${currentQuizController.numberOfQuestions}",
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
                        currentQuizController
                            .questions[
                                currentQuizController.currentQuestionIndex]
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
                                  currentQuizController.selectedIndex == i,
                              select: () {
                                if (!currentQuizController.checkAnswer) {
                                  currentQuizController.setSelectedIndex(i);
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
                ),
              ),

              // check and continue
              if (currentQuizController.selectedIndex >= 0)
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40.r),
                      topRight: Radius.circular(40.r)),
                  child: Container(
                    color: Color.fromRGBO(47, 59, 98, 0.178),
                    padding: EdgeInsets.symmetric(
                      vertical: 40.h,
                      horizontal: 30.h,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // question status and answer
                        Visibility(
                          visible: currentQuizController.checkAnswer,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // status
                              Row(
                                children: [
                                  // icon
                                  if (currentQuizController.selectedIndex >= 0)
                                    Container(
                                      width: 50.h,
                                      height: 50.h,
                                      decoration: BoxDecoration(
                                        color: shuffledOptions[
                                                    currentQuizController
                                                        .selectedIndex] ==
                                                currentQuizController
                                                    .questions[
                                                        currentQuizController
                                                            .currentQuestionIndex]
                                                    .answer
                                            ? Colors.green
                                            : Colors.red,
                                        borderRadius:
                                            BorderRadius.circular(50.r),
                                      ),
                                      child: Icon(
                                        shuffledOptions[currentQuizController
                                                    .selectedIndex] ==
                                                currentQuizController
                                                    .questions[
                                                        currentQuizController
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
                                  if (currentQuizController.selectedIndex >= 0)
                                    Text(
                                      shuffledOptions[currentQuizController
                                                  .selectedIndex] ==
                                              currentQuizController
                                                  .questions[
                                                      currentQuizController
                                                          .currentQuestionIndex]
                                                  .answer
                                          ? "Correct"
                                          : "Wrong",
                                      style: GoogleFonts.nunito(
                                        fontSize: 40.sp,
                                        fontWeight: FontWeight.w900,
                                        color: shuffledOptions[
                                                    currentQuizController
                                                        .selectedIndex] ==
                                                currentQuizController
                                                    .questions[
                                                        currentQuizController
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
                                      currentQuizController.selectedIndex] !=
                                  currentQuizController
                                      .questions[currentQuizController
                                          .currentQuestionIndex]
                                      .answer)
                                Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Row(
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
                                            currentQuizController
                                                .questions[currentQuizController
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
                            if (!currentQuizController.checkAnswer) {
                              // check
                              currentQuizController.setCheckAnswer(true);
                            } else {
                              // continue
                              Get.to(() => const RetryPrompt());
                            }
                          },
                          child: Text(
                            !currentQuizController.checkAnswer
                                ? "Check"
                                : shuffledOptions[currentQuizController
                                            .selectedIndex] !=
                                        currentQuizController
                                            .questions[currentQuizController
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
