import 'package:edgiprep/controllers/subjects_settings_controller.dart';
import 'package:edgiprep/controllers/user_controller.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:edgiprep/utils/helper_functions.dart';
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
                SizedBox(
                  height: 30.h,
                ),
                // top
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // back
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        width: 50.w,
                        height: 50.w,
                        color: Colors.transparent,
                        child: Icon(
                          FontAwesomeIcons.arrowLeft,
                          size: 40.w,
                        ),
                      ),
                    ),
                  ],
                ),
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
                        "Your ${userController.currentExam['examName']} Subjects",
                        style: GoogleFonts.nunito(
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),

                      ...userController.currentSubjects.map(
                        (subject) => Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            UserSubject(name: subject['subjectName']),
                            SizedBox(
                              height: 20.h,
                            ),
                          ],
                        ),
                      ),

                      // Other subjects
                      if (userController.unerolledSubjects.isNotEmpty)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SizedBox(
                              height: 30.h,
                            ),
                            Text(
                              "Other ${userController.currentExam['examName']} Subjects",
                              style: GoogleFonts.nunito(
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            ...userController.unerolledSubjects.map(
                              (subject) => Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  UnenrolledSubject(
                                      name: subject['subjectName']),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                      // bottom
                      const SizedBox(
                        height: 80,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class UserSubject extends StatelessWidget {
  final String name;
  const UserSubject({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: GoogleFonts.nunito(
              fontWeight: FontWeight.w500,
            ),
          ),
          if (userController.currentSubjects.length > 1)
            GestureDetector(
              onTap: () {
                showDeleteSubjectDialog(context, name);
              },
              child: const Icon(
                FontAwesomeIcons.solidTrashCan,
                size: 16,
                color: Color.fromRGBO(244, 67, 54, 0.6),
              ),
            ),
        ],
      );
    });
  }
}

class UnenrolledSubject extends StatelessWidget {
  final String name;
  const UnenrolledSubject({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          name,
          style: GoogleFonts.nunito(
            fontWeight: FontWeight.w500,
          ),
        ),
        GestureDetector(
          onTap: () {
            showAddSubjectDialog(context, name);
          },
          child: Icon(
            FontAwesomeIcons.plus,
            size: 16,
            color: primaryColor,
          ),
        ),
      ],
    );
  }
}

Future<void> showDeleteSubjectDialog(BuildContext context, String name) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          width: 180.h,
                          height: 180.h,
                          child: Center(
                            child: ClipOval(
                              child: Container(
                                color: const Color.fromARGB(57, 244, 67, 54),
                                padding: EdgeInsets.all(
                                  40.w,
                                ),
                                child: const Icon(
                                  FontAwesomeIcons.solidTrashCan,
                                  color: Colors.red,
                                  size: 40.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 180.h,
                          height: 180.h,
                          child: Center(
                            child: Container(
                              width: 145.h,
                              height: 145.h,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(85, 244, 67, 54),
                                borderRadius: BorderRadius.circular(140.r),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      "Delete $name?",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.nunito(
                          fontSize: 40.sp,
                          fontWeight: FontWeight.w900,
                          color: primaryColor),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      "Are you sure you want to delete $name? This action is irreversible and all the progress will be lost.",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.nunito(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade600),
                    ),

                    // close
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.r),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              height: 60.h,
                              width: 200.w,
                              color: grayColor,
                              padding: EdgeInsets.symmetric(
                                horizontal: 30.w,
                              ),
                              child: const Center(
                                child: Text("Cancel"),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.r),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              height: 60.h,
                              width: 200.w,
                              color: Colors.red,
                              padding: EdgeInsets.symmetric(
                                horizontal: 30.w,
                              ),
                              child: const Center(
                                child: Text(
                                  "Delete",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}

Future<void> showAddSubjectDialog(BuildContext context, String name) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          width: 180.h,
                          height: 180.h,
                          child: Center(
                            child: ClipOval(
                              child: Container(
                                color: const Color.fromARGB(57, 47, 59, 98),
                                padding: EdgeInsets.all(
                                  40.w,
                                ),
                                child: Icon(
                                  FontAwesomeIcons.solidTrashCan,
                                  color: primaryColor,
                                  size: 40.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 180.h,
                          height: 180.h,
                          child: Center(
                            child: Container(
                              width: 145.h,
                              height: 145.h,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(85, 47, 59, 98),
                                borderRadius: BorderRadius.circular(140.r),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      "Add $name?",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.nunito(
                          fontSize: 40.sp,
                          fontWeight: FontWeight.w900,
                          color: primaryColor),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      "Are you sure you want to Add $name? This subject will be added to the list of your subjects.",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.nunito(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade600),
                    ),

                    // close
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.r),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              height: 60.h,
                              width: 200.w,
                              color: grayColor,
                              padding: EdgeInsets.symmetric(
                                horizontal: 30.w,
                              ),
                              child: const Center(
                                child: Text("Cancel"),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.r),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              height: 60.h,
                              width: 200.w,
                              color: primaryColor,
                              padding: EdgeInsets.symmetric(
                                horizontal: 30.w,
                              ),
                              child: const Center(
                                child: Text(
                                  "Add",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}
