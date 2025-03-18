import 'package:edgiprep/controllers/user_enrollment/user_enrollment_controller.dart';
import 'package:edgiprep/db/past%20paper/past_paper.dart';
import 'package:edgiprep/db/subject/user_subject.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:edgiprep/views/components/appraisal/appraisal_back_button.dart';
import 'package:edgiprep/views/components/appraisal/appraisal_heading.dart';
import 'package:edgiprep/views/components/appraisal/appraisal_test_subtitle.dart';
import 'package:edgiprep/views/components/appraisal/appraisal_test_title.dart';
import 'package:edgiprep/views/components/appraisal/subject_paper.dart';
import 'package:edgiprep/views/components/general/normal_input.dart';
import 'package:edgiprep/views/screens/subjects/load_slides.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class SubjectPapers extends StatefulWidget {
  final UserSubject subject;
  const SubjectPapers({super.key, required this.subject});

  @override
  State<SubjectPapers> createState() => _SubjectPapersState();
}

class _SubjectPapersState extends State<SubjectPapers> {
  UserEnrollmentController userEnrollmentController =
      Get.find<UserEnrollmentController>();
  List<PastPaper> papers = [];

  Future<void> _fetchSubjectPapers() async {
    papers =
        await userEnrollmentController.fetchSubjectPapers(widget.subject.id);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    _fetchSubjectPapers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(35, 131, 226, 1),
      // backgroundColor: backgroundColor,
      body: SafeArea(
        child: Container(
          color: backgroundColor,
          child: Stack(
            children: [
              // body
              ListView(
                children: [
                  // top copy
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 30.w,
                      vertical: 30.h,
                    ),
                    color: const Color.fromRGBO(220, 230, 243, 1),
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
                          height: 20.h,
                        ),
                        appraisalTestTitle(
                          widget.subject.title,
                          const Color.fromRGBO(35, 131, 226, 1),
                        ),
                        appraisalTestSubtitle(
                            "Dive into ${widget.subject.title} past papers"),
                        SizedBox(
                          height: 40.h,
                        )
                      ],
                    ),
                  ),

                  // actual body
                  SizedBox(
                    height: 70.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          child: appraisalHeading("Past Papers"),
                        ),
                        SizedBox(
                          height: 25.h,
                        ),
                        ...papers.map((paper) {
                          Color mainColor =
                              const Color.fromRGBO(254, 101, 93, 1);
                          Color subColor =
                              const Color.fromRGBO(254, 232, 232, 1);

                          if (paper.score >= 50) {
                            mainColor = const Color.fromRGBO(73, 161, 249, 1);
                            subColor = const Color.fromRGBO(169, 210, 251, 1);
                          }

                          if (paper.score >= 80) {
                            mainColor = const Color.fromRGBO(102, 203, 124, 1);
                            subColor =
                                const Color.fromRGBO(102, 203, 124, 0.478);
                          }

                          double percent = 0;

                          if (paper.score > 0) {
                            percent = paper.score / 100;
                          }

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Get.to(() => const LoadSlides(
                                        title: "Preparing Your Paper...",
                                        message:
                                            "Get ready to dive in! Your paper is loading, and we're setting everything up for you.",
                                        type: "paper",
                                      ));
                                },
                                child: subjectPaper(
                                  mainColor,
                                  subColor,
                                  paper.name,
                                  paper.questions,
                                  paper.duration,
                                  percent,
                                ),
                              ),
                              SizedBox(
                                height: 25.h,
                              ),
                            ],
                          );
                        }),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: 100.h,
                  )
                ],
              ),

              // top
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 30.w,
                        vertical: 30.h,
                      ),
                      color: const Color.fromRGBO(220, 230, 243, 1),
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
                            height: 20.h,
                          ),
                          appraisalTestTitle(
                            widget.subject.title,
                            const Color.fromRGBO(35, 131, 226, 1),
                          ),
                          appraisalTestSubtitle(
                              "Dive into ${widget.subject.title} past papers"),
                          SizedBox(
                            height: 40.h,
                          )
                        ],
                      ),
                    ),

                    // search
                    Positioned(
                      bottom: -40.h,
                      left: 0,
                      right: 0,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30.w),
                        child: const Row(
                          children: [
                            Expanded(
                              child: NormalInput(
                                label: "Search Pasr Paper",
                                type: TextInputType.text,
                                isPassword: false,
                                icon: FontAwesomeIcons.magnifyingGlass,
                                radius: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
