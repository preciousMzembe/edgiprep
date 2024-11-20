import 'package:edgiprep/controllers/user%20enrollment/user_enrollment_controller.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:edgiprep/views/components/general/normal_input.dart';
import 'package:edgiprep/views/components/subjects/subjects_add_subject.dart';
import 'package:edgiprep/views/components/subjects/subjects_option_button.dart';
import 'package:edgiprep/views/components/subjects/subjects_subject_box.dart';
import 'package:edgiprep/views/components/subjects/subjects_title.dart';
import 'package:edgiprep/views/screens/settings/enrollment_settings.dart';
import 'package:edgiprep/views/screens/subjects/subject.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Subjects extends StatelessWidget {
  const Subjects({super.key});

  @override
  Widget build(BuildContext context) {
    UserEnrollmentController userEnrollmentController =
        Get.find<UserEnrollmentController>();

    final GlobalKey optionsButtonKey = GlobalKey();

    return Scaffold(
      backgroundColor: appbarColor,
      body: SafeArea(
        child: Container(
          color: backgroundColor,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: Obx(() {
              return ListView(
                children: [
                  SizedBox(
                    height: 30.h,
                  ),
                  // options
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        key: optionsButtonKey,
                        onTap: () async {
                          final RenderBox button = optionsButtonKey
                              .currentContext!
                              .findRenderObject() as RenderBox;
                          final Offset buttonPosition =
                              button.localToGlobal(Offset.zero);

                          final result = await showMenu<String>(
                            context: context,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            position: RelativeRect.fromLTRB(
                              buttonPosition.dx,
                              buttonPosition.dy + button.size.height + 10.h,
                              30.w,
                              0,
                            ),
                            items: [
                              PopupMenuItem(
                                value: 'Option 1',
                                height: 60.h,
                                child: Text(
                                  'Option 1',
                                  style: GoogleFonts.inter(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              PopupMenuItem(
                                value: 'Option 2',
                                height: 60.h,
                                child: Text(
                                  'Option 2',
                                  style: GoogleFonts.inter(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              PopupMenuItem(
                                value: 'Option 3',
                                height: 60.h,
                                child: Text(
                                  'Option 3',
                                  style: GoogleFonts.inter(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                            elevation: 8.0,
                          );

                          if (result != null) {
                            print('Selected: $result');
                          }
                        },
                        child: subjectsOptionsButton(),
                      ),
                    ],
                  ),

                  // title
                  subjectsTitle("Subjects"),

                  // search
                  SizedBox(
                    height: 30.h,
                  ),
                  const NormalInput(
                    label: "Search Subjects",
                    type: TextInputType.text,
                    isPassword: false,
                    icon: FontAwesomeIcons.magnifyingGlass,
                    radius: 16,
                  ),

                  // Subjects
                  SizedBox(
                    height: 40.h,
                  ),
                  ...userEnrollmentController.subjects.map((subject) {
                    double percent = 0;

                    if (subject.numberOfTopics > 0) {
                      percent =
                          subject.numberOfTopicsDone / subject.numberOfTopics;
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.to(() => Subject(
                                  subject: subject,
                                ));
                          },
                          child: subjectsSubjectBox(
                            getFadeColorFromString(subject.color),
                            subject.image,
                            subject.title,
                            subject.currentTopic,
                            "${subject.numberOfTopicsDone} of ${subject.numberOfTopics} Topics",
                            percent,
                          ),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                      ],
                    );
                  }),

                  // add subject
                  if (userEnrollmentController.subjects.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          height: 40.h,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => const EnrollmentSettings());
                          },
                          child: subjectsAddSubject(),
                        ),
                      ],
                    ),

                  SizedBox(
                    height: 100.h,
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
