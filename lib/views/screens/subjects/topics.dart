import 'package:edgiprep/db/subject/user_subject.dart';
import 'package:edgiprep/db/topic/topic.dart';
import 'package:edgiprep/db/unit/unit.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:edgiprep/views/components/general/no_data_content.dart';
import 'package:edgiprep/views/components/subject/subject_topic_box.dart';
import 'package:edgiprep/views/components/subject/subject_unit_name.dart';
import 'package:edgiprep/views/screens/subjects/topic.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SubjectTopics extends StatelessWidget {
  final UserSubject subject;
  final Map<Unit, List<Topic>> unitTopicMap;
  final Function fetchUnitsAndTopics;
  const SubjectTopics(
      {super.key,
      required this.unitTopicMap,
      required this.subject,
      required this.fetchUnitsAndTopics});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        child: ListView(
          children: [
            SizedBox(
              height: 30.h,
            ),

            // data
            if (unitTopicMap.isEmpty)
              noDataContent("No Topics Found",
                  "There were no topics found for this subject. Please check back later."),
            ...unitTopicMap.entries.map((entry) {
              return entry.value.isNotEmpty
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          height: 10.h,
                        ),
                        // unit
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 14.w),
                          child: subjectUnitName(entry.key.name),
                        ),
                        SizedBox(
                          height: 25.h,
                        ),
                        ...entry.value.map((topic) {
                          double percent = 0;

                          if (topic.numberOfLessons > 0) {
                            // calculate percent
                            percent = topic.numberOfLessonsDone /
                                topic.numberOfLessons;
                          }
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  if (topic.active && !topic.needSubscrion) {
                                    await Get.to(() => SubjectTopic(
                                          subject: subject,
                                          topic: topic,
                                        ));

                                    fetchUnitsAndTopics();
                                  }
                                },
                                child: subjectTopicBox(
                                  topic.needSubscrion,
                                  topic.active,
                                  topic.name,
                                  "${topic.numberOfLessonsDone} of ${topic.numberOfLessons} Lessons",
                                  percent,
                                ),
                              ),
                              SizedBox(
                                height: 30.h,
                              ),
                            ],
                          );
                        }),
                      ],
                    )
                  : SizedBox();
            }),

            SizedBox(
              height: 100.h,
            )
          ],
        ),
      ),
    );
  }
}
