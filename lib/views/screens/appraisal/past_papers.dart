import 'package:edgiprep/controllers/user%20enrollment/user_enrollment_controller.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:edgiprep/views/components/appraisal/appraisal_back_button.dart';
import 'package:edgiprep/views/components/appraisal/appraisal_heading.dart';
import 'package:edgiprep/views/components/appraisal/appraisal_image.dart';
import 'package:edgiprep/views/components/appraisal/appraisal_test_subtitle.dart';
import 'package:edgiprep/views/components/appraisal/appraisal_test_title.dart';
import 'package:edgiprep/views/components/appraisal/papers_subject.dart';
import 'package:edgiprep/views/screens/appraisal/subject_papers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PastPapers extends StatelessWidget {
  const PastPapers({super.key});

  @override
  Widget build(BuildContext context) {
    UserEnrollmentController userEnrollmentController =
        Get.find<UserEnrollmentController>();

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
                              "Past Papers",
                              const Color.fromRGBO(35, 131, 226, 1),
                            ),
                            appraisalTestSubtitle(
                                "Review and practice with actual exam papers."),
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
              // body
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  child: ListView(
                    children: [
                      SizedBox(
                        height: 30.h,
                      ),
                      // heading
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        child: appraisalHeading("Available Papers"),
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
                                Get.to(() => SubjectPapers(
                                      subject: subject,
                                    ));
                              },
                              child: papersSubject(
                                getColorFromString(subject.color),
                                subject.icon,
                                subject.title,
                                "3/3",
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
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
