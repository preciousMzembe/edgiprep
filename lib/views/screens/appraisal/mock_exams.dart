import 'package:edgiprep/controllers/user_enrollment/user_enrollment_controller.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:edgiprep/views/components/appraisal/appraisal_back_button.dart';
import 'package:edgiprep/views/components/appraisal/appraisal_heading.dart';
import 'package:edgiprep/views/components/appraisal/appraisal_image.dart';
import 'package:edgiprep/views/components/appraisal/appraisal_test_subtitle.dart';
import 'package:edgiprep/views/components/appraisal/appraisal_test_title.dart';
import 'package:edgiprep/views/components/appraisal/mock_subject.dart';
import 'package:edgiprep/views/screens/appraisal/subject_mocks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MockExams extends StatelessWidget {
  const MockExams({super.key});

  @override
  Widget build(BuildContext context) {
    UserEnrollmentController userEnrollmentController =
        Get.find<UserEnrollmentController>();

    return Scaffold(
      backgroundColor: const Color.fromRGBO(117, 80, 245, 1),
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
                  color: const Color.fromRGBO(226, 226, 245, 1),
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
                              "Mock Exams",
                              const Color.fromRGBO(117, 80, 245, 1),
                            ),
                            appraisalTestSubtitle(
                              "Simulate real exam conditions to assess your readiness.",
                              const Color.fromRGBO(92, 101, 120, 1),
                            ),
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
                          child: appraisalHeading("Available Exams"),
                        ),

                        // subjects
                        SizedBox(
                          height: 20.h,
                        ),
                        ...userEnrollmentController.subjects.map((subject) {
                          int mocksCount = userEnrollmentController
                              .getSubjectMocksCount(subject.id);
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Get.to(() => SubjectMocks(subject: subject));
                                },
                                child: mockSubject(
                                  getColorFromString(subject.color),
                                  subject.icon,
                                  subject.title,
                                  mocksCount,
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
                        )
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
