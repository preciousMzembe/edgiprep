import 'package:edgiprep/controllers/quiz/quiz_controller.dart';
import 'package:edgiprep/models/lesson/lesson_slide_question_model.dart';
import 'package:edgiprep/utils/device_utils.dart';
import 'package:edgiprep/views/components/general/html_content.dart';
import 'package:edgiprep/views/components/lesson/lesson_question_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

Widget quizQuestion(LessonSlideQuestionModel? question, bool sideDone) {
  QuizController quizController = Get.find<QuizController>();
  return LayoutBuilder(
    builder: (context, constraints) {
      bool isTablet = DeviceUtils.isTablet(context);
      bool isSmallTablet = DeviceUtils.isSmallTablet(context);

      double titleFont = isTablet
          ? 16.sp
          : isSmallTablet
              ? 18.sp
              : 20.sp;

      double questionFont = isTablet
          ? 34.sp
          : isSmallTablet
              ? 36.sp
              : 38.sp;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // title
          Text(
            "❓ Question",
            style: GoogleFonts.inter(
              fontSize: titleFont,
              fontWeight: FontWeight.w700,
              color: const Color.fromRGBO(35, 131, 226, 1),
            ),
          ),

          // question
          SizedBox(
            height: 15.h,
          ),
          HtmlContent(
            htmlContent: question?.questionText ?? "",
            textStyle: GoogleFonts.inter(
              fontSize: questionFont,
              color: const Color.fromRGBO(52, 74, 106, 1),
            ),
          ),

          // question image
          if (question?.questionImage != null && question?.questionImage != "")
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 30.h,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.r),
                  child: Image.network(
                    question?.questionImage ?? "",
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),

          // answers
          SizedBox(
            height: 40.h,
          ),
          ...question!.options.map((option) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                GestureDetector(
                  onTap: () {
                    if (!sideDone) {
                      quizController.answerCurrentQuestion(option.id);
                    }
                  },
                  child: lessonQuestionResponse(
                    option.text,
                    option.id == question.userAnswerId,
                    image: option.image ?? "",
                  ),
                ),
                SizedBox(
                  height: 25.h,
                ),
              ],
            );
          }),

          // bottom
          SizedBox(
            height: 100.h,
          ),
        ],
      );
    },
  );
}
