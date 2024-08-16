import 'package:edgiprep/PaperTabs/paperTab.dart';
import 'package:edgiprep/controllers/current_paper_controller.dart';
import 'package:edgiprep/start/start_content.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:edgiprep/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class StartPaper extends StatelessWidget {
  final Map paper;
  const StartPaper({
    super.key,
    required this.paper,
  });

  @override
  Widget build(BuildContext context) {
    // set quiz data
    CurrentPaperController currentPaperController =
        Get.find<CurrentPaperController>();
    // reset first
    currentPaperController.resetQuiz();
    currentPaperController.emptyWrongQuestions();
    // set title
    currentPaperController.setTitle(paper['paperName']);

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
                      text: "Practice \n ${paper['paperName']}",
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
                  currentPaperController.setPaperError(false);
                  showLoadingDialog(context, "Preparing Questions",
                      "Please wait while we load paper questions. This will only take a moment.");

                  await currentPaperController
                      .getPaperQuestions(paper['paperId']);
                  Navigator.pop(context);

                  if (currentPaperController.paperError) {
                    showErrorLoading(context);
                  } else {
                    Get.to(() => const PaperTab());
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
