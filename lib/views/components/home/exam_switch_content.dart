import 'package:edgiprep/controllers/user_enrollment/user_enrollment_controller.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:edgiprep/utils/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ExamSwitchContent extends StatefulWidget {
  const ExamSwitchContent({super.key});

  @override
  State<ExamSwitchContent> createState() => _ExamSwitchContentState();
}

class _ExamSwitchContentState extends State<ExamSwitchContent> {
  final UserEnrollmentController userEnrollmentController =
      Get.find<UserEnrollmentController>();

  void selectExam(String examId) async {
    Navigator.pop(context);
    await userEnrollmentController.switchExam(examId);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isTablet = DeviceUtils.isTablet(context);
        bool isSmallTablet = DeviceUtils.isSmallTablet(context);

        double examSize = isTablet
            ? 16.sp
            : isSmallTablet
                ? 18.sp
                : 20.sp;

        double mainIconSize = isTablet
            ? 14.sp
            : isSmallTablet
                ? 16.sp
                : 18.sp;

        double buttonHeight = isTablet
            ? 70.sp
            : isSmallTablet
                ? 60.h
                : 50.h;

        double addButtonHeight = isTablet
            ? 50.sp
            : isSmallTablet
                ? 40.h
                : 30.h;

        double fontSize = isTablet
            ? 16.sp
            : isSmallTablet
                ? 18.sp
                : 20.sp;

        double iconSize = isTablet
            ? 22.sp
            : isSmallTablet
                ? 24.sp
                : 26.sp;

        return Obx(
          () {
            return PopupMenuButton<String>(
              color: Colors.white,
              offset: Offset(0, buttonHeight),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: Container(
                  color: const Color.fromRGBO(223, 228, 237, 1),
                  padding: EdgeInsets.symmetric(horizontal: 14.h),
                  height: buttonHeight,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        userEnrollmentController.activeExam.value.title,
                        style: GoogleFonts.inter(
                          fontSize: examSize,
                          fontWeight: FontWeight.w700,
                          color: const Color.fromRGBO(52, 74, 106, 1),
                        ),
                      ),
                      SizedBox(
                        width: 14.w,
                      ),
                      SvgPicture.asset(
                        'icons/bars.svg',
                        height: mainIconSize,
                        width: mainIconSize,
                        colorFilter: ColorFilter.mode(
                            Color.fromRGBO(52, 74, 106, 1), BlendMode.srcIn),
                      ),
                    ],
                  ),
                ),
              ),
              onSelected: (value) {
                selectExam(value);
              },
              itemBuilder: (context) => [
                // Top
                PopupMenuItem(
                  height: buttonHeight,
                  value: "",
                  enabled: false,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Switch Exam",
                        style: GoogleFonts.inter(
                          fontSize: fontSize,
                          fontWeight: FontWeight.w600,
                          color: const Color.fromRGBO(109, 124, 147, 1),
                        ),
                      ),
                      SizedBox(
                        width: 30.w,
                      ),
                      Icon(
                        FontAwesomeIcons.gear,
                        size: iconSize,
                        color: const Color.fromRGBO(161, 168, 183, 1),
                      ),
                    ],
                  ),
                ),
                PopupMenuDivider(),

                // Options
                ...userEnrollmentController.exams.map((exam) {
                  return PopupMenuItem(
                    value: exam.id,
                    height: buttonHeight,
                    enabled: false,
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: 6.h,
                        bottom: 0,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12.r),
                        child: GestureDetector(
                          onTap: () {
                            selectExam(exam.id);
                          },
                          child: Container(
                            color: exam.selected
                                ? const Color.fromRGBO(202, 228, 253, 1)
                                : Colors.transparent,
                            height: buttonHeight,
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // indicator
                                Container(
                                  height: addButtonHeight,
                                  width: addButtonHeight,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50.r),
                                    border: Border.all(
                                      width: 3.r,
                                      color: exam.selected
                                          ? const Color.fromRGBO(
                                              35, 131, 226, 1)
                                          : const Color.fromRGBO(
                                              214, 220, 233, 1),
                                    ),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      FontAwesomeIcons.check,
                                      size: fontSize,
                                      color: exam.selected
                                          ? const Color.fromRGBO(
                                              35, 131, 226, 1)
                                          : Colors.transparent,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 20.w,
                                ),

                                // Exam
                                Text(
                                  exam.title,
                                  style: GoogleFonts.inter(
                                    color: exam.selected
                                        ? const Color.fromRGBO(35, 131, 226, 1)
                                        : const Color.fromRGBO(52, 74, 106, 1),
                                    fontSize: fontSize,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),

                PopupMenuItem(
                  height: 40.h,
                  value: "",
                  enabled: false,
                  child: SizedBox(),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
