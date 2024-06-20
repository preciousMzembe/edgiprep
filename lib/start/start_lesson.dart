import 'package:edgiprep/controllers/current_lesson_controller.dart';
import 'package:edgiprep/controllers/current_quiz_controller.dart';
import 'package:edgiprep/lessonTabs/lessonTab.dart';
import 'package:edgiprep/start/start_content.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class StartLesson extends StatelessWidget {
  final String topic;
  final bool lessonDone;
  const StartLesson({super.key, required this.topic, required this.lessonDone});

  @override
  Widget build(BuildContext context) {
    // set quiz data
    CurrentLessonController currentLessonController =
        Get.find<CurrentLessonController>();
    // reset first
    currentLessonController.resetQuiz();
    currentLessonController.emptyWrongQuestions();
    // set title
    currentLessonController.setTitle(topic);
    // questions
    currentLessonController.setSampleQuetions();

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 30.w,
            vertical: 20.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // close
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(
                      FontAwesomeIcons.xmark,
                      size: 40.h,
                    ),
                  ),
                ],
              ),
              // body
              Expanded(
                child: StartContent(
                  image: "images/learn2.png",
                  message: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        text: lessonDone
                            ? "Review on \n"
                            : "Ready to Practice on \n",
                        style: GoogleFonts.nunito(
                          fontSize: 35.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                            text: topic,
                            style: GoogleFonts.nunito(
                                fontSize: 35.sp,
                                fontWeight: FontWeight.w900,
                                color: primaryColor),
                          ),
                          if (!lessonDone) TextSpan(text: "?"),
                        ]),
                  ),
                ),
              ),

              // continue
              GestureDetector(
                onTap: () {
                  Get.to(() => const LessonTab());
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100.r),
                  child: Container(
                    color: primaryColor,
                    height: 100.h,
                    child: Center(
                      child: Text(
                        "Continue",
                        style: GoogleFonts.nunito(
                          color: Colors.white,
                          fontSize: 40.sp,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
