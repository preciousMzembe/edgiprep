import 'package:edgiprep/auth/choose_subjects.dart';
import 'package:edgiprep/controllers/auth_controller.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ChooseExam extends StatelessWidget {
  const ChooseExam({super.key});

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find<AuthController>();

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
                        "Choose Your \nExam",
                        style: GoogleFonts.nunito(
                          fontSize: 70.sp,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const Text(
                          "Please select the exam you are preparing for to get started on your tailored study plan and resources."),
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
                        itemCount: authController.exams.length,
                        itemBuilder: (context, index) {
                          // bool isSelectedd = false;
                          // var currentExam = authController.exams[index];
                          // var userExam = authController.userExam;

                          // if (currentExam['examId'] != null &&
                          //     userExam['examId'] != null &&
                          //     currentExam['examId'] == userExam['examId']) {
                          //   isSelectedd = true;
                          // }
                          return GestureDetector(
                            onTap: () {
                              // set user exam
                              authController
                                  .setUserExam(authController.exams[index]);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: authController.exams[index]['examId'] !=
                                            null &&
                                        authController.userExam['examId'] !=
                                            null &&
                                        authController.exams[index]['examId'] ==
                                            authController.userExam['examId']
                                    ? const Color.fromRGBO(47, 59, 98, 0.123)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(40.r),
                                border: Border.all(
                                  width: 1,
                                  color: authController.exams[index]
                                                  ['examId'] !=
                                              null &&
                                          authController.userExam['examId'] !=
                                              null &&
                                          authController.exams[index]
                                                  ['examId'] ==
                                              authController.userExam['examId']
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
                                            color: authController.exams[index]
                                                            ['examId'] !=
                                                        null &&
                                                    authController.userExam[
                                                            'examId'] !=
                                                        null &&
                                                    authController.exams[index]
                                                            ['examId'] ==
                                                        authController
                                                            .userExam['examId']
                                                ? primaryColor
                                                : const Color.fromRGBO(
                                                    47, 59, 98, 0.523),
                                            child: Icon(
                                              FontAwesomeIcons.check,
                                              size: 15,
                                              color: authController.exams[index]
                                                              ['examId'] !=
                                                          null &&
                                                      authController.userExam[
                                                              'examId'] !=
                                                          null &&
                                                      authController
                                                                  .exams[index]
                                                              ['examId'] ==
                                                          authController
                                                                  .userExam[
                                                              'examId']
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
                                          authController.exams[index]
                                              ['examName'],
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.nunito(
                                            color: authController.exams[index]
                                                            ['examId'] !=
                                                        null &&
                                                    authController.userExam[
                                                            'examId'] !=
                                                        null &&
                                                    authController.exams[index]
                                                            ['examId'] ==
                                                        authController
                                                            .userExam['examId']
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
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                          "You can add other exams when you have an account."),

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
                        if (authController.userExam.isNotEmpty)
                          Expanded(
                            child: GestureDetector(
                              onTap: () async {
                                await authController.emptySubjects();
                                await authController.emptyUserSubjects();
                                authController.setSubjects();
                                Get.to(() => const ChooseSubjects());
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
