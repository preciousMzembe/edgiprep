import 'package:edgiprep/challangeTabs/answer.dart';
import 'package:edgiprep/challangeTabs/done.dart';
import 'package:edgiprep/controllers/current_challange_controller.dart';
import 'package:edgiprep/controllers/xp_controller.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:edgiprep/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ChallangeTab extends StatefulWidget {
  const ChallangeTab({super.key});

  @override
  State<ChallangeTab> createState() => _ChallangeTabState();
}

class _ChallangeTabState extends State<ChallangeTab> {
  CurrentChallangeController currentChallangeController =
      Get.find<CurrentChallangeController>();
  XPController xpQuizController = Get.find<XPController>();

  @override
  Widget build(BuildContext context) {
    void close() {
      showCloseQuizDialog(
        context,
        "Quit Quiz?",
        "Are you sure you want to stop here?",
        () {
          xpQuizController.saveXP(currentChallangeController.score);
          Get.to(() => const Done());
        },
      );
    }

    return PopScope(
      canPop: false,
      child: Obx(() {
        List<String> shuffledOptions = currentChallangeController
            .questions[currentChallangeController.currentQuestionIndex].options
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
                              currentChallangeController.title,
                              maxLines: 1,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.nunito(
                                fontSize: 35.sp,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                          // SizedBox(
                          //   width: 20.w,
                          // ),
                          // // report question
                          // IconButton(
                          //   onPressed: () {},
                          //   icon: Icon(
                          //     FontAwesomeIcons.solidFlag,
                          //     size: 30.h,
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
                          currentChallangeController
                              .questions[currentChallangeController
                                  .currentQuestionIndex]
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
                                    currentChallangeController.selectedIndex ==
                                        i,
                                select: () {
                                  if (!currentChallangeController.checkAnswer) {
                                    currentChallangeController
                                        .setSelectedIndex(i);
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
                if (currentChallangeController.selectedIndex >= 0)
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40.r),
                        topRight: Radius.circular(40.r)),
                    child: Container(
                      color: !currentChallangeController.checkAnswer
                          ? const Color.fromRGBO(47, 59, 98, 0.178)
                          : shuffledOptions[currentChallangeController
                                      .selectedIndex] ==
                                  currentChallangeController
                                      .questions[currentChallangeController
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
                          if (currentChallangeController.checkAnswer)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                // status
                                Row(
                                  children: [
                                    // icon
                                    if (currentChallangeController
                                            .selectedIndex >=
                                        0)
                                      Container(
                                        width: 50.h,
                                        height: 50.h,
                                        decoration: BoxDecoration(
                                          color: shuffledOptions[
                                                      currentChallangeController
                                                          .selectedIndex] ==
                                                  currentChallangeController
                                                      .questions[
                                                          currentChallangeController
                                                              .currentQuestionIndex]
                                                      .answer
                                              ? Colors.green
                                              : Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(50.r),
                                        ),
                                        child: Icon(
                                          shuffledOptions[
                                                      currentChallangeController
                                                          .selectedIndex] ==
                                                  currentChallangeController
                                                      .questions[
                                                          currentChallangeController
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
                                    if (currentChallangeController
                                            .selectedIndex >=
                                        0)
                                      Text(
                                        shuffledOptions[
                                                    currentChallangeController
                                                        .selectedIndex] ==
                                                currentChallangeController
                                                    .questions[
                                                        currentChallangeController
                                                            .currentQuestionIndex]
                                                    .answer
                                            ? "Correct"
                                            : "Wrong",
                                        style: GoogleFonts.nunito(
                                          fontSize: 40.sp,
                                          fontWeight: FontWeight.w900,
                                          color: shuffledOptions[
                                                      currentChallangeController
                                                          .selectedIndex] ==
                                                  currentChallangeController
                                                      .questions[
                                                          currentChallangeController
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
                                if (shuffledOptions[currentChallangeController
                                        .selectedIndex] !=
                                    currentChallangeController
                                        .questions[currentChallangeController
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
                                              currentChallangeController
                                                  .questions[
                                                      currentChallangeController
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
                              if (!currentChallangeController.checkAnswer) {
                                // check
                                currentChallangeController.setCheckAnswer(true);
                              } else {
                                // if last question
                                // if (currentChallangeController
                                //     .isLastQuestion()) {
                                //   // mark
                                //   currentChallangeController.answerSelected(
                                //       shuffledOptions[currentChallangeController
                                //           .selectedIndex],
                                //       currentChallangeController
                                //           .questions[currentChallangeController
                                //               .currentQuestionIndex]
                                //           .answer);

                                //   // change page
                                //   if (currentChallangeController.score !=
                                //           currentChallangeController
                                //               .questions.length &&
                                //       !currentChallangeController
                                //           .correctionRound) {
                                //     // go for correction
                                //     currentChallangeController
                                //         .setCorrectionRound(true);
                                //     currentChallangeController
                                //         .setCorrectionQuestions();
                                //     currentChallangeController.resetQuiz();

                                //     Get.to(() => const RetryPrompt());
                                //   } else {
                                //     Get.to(() => const Done());
                                //   }
                                // }
                                // else {
                                // next question
                                currentChallangeController.answerSelected(
                                    shuffledOptions[currentChallangeController
                                        .selectedIndex],
                                    currentChallangeController
                                        .questions[currentChallangeController
                                            .currentQuestionIndex]
                                        .answer);
                                // }
                              }
                            },
                            child: Text(
                              !currentChallangeController.checkAnswer
                                  ? "Check"
                                  : shuffledOptions[currentChallangeController
                                              .selectedIndex] !=
                                          currentChallangeController
                                              .questions[
                                                  currentChallangeController
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
