import 'package:edgiprep/controllers/subjects_settings_controller.dart';
import 'package:edgiprep/controllers/user_controller.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SubjectsSettings extends StatelessWidget {
  const SubjectsSettings({super.key});

  @override
  Widget build(BuildContext context) {
    UserController userController = Get.find<UserController>();
    SubjectsSettingsController subjectsSettingsController =
        Get.find<SubjectsSettingsController>();

    return Obx(() {
      return Scaffold(
        backgroundColor: backgroundColor,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 30.w,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // body
                Expanded(
                  child: ListView(
                    children: [
                      SizedBox(
                        height: 30.h,
                      ),
                      Text(
                        "Manage Your \nSubjects",
                        style: GoogleFonts.nunito(
                          fontSize: 70.sp,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const Text(
                          "Choose the subjects you're preparing for to have your customized lessons."),
                      SizedBox(
                        height: 40.h,
                      ),
                      Text(
                        "${userController.currentExam['examName']} Subjects",
                        style: GoogleFonts.nunito(
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 20,
                          childAspectRatio: 1,
                        ),
                        itemCount:
                            subjectsSettingsController.allSubjects.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              // add/remove user subjects
                              subjectsSettingsController
                                  .addRemoveSelectedSubjects(
                                      subjectsSettingsController
                                          .allSubjects[index]);

                              print(subjectsSettingsController
                                  .selectedSubjects.length);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: subjectsSettingsController
                                        .selectedSubjects
                                        .contains(subjectsSettingsController
                                            .allSubjects[index])
                                    ? const Color.fromRGBO(47, 59, 98, 0.123)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(40.r),
                                border: Border.all(
                                  width: 1,
                                  color: subjectsSettingsController
                                          .selectedSubjects
                                          .contains(subjectsSettingsController
                                              .allSubjects[index])
                                      ? primaryColor
                                      : const Color.fromRGBO(47, 59, 98, 0.523),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    // indicator
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        ClipOval(
                                          child: Container(
                                            width: 30,
                                            height: 30,
                                            color: subjectsSettingsController
                                                    .selectedSubjects
                                                    .contains(
                                                        subjectsSettingsController
                                                            .allSubjects[index])
                                                ? primaryColor
                                                : const Color.fromRGBO(
                                                    47, 59, 98, 0.523),
                                            child: Icon(
                                              FontAwesomeIcons.check,
                                              size: 15,
                                              color: subjectsSettingsController
                                                      .selectedSubjects
                                                      .contains(
                                                          subjectsSettingsController
                                                                  .allSubjects[
                                                              index])
                                                  ? Colors.white
                                                  : const Color.fromARGB(
                                                      99, 255, 255, 255),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                    // subject
                                    Expanded(
                                      child: Center(
                                        child: Text(
                                          subjectsSettingsController
                                                  .allSubjects[index]
                                              ['subjectName'],
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.nunito(
                                            color: subjectsSettingsController
                                                    .selectedSubjects
                                                    .contains(
                                                        subjectsSettingsController
                                                            .allSubjects[index])
                                                ? primaryColor
                                                : const Color.fromRGBO(
                                                    47, 59, 98, 0.523),
                                            fontSize: 20,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),

                      // bottom
                      const SizedBox(
                        height: 80,
                      ),
                    ],
                  ),
                ),

                // continue button
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        // back
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(40.r),
                            child: Container(
                              color: grayColor,
                              height: 95.h,
                              width: 95.h,
                              child: Center(
                                child: Icon(
                                  FontAwesomeIcons.arrowLeft,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                          ),
                        ),

                        // continue
                        const SizedBox(
                          width: 20,
                        ),
                        if (subjectsSettingsController
                            .selectedSubjects.isNotEmpty)
                          Expanded(
                            child: GestureDetector(
                              onTap: () {},
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(40.r),
                                child: Container(
                                  color: primaryColor,
                                  height: 95.h,
                                  child: Center(
                                    child: Text(
                                      "Update",
                                      style: GoogleFonts.nunito(
                                        color: Colors.white,
                                        fontSize: 35.sp,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
