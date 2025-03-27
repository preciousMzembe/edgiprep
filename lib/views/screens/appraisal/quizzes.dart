import 'package:edgiprep/controllers/user_enrollment/user_enrollment_controller.dart';
import 'package:edgiprep/db/config/config.dart';
import 'package:edgiprep/services/configuration/configuration_service.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:edgiprep/views/components/appraisal/appraisal_back_button.dart';
import 'package:edgiprep/views/components/appraisal/appraisal_heading.dart';
import 'package:edgiprep/views/components/appraisal/appraisal_image.dart';
import 'package:edgiprep/views/components/appraisal/appraisal_test_subtitle.dart';
import 'package:edgiprep/views/components/appraisal/appraisal_test_title.dart';
import 'package:edgiprep/views/components/appraisal/quiz_subject.dart';
import 'package:edgiprep/views/screens/subjects/load_slides.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Quizzes extends StatefulWidget {
  const Quizzes({super.key});

  @override
  State<Quizzes> createState() => _QuizzesState();
}

class _QuizzesState extends State<Quizzes> {
  ConfigService configService = Get.find<ConfigService>();
  UserEnrollmentController userEnrollmentController =
      Get.find<UserEnrollmentController>();

  int quizQuestions = 5;

  Future<void> getConfigValues() async {
    Config? config = await configService.getConfig();

    setState(() {
      quizQuestions = config!.quizQuestions;
    });
  }

  @override
  void initState() {
    getConfigValues();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(35, 131, 226, 1),
      // backgroundColor: backgroundColor,
      body: SafeArea(
        child: Container(
          color: backgroundColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // top
              ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40.r),
                  bottomRight: Radius.circular(40.r),
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 30.w,
                    vertical: 30.h,
                  ),
                  color: const Color.fromRGBO(220, 230, 243, 1),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // back and details
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: appraisalBackButton(),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 60.h,
                            ),
                            appraisalTestTitle(
                              "Quizzes",
                              const Color.fromRGBO(35, 131, 226, 1),
                            ),
                            appraisalTestSubtitle(
                                "Test your knowledge on key subject and track your improvement."),
                          ],
                        ),
                      ),

                      // image
                      SizedBox(
                        width: 50.w,
                      ),
                      appraisalImage("mock.png"),
                    ],
                  ),
                ),
              ),

              // body
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  child: Obx(() {
                    return ListView(
                      children: [
                        SizedBox(
                          height: 30.h,
                        ),
                        // heading
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          child: appraisalHeading("Available Quizzes"),
                        ),

                        // subjects
                        SizedBox(
                          height: 20.h,
                        ),

                        ...userEnrollmentController.subjects.map((subject) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Get.to(() => LoadSlides(
                                        title: "Preparing Your Quiz...",
                                        message:
                                            "Get ready to dive in! Your quiz is loading, and we're setting everything up for you.",
                                        type: "quiz",
                                        subject: subject,
                                      ));
                                },
                                child: quizSubject(
                                  getColorFromString(subject.color),
                                  subject.icon,
                                  subject.title,
                                  quizQuestions,
                                ),
                              ),
                              SizedBox(
                                height: 30.h,
                              ),
                            ],
                          );
                        }),

                        SizedBox(
                          height: 100.h,
                        ),
                      ],
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
