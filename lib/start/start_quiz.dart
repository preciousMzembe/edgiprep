import 'package:edgiprep/controllers/current_quiz_controller.dart';
import 'package:edgiprep/quizTabs/quizTab.dart';
import 'package:edgiprep/start/start_content.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:edgiprep/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class StartQuiz extends StatelessWidget {
  final Map subject;
  const StartQuiz({super.key, required this.subject});

  @override
  Widget build(BuildContext context) {
    // set quiz data
    CurrentQuizController currentQuizController =
        Get.find<CurrentQuizController>();
    // reset first
    currentQuizController.resetQuiz();
    currentQuizController.setCorrectionRound(false);
    currentQuizController.emptyWrongQuestions();
    // set title
    currentQuizController.setTitle(subject['subjectName']);
    // questions
    // currentQuizController.setSampleQuetions();

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
                      text: "Let's See How Much \n You Remember",
                      style: GoogleFonts.nunito(
                        fontSize: 35.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),

              // continue
              GestureDetector(
                onTap: () async {
                  currentQuizController.setQuizError(false);
                  showLoadingDialog(context, "Preparing Your Quiz",
                      "Please wait while we load your personalized quiz. This will only take a moment.");

                  await currentQuizController.createQuiz(subject['subjectId']);
                  Navigator.pop(context);

                  if (currentQuizController.quizError) {
                    showErrorLoading(context);
                  } else {
                    Get.to(() => const QuizTab());
                  }
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
