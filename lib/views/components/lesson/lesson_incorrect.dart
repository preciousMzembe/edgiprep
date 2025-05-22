import 'package:edgiprep/controllers/challenge/challenge_controller.dart';
import 'package:edgiprep/controllers/lesson/lesson_controller.dart';
import 'package:edgiprep/controllers/mock/mock_controller.dart';
import 'package:edgiprep/controllers/past_paper/paper_controller.dart';
import 'package:edgiprep/controllers/quiz/quiz_controller.dart';
import 'package:edgiprep/models/lesson/question_answer_model.dart';
import 'package:edgiprep/utils/device_utils.dart';
import 'package:edgiprep/views/components/general/normal_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

Widget lessonIncorrect(String type) {
  LessonController lessonController = Get.find<LessonController>();
  QuizController quizController = Get.find<QuizController>();
  PaperController paperController = Get.find<PaperController>();
  MockController mockController = Get.find<MockController>();
  ChallengeController challengeController = Get.find<ChallengeController>();

  QuestionAnswerModel? correctAnswer;
  String aImage = "";
  String explanation = "";
  String expImage = "";

  return LayoutBuilder(
    builder: (context, constraints) {
      bool isTablet = DeviceUtils.isTablet(context);
      bool isSmallTablet = DeviceUtils.isSmallTablet(context);

      double titleFontSize = isTablet
          ? 46.sp
          : isSmallTablet
              ? 48.sp
              : 50.sp;

      double answerTitleSize = isTablet
          ? 16.sp
          : isSmallTablet
              ? 18.sp
              : 20.sp;

      double answerSize = isTablet
          ? 20.sp
          : isSmallTablet
              ? 22.sp
              : 24.sp;

      double explanationSize = isTablet
          ? 18.sp
          : isSmallTablet
              ? 20.sp
              : 22.sp;

      if (type == "lesson") {
        List<QuestionAnswerModel> options = lessonController
                .slides[lessonController.currentSlideIndex.value]
                .question
                ?.options ??
            [];

        for (var option in options) {
          if (option.isCorrect) {
            correctAnswer = option;
          }
        }

        aImage = correctAnswer?.image ?? "";

        explanation = lessonController
                .slides[lessonController.currentSlideIndex.value]
                .question
                ?.explanation ??
            "";

        expImage = lessonController
                .slides[lessonController.currentSlideIndex.value]
                .question
                ?.explanationImage ??
            "";
      } else if (type == "quiz") {
        List<QuestionAnswerModel> options = quizController
                .slides[quizController.currentSlideIndex.value]
                .question
                ?.options ??
            [];

        for (var option in options) {
          if (option.isCorrect) {
            correctAnswer = option;
          }
        }

        aImage = correctAnswer?.image ?? "";

        explanation = quizController
                .slides[quizController.currentSlideIndex.value]
                .question
                ?.explanation ??
            "";
        expImage = quizController.slides[quizController.currentSlideIndex.value]
                .question?.explanationImage ??
            "";
      } else if (type == "paper") {
        List<QuestionAnswerModel> options = paperController
                .slides[paperController.currentSlideIndex.value]
                .question
                ?.options ??
            [];
        for (var option in options) {
          if (option.isCorrect) {
            correctAnswer = option;
          }
        }

        aImage = correctAnswer?.image ?? "";

        explanation = paperController
                .slides[paperController.currentSlideIndex.value]
                .question
                ?.explanation ??
            "";
        expImage = paperController
                .slides[paperController.currentSlideIndex.value]
                .question
                ?.explanationImage ??
            "";
      } else if (type == "mock") {
        List<QuestionAnswerModel> options = mockController
                .slides[mockController.currentSlideIndex.value]
                .question
                ?.options ??
            [];

        for (var option in options) {
          if (option.isCorrect) {
            correctAnswer = option;
          }
        }

        aImage = correctAnswer?.image ?? "";

        explanation = mockController
                .slides[mockController.currentSlideIndex.value]
                .question
                ?.explanation ??
            "";
        expImage = mockController.slides[mockController.currentSlideIndex.value]
                .question?.explanationImage ??
            "";
      } else if (type == "challenge") {
        List<QuestionAnswerModel> options = challengeController
                .slides[challengeController.currentSlideIndex.value]
                .question
                ?.options ??
            [];

        for (var option in options) {
          if (option.isCorrect) {
            correctAnswer = option;
          }
        }

        aImage = correctAnswer?.image ?? "";

        explanation = challengeController
                .slides[challengeController.currentSlideIndex.value]
                .question
                ?.explanation ??
            "";
        expImage = challengeController
                .slides[challengeController.currentSlideIndex.value]
                .question
                ?.explanationImage ??
            "";
      }

      String cleanContent =
          correctAnswer!.text.replaceAll(RegExp(r'<[^>]*>'), '').trim();

      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.h),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30.r),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    color: const Color.fromRGBO(254, 232, 232, 1),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    color: const Color.fromRGBO(254, 101, 93, 1),
                    height: 400.h,
                  ),
                ),
                Container(
                  color: Colors.transparent,
                  padding: EdgeInsets.symmetric(
                    horizontal: 50.w,
                    vertical: 50.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: 30.h,
                      ),
                      // icon
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(30.r),
                            child: SvgPicture.asset(
                              'icons/sad.svg',
                              height: 130.r,
                              width: 130.r,
                            ),
                          ),
                        ],
                      ),

                      // title
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(
                        "Incorrect",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          fontSize: titleFontSize,
                          fontWeight: FontWeight.w800,
                          color: const Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),

                      // answer and explanation
                      SizedBox(
                        height: 30.h,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30.r),
                        child: Container(
                          color: Colors.white,
                          padding: EdgeInsets.symmetric(
                            vertical: 40.h,
                            horizontal: 40.w,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20.r),
                                    child: Container(
                                      width: 90.w,
                                      height: 8.h,
                                      color: const Color.fromRGBO(
                                          254, 232, 232, 1),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 40.h,
                              ),
                              // answer
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Text(
                                          "Correct Answer",
                                          style: GoogleFonts.inter(
                                            fontSize: answerTitleSize,
                                            fontWeight: FontWeight.w700,
                                            color: const Color.fromRGBO(
                                                232, 144, 145, 1),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 8.h,
                                        ),
                                        if (cleanContent != "")
                                          HtmlWidget(
                                            correctAnswer?.text ?? "",
                                            textStyle: GoogleFonts.inter(
                                              fontSize: answerSize,
                                              fontWeight: FontWeight.w700,
                                              color: const Color.fromRGBO(
                                                  92, 101, 120, 1),
                                            ),
                                            customWidgetBuilder: (element) {
                                              if (element.localName == "span" &&
                                                  element.classes
                                                      .contains("ql-formula")) {
                                                String? latexExpression =
                                                    element.attributes[
                                                        "data-value"];

                                                if (latexExpression != null) {
                                                  return Math.tex(
                                                    latexExpression,
                                                    textStyle:
                                                        GoogleFonts.inter(
                                                      fontSize: answerSize,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color:
                                                          const Color.fromRGBO(
                                                              92, 101, 120, 1),
                                                    ),
                                                  );
                                                }
                                              }
                                              return null;
                                            },
                                          ),

                                        // Image
                                        if (aImage != "")
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              if (correctAnswer!.text != "")
                                                SizedBox(
                                                  height: 20.h,
                                                ),
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(20.r),
                                                child: Image.network(
                                                  aImage,
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            ],
                                          ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20.w,
                                  ),
                                  Container(
                                    width: 46.r,
                                    height: 46.r,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 1.0,
                                        color: const Color.fromRGBO(
                                            237, 167, 168, 1),
                                      ),
                                      borderRadius: BorderRadius.circular(50.r),
                                    ),
                                    child: Icon(
                                      FontAwesomeIcons.check,
                                      size: 25.r,
                                      color: const Color.fromRGBO(
                                          237, 167, 168, 1),
                                    ),
                                  ),
                                ],
                              ),

                              // explanation
                              if (explanation.isNotEmpty || expImage != "")
                                Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    SizedBox(
                                      height: 30.h,
                                    ),
                                    Text(
                                      "Explanation",
                                      style: GoogleFonts.inter(
                                        fontSize: answerTitleSize,
                                        fontWeight: FontWeight.w700,
                                        color: const Color.fromRGBO(
                                            232, 144, 145, 1),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8.h,
                                    ),
                                    if (explanation.isNotEmpty)
                                      HtmlWidget(
                                        explanation,
                                        textStyle: GoogleFonts.inter(
                                          fontSize: explanationSize,
                                          fontWeight: FontWeight.w500,
                                          color: const Color.fromRGBO(
                                              17, 25, 37, 1),
                                        ),
                                        customWidgetBuilder: (element) {
                                          if (element.localName == "span" &&
                                              element.classes
                                                  .contains("ql-formula")) {
                                            String? latexExpression = element
                                                .attributes["data-value"];

                                            if (latexExpression != null) {
                                              return Math.tex(
                                                latexExpression,
                                                textStyle: GoogleFonts.inter(
                                                  fontSize: explanationSize,
                                                  fontWeight: FontWeight.w500,
                                                  color: const Color.fromRGBO(
                                                      17, 25, 37, 1),
                                                ),
                                              );
                                            }
                                          }
                                          return null;
                                        },
                                      ),

                                    // Exp Image
                                    if (expImage != "")
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          if (correctAnswer!.text != "")
                                            SizedBox(
                                              height: 20.h,
                                            ),
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20.r),
                                            child: Image.network(
                                              expImage,
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        ],
                                      ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ),

                      // button
                      SizedBox(
                        height: 40.h,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: normalButton(
                          const Color.fromRGBO(254, 101, 93, 1),
                          Colors.white,
                          "Continue",
                          100,
                        ),
                      ),
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
