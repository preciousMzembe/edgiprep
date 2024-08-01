import 'package:edgiprep/auth/set_username.dart';
import 'package:edgiprep/controllers/auth_controller.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:loading_indicator/loading_indicator.dart';

class ChooseSubjects extends StatelessWidget {
  const ChooseSubjects({super.key});

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
                // body
                Expanded(
                  child: ListView(
                    children: [
                      SizedBox(
                        height: 30.h,
                      ),
                      Text(
                        "Choose Your \nSubjects",
                        style: GoogleFonts.nunito(
                          fontSize: 70.sp,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const Text(
                          "Choose the subjects you're preparing for to get started with your customized lessons."),
                      SizedBox(
                        height: 60.h,
                      ),
                      if (authController.subjects.isNotEmpty)
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
                          itemCount: authController.subjects.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                // add/remove user subjects
                                authController.addRemoveUserSubjects(
                                    authController.subjects[index]);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: authController.userSubjects.contains(
                                          authController.subjects[index])
                                      // ? const Color.fromRGBO(243, 188, 92, 0.123)
                                      ? const Color.fromRGBO(47, 59, 98, 0.123)
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(40.r),
                                  border: Border.all(
                                    width: 1,
                                    color: authController.userSubjects.contains(
                                            authController.subjects[index])
                                        ? primaryColor
                                        : const Color.fromRGBO(
                                            47, 59, 98, 0.523),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          ClipOval(
                                            child: Container(
                                              width: 30,
                                              height: 30,
                                              color: authController.userSubjects
                                                      .contains(authController
                                                          .subjects[index])
                                                  ? primaryColor
                                                  : const Color.fromRGBO(
                                                      47, 59, 98, 0.523),
                                              child: Icon(
                                                FontAwesomeIcons.check,
                                                size: 15,
                                                color: authController
                                                        .userSubjects
                                                        .contains(authController
                                                            .subjects[index])
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
                                            authController.subjects[index]
                                                ["subjectName"],
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.nunito(
                                              color: authController.userSubjects
                                                      .contains(authController
                                                          .subjects[index])
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

                      if (authController.subjects.isEmpty)
                        Column(
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
                                        color: primaryColor,
                                        padding: EdgeInsets.all(
                                          40.w,
                                        ),
                                        child: LoadingAnimationWidget.waveDots(
                                          color: Colors.white,
                                          size: 50.h,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 180.h,
                                  height: 180.h,
                                  child: Center(
                                    child: SizedBox(
                                      width: 140.h,
                                      height: 140.h,
                                      child: LoadingIndicator(
                                        indicatorType:
                                            Indicator.circleStrokeSpin,
                                        colors: [primaryColor],
                                        strokeWidth: 3,
                                        pathBackgroundColor:
                                            Colors.grey.shade300,
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
                              "Getting Subjects",
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
                              "Wait while we get subjects for your exam.",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.nunito(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey.shade600),
                            ),
                          ],
                        ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text("You can make changes in your settings."),

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
                        if (authController.userSubjects.isNotEmpty)
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Get.to(() => const SetUsername());
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
