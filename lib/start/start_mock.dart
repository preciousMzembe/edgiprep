import 'package:edgiprep/controllers/current_mock_controller.dart';
import 'package:edgiprep/mockTabs/mockTab.dart';
import 'package:edgiprep/start/start_content.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:edgiprep/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class StartMock extends StatelessWidget {
  final Map subject;
  const StartMock({
    super.key,
    required this.subject,
  });

  @override
  Widget build(BuildContext context) {
    // set quiz data
    CurrentMockController currentMockController =
        Get.find<CurrentMockController>();
    // reset first
    currentMockController.resetQuiz();
    currentMockController.emptyWrongQuestions();
    // set title
    currentMockController.setTitle(subject['subjectName']);
    // questions
    // currentMockController.setSampleQuetions();

    // empty answers
    // for (int i = 0; i < currentMockController.questions.length; i++) {
    //   currentMockController.questions[i].userAnswer = "";
    // }

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
                      text: "Simulate a Real \n Exam Experience",
                      style: GoogleFonts.nunito(
                        fontSize: 35.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                      // children: [
                      //   TextSpan(
                      //     text: subject,
                      //     style: GoogleFonts.nunito(
                      //         fontSize: 35.sp,
                      //         fontWeight: FontWeight.w900,
                      //         color: primaryColor),
                      //   ),
                      // ],
                    ),
                  ),
                ),
              ),

              // continue
              GestureDetector(
                onTap: () async {
                  currentMockController.setMockError(false);
                  showLoadingDialog(context, "Preparing Questions",
                      "Please wait while we load lesson questions. This will only take a moment.");

                  await currentMockController.createMock(subject['subjectId']);
                  Navigator.pop(context);

                  if (currentMockController.mockError) {
                    showErrorLoading(context);
                  } else {
                    Get.to(() => const MockTab());
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
