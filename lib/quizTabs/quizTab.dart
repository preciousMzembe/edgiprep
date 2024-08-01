import 'package:edgiprep/controllers/current_quiz_controller.dart';
import 'package:edgiprep/quizTabs/answer.dart';
import 'package:edgiprep/quizTabs/done.dart';
import 'package:edgiprep/quizTabs/retry_prompt.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:edgiprep/utils/utils.dart';
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
    void close() {
      showCloseQuizDialog(
        context,
        "Quit Quiz?",
        "Are you sure you want to quit the quiz?",
        () {
          if (currentQuizController.correctionRound) {
            Get.back();
            Get.back();
            Get.back();
            Get.back();
            Get.back();
          } else {
            Get.back();
            Get.back();
            Get.back();
          }
        },
      );
    }

    return PopScope(
      canPop: false,
      child: Obx(() {
        List<String> shuffledOptions = currentQuizController
            .questions[currentQuizController.currentQuestionIndex].options
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
                              close();
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
                      if (!currentQuizController.correctionRound)
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
                                  (currentQuizController.currentQuestionIndex +
                                          1) /
                                      currentQuizController.numberOfQuestions,
                              barRadius: Radius.circular(30.r),
                              progressColor: primaryColor,
                              backgroundColor: progressColor,
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            // progress numbers
                            // RichText(
                            //   text: TextSpan(
                            //     style: GoogleFonts.nunito(
                            //       color: Colors.black,
                            //       fontSize: 25.sp,
                            //       fontWeight: FontWeight.w900,
                            //     ),
                            //     children: [
                            //       TextSpan(
                            //         text:
                            //             "${currentQuizController.currentQuestionIndex + 1}",
                            //         style: TextStyle(color: primaryColor),
                            //       ),
                            //       TextSpan(
                            //         text:
                            //             "/${currentQuizController.numberOfQuestions}",
                            //         style: TextStyle(color: textColor),
                            //       ),
                            //     ],
                            //   ),
                            // ),
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
                            fontSize: 30.sp,
                            fontWeight: FontWeight.w900,
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
                      color: !currentQuizController.checkAnswer
                          ? const Color.fromRGBO(47, 59, 98, 0.178)
                          : shuffledOptions[
                                      currentQuizController.selectedIndex] ==
                                  currentQuizController
                                      .questions[currentQuizController
                                          .currentQuestionIndex]
                                      .answer
                              ? const Color.fromRGBO(76, 175, 79, 0.178)
                              : const Color.fromRGBO(244, 67, 54, 0.178),
                      padding: EdgeInsets.symmetric(
                        vertical: 40.h,
                        horizontal: 30.h,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // question status and answer
                          if (currentQuizController.checkAnswer)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                // status
                                Row(
                                  children: [
                                    // icon
                                    if (currentQuizController.selectedIndex >=
                                        0)
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
                                    if (currentQuizController.selectedIndex >=
                                        0)
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
                                              currentQuizController
                                                  .questions[
                                                      currentQuizController
                                                          .currentQuestionIndex]
                                                  .answer,
                                              style: GoogleFonts.nunito(
                                                fontSize: 25.sp,
                                                fontWeight: FontWeight.w900,
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
                                // if last question
                                if (currentQuizController.isLastQuestion()) {
                                  // mark
                                  currentQuizController.answerSelected(
                                      shuffledOptions[
                                          currentQuizController.selectedIndex],
                                      currentQuizController
                                          .questions[currentQuizController
                                              .currentQuestionIndex]
                                          .answer);

                                  // change page
                                  if (currentQuizController.score !=
                                          currentQuizController
                                              .questions.length &&
                                      !currentQuizController.correctionRound) {
                                    // go for correction
                                    currentQuizController
                                        .setCorrectionRound(true);
                                    currentQuizController
                                        .setCorrectionQuestions();
                                    currentQuizController.resetQuiz();

                                    Get.to(() => const RetryPrompt());
                                  } else {
                                    Get.to(() => const Done());
                                  }
                                } else {
                                  // next question
                                  currentQuizController.answerSelected(
                                      shuffledOptions[
                                          currentQuizController.selectedIndex],
                                      currentQuizController
                                          .questions[currentQuizController
                                              .currentQuestionIndex]
                                          .answer);
                                }
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
      }),
    );
  }
}
