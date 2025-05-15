import 'package:edgiprep/controllers/enrollment/enrollment_settings_controller.dart';
import 'package:edgiprep/controllers/user_enrollment/user_enrollment_controller.dart';
import 'package:edgiprep/db/subject/user_subject.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:edgiprep/utils/device_utils.dart';
import 'package:edgiprep/views/components/general/normal_button.dart';
import 'package:edgiprep/views/components/subject/unenroll_subject_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SubjectSettings extends StatefulWidget {
  final UserSubject subject;
  const SubjectSettings({
    super.key,
    required this.subject,
  });

  @override
  State<SubjectSettings> createState() => _SubjectSettingsState();
}

class _SubjectSettingsState extends State<SubjectSettings> {
  UserEnrollmentController userEnrollmentController =
      Get.find<UserEnrollmentController>();

  bool loading = true;

  @override
  Widget build(BuildContext context) {
    EnrollmentSettingsController enrollmentSettingsController =
        Get.find<EnrollmentSettingsController>();

    UserEnrollmentController userEnrollmentController =
        Get.find<UserEnrollmentController>();

    return LayoutBuilder(
      builder: (context, constraints) {
        bool isTablet = DeviceUtils.isTablet(context);
        bool isSmallTablet = DeviceUtils.isSmallTablet(context);

        double titleFontSize = isTablet
            ? 20.sp
            : isSmallTablet
                ? 22.sp
                : 24.sp;

        double iconSize = isTablet
            ? 150.h
            : isSmallTablet
                ? 150.h
                : 150.h;

        double titleSize = isTablet
            ? 26.sp
            : isSmallTablet
                ? 28.sp
                : 30.sp;

        double infoSize = isTablet
            ? 20.sp
            : isSmallTablet
                ? 22.sp
                : 24.sp;

        return Container(
          color: backgroundColor,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: ListView(
              children: [
                SizedBox(
                  height: 70.h,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (userEnrollmentController.subjects.length > 1)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30.w),
                            child: Text(
                              "Unenrolling the subject will remove all subject progress. You will start over if you enroll the subject again.",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.inter(
                                fontSize: titleFontSize,
                                fontWeight: FontWeight.w400,
                                color: const Color.fromRGBO(92, 101, 120, 1),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          GestureDetector(
                            onTap: () async {
                              await showDialog(
                                context: context,
                                barrierDismissible: true,
                                builder: (BuildContext context) {
                                  return UnenrollSubjectContent(
                                      subject: widget.subject);
                                },
                              );

                              bool enrolled = await enrollmentSettingsController
                                  .checkSubjectEnrollment(widget.subject.id);

                              if (!enrolled) {
                                Get.back();
                              }
                            },
                            child: normalButton(Color.fromRGBO(254, 101, 93, 1),
                                Colors.white, "Unenroll", 16),
                          ),
                        ],
                      ),
                    if (userEnrollmentController.subjects.length < 2)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SvgPicture.asset(
                            'icons/shield.svg',
                            height: iconSize,
                            width: iconSize,
                            colorFilter: const ColorFilter.mode(
                                Colors.white, BlendMode.srcIn),
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          Text(
                            "Can Not Unenroll",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(
                              fontSize: titleSize,
                              fontWeight: FontWeight.w800,
                              color: const Color.fromRGBO(161, 168, 183, 1),
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 50.w),
                            child: Text(
                              "You are currently enrolled in the only subject. You can not unenroll from the subject.",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.inter(
                                fontSize: infoSize,
                                fontWeight: FontWeight.w400,
                                color: const Color.fromRGBO(161, 168, 183, 1),
                              ),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
                SizedBox(
                  height: 100.h,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget statBox(
    String title, double titleFont, String subtitle, double subFont) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(20.r),
    child: Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        horizontal: 30.w,
        vertical: 30.h,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: titleFont,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: subFont,
              fontWeight: FontWeight.w400,
              color: const Color.fromRGBO(161, 168, 183, 1),
            ),
          ),
        ],
      ),
    ),
  );
}
