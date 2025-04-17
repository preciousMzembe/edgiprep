import 'package:edgiprep/utils/constants.dart';
import 'package:edgiprep/utils/device_utils.dart';
import 'package:edgiprep/views/components/appraisal/appraisal_fade_text.dart';
import 'package:edgiprep/views/components/appraisal/appraisal_test_option.dart';
import 'package:edgiprep/views/components/subjects/subjects_title.dart';
import 'package:edgiprep/views/screens/appraisal/challenges.dart';
import 'package:edgiprep/views/screens/appraisal/mock_exams.dart';
import 'package:edgiprep/views/screens/appraisal/past_papers.dart';
import 'package:edgiprep/views/screens/appraisal/quizzes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Appraisal extends StatelessWidget {
  const Appraisal({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map> appraisalTypes = [
      {
        "icon": "weight.svg",
        "name": "Mock Exams",
        "description":
            "Simulate real exam conditions to assess your readiness.",
        "backgroundColor": const Color.fromRGBO(117, 80, 245, 1),
        "iconBackgroundColor": const Color.fromRGBO(197, 181, 251, 1),
      },
      {
        "icon": "ideas.svg",
        "name": "Quizzes",
        "description":
            "Test your knowledge on key subject and track your improvement.",
        "backgroundColor": const Color.fromRGBO(35, 131, 226, 1),
        "iconBackgroundColor": const Color.fromRGBO(163, 203, 243, 1),
      },
      {
        "icon": "diamond.svg",
        "name": "Past Papers",
        "description": "Review and practice with actual exam papers.",
        "backgroundColor": const Color.fromRGBO(35, 131, 226, 1),
        "iconBackgroundColor": const Color.fromRGBO(163, 203, 243, 1),
      },
      {
        "icon": "star.svg",
        "name": "Challenges",
        "description":
            "Push yourself with unlimited challenges to sharpen your skills.",
        "backgroundColor": const Color.fromRGBO(85, 194, 103, 1),
        "iconBackgroundColor": const Color.fromRGBO(184, 229, 191, 1),
      },
    ];
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isTablet = DeviceUtils.isTablet(context);
        bool isSmallTablet = DeviceUtils.isSmallTablet(context);

        double horizontalPadding = isTablet
            ? 30.w
            : isSmallTablet
                ? 30.w
                : 30.w;
        return Scaffold(
          backgroundColor: appbarColor,
          body: SafeArea(
            child: Container(
              color: backgroundColor,
              child: ListView(
                children: [
                  SizedBox(
                    height: 30.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        subjectsTitle("Test"),
                        SizedBox(
                          height: 15.h,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: appraisalFadeText(
                                "Unlock Your Knowledge Potential! Achieve Your Best Results",
                              ),
                            ),
                            SizedBox(
                              width: 200.w,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),

                  // test option
                  SizedBox(
                    height: 50.h,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: horizontalPadding),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 30.r,
                        mainAxisSpacing: 30.r,
                        childAspectRatio: 2 / 2.5,
                      ),
                      itemCount: appraisalTypes.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            if (appraisalTypes[index]['name'] == "Mock Exams") {
                              Get.to(() => const MockExams());
                            } else if (appraisalTypes[index]['name'] ==
                                "Past Papers") {
                              Get.to(() => const PastPapers());
                            } else if (appraisalTypes[index]['name'] ==
                                "Quizzes") {
                              Get.to(() => const Quizzes());
                            } else {
                              Get.to(() => const Challenges());
                            }
                          },
                          child: appraisalTestOption(
                            context,
                            appraisalTypes[index]['icon'],
                            appraisalTypes[index]['name'],
                            appraisalTypes[index]['description'],
                            appraisalTypes[index]['backgroundColor'],
                            appraisalTypes[index]['iconBackgroundColor'],
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 100.h,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
