import 'package:edgiprep/controllers/user_enrollment/user_enrollment_controller.dart';
import 'package:edgiprep/db/past_paper/past_paper.dart';
import 'package:edgiprep/db/subject/user_subject.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:edgiprep/views/components/appraisal/appraisal_heading.dart';
import 'package:edgiprep/views/components/appraisal/appraisal_test_subtitle.dart';
import 'package:edgiprep/views/components/appraisal/appraisal_test_title.dart';
import 'package:edgiprep/views/components/appraisal/subject_paper.dart';
import 'package:edgiprep/views/components/general/loading_content.dart';
import 'package:edgiprep/views/components/general/no_data_content.dart';
import 'package:edgiprep/views/components/search/subject_search_input.dart';
import 'package:edgiprep/views/components/subjects/subjects_back.dart';
import 'package:edgiprep/views/screens/appraisal/test_details.dart';
import 'package:edgiprep/views/screens/subjects/load_slides.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  List<PastPaper> filteredPapers = [];

  TextEditingController searchController = TextEditingController();

  bool loading = true;

  Future<void> _fetchSubjectPapers() async {
    var data =
        await userEnrollmentController.fetchSubjectPapers(widget.subject.id);

    if (mounted) {
      setState(() {
        papers = data;
        loading = false;
      });
    }
  }

  void search() {
    String query = searchController.text.toLowerCase();
    filteredPapers = papers.where((paper) {
      return paper.name.toLowerCase().contains(query);
    }).toList();

    setState(() {
      filteredPapers = filteredPapers;
    });
  }

  @override
  void initState() {
    super.initState();

    searchController.addListener(() {
      search();
    });

    _fetchSubjectPapers();
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getBackgroundColorFromString(widget.subject.color),
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
                    color: getBackgroundColorFromString(widget.subject.color),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: subjectsBack(Colors.white),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        appraisalTestTitle(
                          widget.subject.title,
                          Colors.white,
                        ),
                        appraisalTestSubtitle(
                            "Dive into ${widget.subject.title} past papers",
                            const Color.fromRGBO(236, 239, 245, 1)),
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
                        // Loading
                        if (loading)
                          loadingContent("Getting Subject Papers",
                              "Be patient while we get past papers ready for you."),

                        if (!loading &&
                            papers.isEmpty &&
                            searchController.text.isEmpty)
                          noDataContent("No Papers Found",
                              "There were no papers found for this subject. Please check back later."),
                        if (papers.isNotEmpty && searchController.text.isEmpty)
                          Column(
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
                                return Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Get.to(() => TestDetails(
                                              subject: widget.subject,
                                              pastPaper: paper,
                                            ));
                                      },
                                      child: subjectPaper(
                                        paper.name,
                                        paper.questions,
                                        paper.duration,
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

                        // Search Results
                        if (searchController.text.isNotEmpty)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              if (filteredPapers.isNotEmpty)
                                Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15.w),
                                      child: appraisalHeading("Search Results"),
                                    ),
                                    SizedBox(
                                      height: 25.h,
                                    ),
                                  ],
                                ),
                              ...filteredPapers.map((paper) {
                                return Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Get.to(
                                          () => LoadSlides(
                                            title: "Preparing Your Paper",
                                            message:
                                                "Get ready to dive in! Your paper is loading, and we're setting everything up for you.",
                                            type: "paper",
                                            testId: paper.id,
                                            duration: paper.duration,
                                          ),
                                        );
                                      },
                                      child: subjectPaper(
                                        paper.name,
                                        paper.questions,
                                        paper.duration,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 25.h,
                                    ),
                                  ],
                                );
                              }),
                              if (filteredPapers.isEmpty)
                                noDataContent("No Results Found",
                                    "There were no papers found for your search."),
                            ],
                          ),
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 30.w,
                            vertical: 30.h,
                          ),
                          color: getBackgroundColorFromString(
                              widget.subject.color),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Get.back();
                                    },
                                    child: subjectsBack(Colors.white),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              appraisalTestTitle(
                                widget.subject.title,
                                Colors.white,
                              ),
                              appraisalTestSubtitle(
                                "Dive into ${widget.subject.title} past papers",
                                const Color.fromRGBO(236, 239, 245, 1),
                              ),
                              SizedBox(
                                height: 40.h,
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 40.h,
                        )
                      ],
                    ),

                    // search
                    Positioned(
                      bottom: 0.h,
                      left: 0,
                      right: 0,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30.w),
                        child: Row(
                          children: [
                            Expanded(
                              child: SubjectSearchInput(
                                controller: searchController,
                                label: "Search Past Paper",
                                type: TextInputType.text,
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
