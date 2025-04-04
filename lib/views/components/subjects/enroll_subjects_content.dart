import 'package:edgiprep/controllers/enrollment/enrollment_settings_controller.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:edgiprep/utils/device_utils.dart';
import 'package:edgiprep/views/components/enrollment/enrollment_settings_subject_option.dart';
import 'package:edgiprep/views/components/general/button_loading.dart';
import 'package:edgiprep/views/components/general/normal_button.dart';
import 'package:edgiprep/views/components/general/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class EnrollSubjectsContent extends StatefulWidget {
  const EnrollSubjectsContent({super.key});

  @override
  State<EnrollSubjectsContent> createState() => _EnrollSubjectsContentState();
}

class _EnrollSubjectsContentState extends State<EnrollSubjectsContent> {
  EnrollmentSettingsController enrollmentSettingsController =
      Get.find<EnrollmentSettingsController>();

  bool loading = false;

  void toggleLoading() {
    setState(() {
      loading = !loading;
    });
  }

  @override
  void initState() {
    super.initState();

    enrollmentSettingsController.fetchExams();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      bool isTablet = DeviceUtils.isTablet(context);
      bool isSmallTablet = DeviceUtils.isSmallTablet(context);

      double titleFontSize = isTablet
          ? 36.sp
          : isSmallTablet
              ? 38.sp
              : 40.sp;

      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.h),
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            color: Colors.transparent,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(30.r),
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      color: Colors.white,
                      padding: EdgeInsets.symmetric(
                        horizontal: 50.w,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(
                            height: 30.h,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: Text(
                              "Pick the Subjects You Want to Enroll",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.inter(
                                fontSize: titleFontSize,
                                fontWeight: FontWeight.w700,
                                color: const Color.fromRGBO(17, 25, 37, 1),
                              ),
                            ),
                          ),
                          Obx(() {
                            return SizedBox(
                              height: 500.h,
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    ...enrollmentSettingsController
                                        .unenrolledSubjects
                                        .map((subject) {
                                      return Padding(
                                        padding: EdgeInsets.only(top: 30.h),
                                        child: GestureDetector(
                                          onTap: () {
                                            if (!loading) {
                                              enrollmentSettingsController
                                                  .toggleUnerolledSubjectSelection(
                                                      subject.name);
                                            }
                                          },
                                          child:
                                              enrollmentSettingsSubjectOption(
                                            subject.selected,
                                            subject.name,
                                            subject.icon,
                                          ),
                                        ),
                                      );
                                    }),
                                    SizedBox(
                                      height: 40.h,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),

                          // button
                          Obx(() {
                            return Stack(
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    if (enrollmentSettingsController
                                        .subjectsSelected.value) {
                                      toggleLoading();

                                      bool done =
                                          await enrollmentSettingsController
                                              .enrollSubjects();

                                      if (!done) {
                                        showSnackbar(
                                            context,
                                            "Something Went Wrong",
                                            "There was a problem updating your subjects.",
                                            true);
                                      } else {
                                        Navigator.pop(context);
                                      }

                                      toggleLoading();
                                    }
                                  },
                                  child: Container(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 30.h),
                                    child: normalButton(
                                      // primaryColor,
                                      enrollmentSettingsController
                                              .subjectsSelected.value
                                          ? primaryColor
                                          : unselectedButtonColor,
                                      enrollmentSettingsController
                                              .subjectsSelected.value
                                          ? Colors.white
                                          : const Color.fromRGBO(
                                              52, 74, 106, 1),
                                      "Enroll",
                                      20,
                                    ),
                                  ),
                                ),

                                // loading
                                if (loading)
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 30.h),
                                    child: buttonLoading(
                                        unselectedButtonColor, 16),
                                  ),
                              ],
                            );
                          }),
                          SizedBox(
                            height: 10.h,
                          ),
                        ],
                      ),
                    ),
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
