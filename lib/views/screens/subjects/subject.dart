import 'package:edgiprep/controllers/user_enrollment/user_enrollment_controller.dart';
import 'package:edgiprep/db/subject/user_subject.dart';
import 'package:edgiprep/db/topic/topic.dart';
import 'package:edgiprep/db/unit/unit.dart';
import 'package:edgiprep/services/enrollment/user_enrollment_service.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:edgiprep/views/components/general/no_data_content.dart';
import 'package:edgiprep/views/components/subject/subject_nav_option.dart';
import 'package:edgiprep/views/components/subject/subject_subject_description.dart';
import 'package:edgiprep/views/components/subject/subject_subject_image.dart';
import 'package:edgiprep/views/components/subject/subject_subject_name.dart';
import 'package:edgiprep/views/components/subject/subject_topic_box.dart';
import 'package:edgiprep/views/components/subject/subject_unit_name.dart';
import 'package:edgiprep/views/components/subjects/subjects_back.dart';
import 'package:edgiprep/views/screens/subjects/subject_settings.dart';
import 'package:edgiprep/views/screens/subjects/topic.dart';
import 'package:edgiprep/views/screens/subjects/topics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Subject extends StatefulWidget {
  final UserSubject subject;
  const Subject({
    super.key,
    required this.subject,
  });

  @override
  State<Subject> createState() => _SubjectState();
}

class _SubjectState extends State<Subject> {
  UserEnrollmentController userEnrollmentController =
      Get.find<UserEnrollmentController>();

  UserEnrollmentService userEnrollmentService =
      Get.find<UserEnrollmentService>();

  Map<Unit, List<Topic>> unitTopicMap = {};

  List<String> navOptions = [
    "Learn",
    "Settings",
  ];

  String selectedTitle = "Learn";

  void changeSelected(String title) {
    setState(() {
      selectedTitle = title;
    });
  }

  Future<void> _fetchUnitsAndTopics() async {
    var data = await userEnrollmentController
        .fetchUnitsAndTopics(widget.subject.enrollmentId);

    if (mounted) {
      setState(() {
        unitTopicMap = data;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    // Fetch units and topics
    _fetchUnitsAndTopics();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getBackgroundColorFromString(widget.subject.color),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // top
            Stack(
              children: [
                Positioned(
                  top: -90.r,
                  right: -90.r,
                  child: subjectSubjectImage(
                    widget.subject.icon,
                    getColorFromString(widget.subject.color),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(30.w),
                  color: Colors.transparent,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // back
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

                      // subject
                      SizedBox(
                        height: 25.h,
                      ),
                      subjectSubjectName(widget.subject.title),

                      // description
                      SizedBox(
                        height: 20.h,
                      ),
                      subjectSubjectDescription(
                          "Dive into engaging lessons, quizzes, and more to enhance your understanding."),

                      // navigation
                      SizedBox(
                        height: 40.h,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            ...navOptions.map(
                              (text) => ClipRRect(
                                borderRadius: BorderRadius.circular(30.r),
                                child: GestureDetector(
                                  onTap: () {
                                    changeSelected(text);
                                  },
                                  child: subjectNavOption(
                                    text,
                                    selectedTitle == text
                                        ? const Color.fromRGBO(
                                            52, 74, 106, 0.33)
                                        : Colors.transparent,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // topics and settings
            Expanded(
              child: selectedTitle == "Learn"
                  ? SubjectTopics(
                      subject: widget.subject,
                      unitTopicMap: unitTopicMap,
                      fetchUnitsAndTopics: _fetchUnitsAndTopics,
                    )
                  : SubjectSettings(
                      subject: widget.subject,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
