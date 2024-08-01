import 'package:edgiprep/controllers/add_exam_controller.dart';
import 'package:edgiprep/screens/add_exam_subjects.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AddExam extends StatelessWidget {
  const AddExam({super.key});

  @override
  Widget build(BuildContext context) {
    AddExamController addExamController = Get.find<AddExamController>();

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
                Expanded(
                  child: ListView(
                    children: [
                      SizedBox(
                        height: 30.h,
                      ),
                      Text(
                        "Choose Your \nExam to Add",
                        style: GoogleFonts.nunito(
                          fontSize: 70.sp,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const Text(
                          "Please select the exam you want to add tou your list."),
                      SizedBox(
                        height: 60.h,
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
                        itemCount: addExamController.exams.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              // set user exam
                              addExamController
                                  .setUserExam(addExamController.exams[index]);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: addExamController.exams[index] ==
                                        addExamController.userExam
                                    // ? const Color.fromRGBO(243, 188, 92, 0.123)
                                    ? const Color.fromRGBO(47, 59, 98, 0.123)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(40.r),
                                border: Border.all(
                                  width: 1,
                                  color: addExamController.exams[index] ==
                                          addExamController.userExam
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
                                            color: addExamController
                                                        .exams[index] ==
                                                    addExamController.userExam
                                                ? primaryColor
                                                : const Color.fromRGBO(
                                                    47, 59, 98, 0.523),
                                            child: Icon(
                                              FontAwesomeIcons.check,
                                              size: 15,
                                              color: addExamController
                                                          .exams[index] ==
                                                      addExamController.userExam
                                                  ? Colors.white
                                                  : const Color.fromARGB(
                                                      99, 255, 255, 255),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                    // exam
                                    Expanded(
                                      child: Center(
                                        child: Text(
                                          addExamController.exams[index],
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.nunito(
                                            color: addExamController
                                                        .exams[index] ==
                                                    addExamController.userExam
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
                        if (addExamController.userExam != "")
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Get.to(() => const AddExamSubjects());
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(40.r),
                                child: Container(
                                  color: primaryColor,
                                  height: 95.h,
                                  child: Center(
                                    child: Text(
                                      "Continue",
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
