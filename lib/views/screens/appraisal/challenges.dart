import 'package:edgiprep/controllers/user%20enrollment/user_enrollment_controller.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:edgiprep/views/components/appraisal/appraisal_back_button.dart';
import 'package:edgiprep/views/components/appraisal/appraisal_heading.dart';
import 'package:edgiprep/views/components/appraisal/appraisal_image.dart';
import 'package:edgiprep/views/components/appraisal/appraisal_test_subtitle.dart';
import 'package:edgiprep/views/components/appraisal/appraisal_test_title.dart';
import 'package:edgiprep/views/components/appraisal/challenge_subject.dart';
import 'package:edgiprep/views/screens/subjects/load_slides.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Challenges extends StatelessWidget {
  const Challenges({super.key});

  @override
  Widget build(BuildContext context) {
    UserEnrollmentController userEnrollmentController =
        Get.find<UserEnrollmentController>();

    return Scaffold(
      backgroundColor: const Color.fromRGBO(85, 194, 103, 1),
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
                  color: const Color.fromARGB(255, 218, 240, 222),
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
                              "Challenges",
                              const Color.fromRGBO(85, 194, 103, 1),
                            ),
                            appraisalTestSubtitle(
                                "Push yourself with unlimited challenges to sharpen your skills."),
                          ],
                        ),
                      ),

                      // image
                      SizedBox(
                        width: 50.w,
                      ),
                      appraisalImage("paper.png"),
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
                          child: appraisalHeading("Available Challenges"),
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
                                  Get.to(() => const LoadSlides(
                                        title: "Preparing Your Challenge...",
                                        message:
                                            "Get ready to dive in! Your challenge is loading, and we're setting everything up for you.",
                                        type: "challenge",
                                      ));
                                },
                                child: challengeSubject(
                                  getColorFromString(subject.color),
                                  subject.icon,
                                  subject.title,
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
