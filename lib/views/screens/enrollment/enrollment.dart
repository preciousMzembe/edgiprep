import 'package:edgiprep/views/components/enrollment/enrollment_exam_option.dart';
import 'package:edgiprep/views/components/enrollment/enrollment_rich_text.dart';
import 'package:edgiprep/views/components/enrollment/enrollment_subtitle.dart';
import 'package:edgiprep/views/components/enrollment/enrollment_title.dart';
import 'package:edgiprep/views/components/general/normal_button.dart';
import 'package:edgiprep/controllers/enrollment/enrollment_controller.dart';
import 'package:edgiprep/views/screens/enrollment/subjects_enrollment.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:edgiprep/utils/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Enrollment extends StatefulWidget {
  const Enrollment({super.key});

  @override
  State<Enrollment> createState() => _EnrollmentState();
}

class _EnrollmentState extends State<Enrollment> {
  EnrollmentController enrollmentController = Get.find<EnrollmentController>();

  @override
  void initState() {
    super.initState();

    enrollmentController.fetchExams();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isTablet = DeviceUtils.isTablet(context);
        bool isSmallTablet = DeviceUtils.isSmallTablet(context);

        double horizontalPadding = isTablet
            ? 100.w
            : isSmallTablet
                ? 80.w
                : 30.w;

        return Scaffold(
          backgroundColor: appbarColor,
          body: SafeArea(
            child: Container(
              color: backgroundColor,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 50.w,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: 40.h,
                    ),
                    // title
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.w),
                      child: enrollmentTitle(
                          "Choose Your Exam Category to Get Started"),
                    ),

                    // subtitle
                    SizedBox(
                      height: 20.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.w),
                      child: enrollmentSubtitle(
                        "Please select the exam category you're preparing for to access tailored lessons and quizzes.",
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Expanded(
                      child: ListView(
                        children: [
                          // exams options
                          SizedBox(
                            height: 20.h,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: horizontalPadding),
                            child: Obx(() {
                              return GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 30.r,
                                  mainAxisSpacing: 30.r,
                                  childAspectRatio: 2 / 2.5,
                                ),
                                itemCount: enrollmentController.exams.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      enrollmentController.selectExam(
                                          enrollmentController
                                              .exams[index].name);
                                    },
                                    child: enrollmentExamOption(
                                      context,
                                      enrollmentController
                                          .exams[index].selected,
                                      enrollmentController.exams[index].name,
                                    ),
                                  );
                                },
                              );
                            }),
                          ),

                          SizedBox(
                            height: 50.h,
                          ),
                        ],
                      ),
                    ),

                    // not sure text
                    SizedBox(
                      height: 20.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 50.w),
                      child: enrollmentRichText(
                        "Not sure which one to choose? ",
                        [
                          TextSpan(
                            text: "Learn more ",
                            style: GoogleFonts.inter(
                              color: primaryColor,
                            ),
                          ),
                          const TextSpan(text: "about each category. "),
                        ],
                      ),
                    ),

                    // continue
                    SizedBox(
                      height: 35.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (enrollmentController.examSelected.value) {
                          Get.to(() => const SubjectsEnrollment());
                        }
                      },
                      child: Obx(() {
                        return normalButton(
                          enrollmentController.examSelected.value
                              ? primaryColor
                              : unselectedButtonColor,
                          enrollmentController.examSelected.value
                              ? Colors.white
                              : Colors.black,
                          "Continue",
                          16,
                        );
                      }),
                    ),
                    SizedBox(
                      height: 50.h,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
