import 'dart:convert';

import 'package:edgiprep/controllers/user_controller.dart';
import 'package:edgiprep/screens/add_exam.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:edgiprep/utils/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Exam extends StatefulWidget {
  const Exam({super.key});

  @override
  State<Exam> createState() => _ExamState();
}

class _ExamState extends State<Exam> {
  UserController userController = Get.find<UserController>();
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constants) {
        final isTall = constants.maxHeight > constants.maxWidth;
        return Obx(() {
          return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 30.h,
                  ),
                  // top
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    child: Row(
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
                        Expanded(
                          child: Center(
                            child: Text(
                              "Exam Settings",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.nunito(
                                fontSize: 40.sp,
                                fontWeight: FontWeight.w900,
                                // color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.w),
                      child: ListView(
                        children: [
                          // names
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // current exam
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      "Current Exam",
                                      style: GoogleFonts.nunito(
                                        fontSize: 30.sp,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                    Text(
                                      userController.currentExam['examName'],
                                      style: GoogleFonts.nunito(
                                          fontWeight: FontWeight.w500,
                                          color: textColor),
                                    ),
                                  ],
                                ),
                              ),

                              // add exam
                              GestureDetector(
                                onTap: () {
                                  Get.to(() => const AddExam());
                                },
                                child: ClipOval(
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    color: const Color.fromRGBO(
                                        158, 158, 158, 0.123),
                                    child: Center(
                                      child: Icon(
                                        FontAwesomeIcons.plus,
                                        size: 18,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(
                            height: 25,
                          ),
                          Text(
                            "Change Exam",
                            style: GoogleFonts.nunito(
                              fontSize: 25.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          DropdownButton<dynamic>(
                            value: userController.currentExam['examId'],
                            onChanged: (dynamic newValue) async {
                              Map examWithId = userController.userExams
                                  .firstWhere(
                                      (exam) => exam['examId'] == newValue,
                                      orElse: () => {});
                              if (examWithId.isNotEmpty) {
                                // Update App with new Exam
                                String jsonString = jsonEncode(examWithId);
                                await secureStorage.writeKey(
                                    "currentExam", jsonString);
                                userController.currentExam.value = examWithId;

                                // reload
                                userController.checkUserKey();
                              }
                            },
                            items: userController.userExams
                                .map<DropdownMenuItem<dynamic>>((dynamic exam) {
                              return DropdownMenuItem<dynamic>(
                                value: exam['examId'],
                                child: Text(exam['examName']),
                              );
                            }).toList(),
                            style:
                                TextStyle(fontSize: 25.sp, color: Colors.black),
                            underline: Container(
                              height: 1,
                              color: const Color.fromARGB(90, 158, 158, 158),
                            ),
                            isExpanded: true,
                            dropdownColor: Colors.white,
                          ),

                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Changing the exam will not affect the progress of current exam.",
                            style: GoogleFonts.nunito(
                              fontWeight: FontWeight.w500,
                            ),
                          ),

                          // list of exams
                          const SizedBox(
                            height: 30,
                          ),
                          Text(
                            "Your Exams List",
                            style: GoogleFonts.nunito(
                              fontSize: 30.sp,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),

                          ...userController.userExams.map(
                            (exam) => Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                UserExam(name: exam['examName']),
                                SizedBox(
                                  height: 20.h,
                                ),
                              ],
                            ),
                          ),

                          // bottom
                          const SizedBox(
                            height: 80,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
      },
    );
  }
}

class UserExam extends StatelessWidget {
  final String name;
  const UserExam({super.key, required this.name});

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
          if (userController.userExams.length > 1)
            GestureDetector(
              onTap: () {
                showDeleteExamDialog(context, name);
              },
              child: const Icon(
                FontAwesomeIcons.solidTrashCan,
                size: 18,
                color: Color.fromRGBO(244, 67, 54, 0.6),
              ),
            ),
        ],
      );
    });
  }
}

Future<void> showDeleteExamDialog(BuildContext context, String name) async {
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
                      "Are you sure you want to delete your $name? This action is irreversible and all the progress will be lost.",
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
