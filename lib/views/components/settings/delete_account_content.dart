import 'package:edgiprep/controllers/auth/auth_controller.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:edgiprep/utils/device_utils.dart';
import 'package:edgiprep/views/components/general/button_loading.dart';
import 'package:edgiprep/views/components/general/normal_button.dart';
import 'package:edgiprep/views/components/general/pin_input_formatter.dart';
import 'package:edgiprep/views/components/general/snackbar.dart';
import 'package:edgiprep/views/components/settings/settings_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class DeleteAccountContent extends StatefulWidget {
  const DeleteAccountContent({super.key});

  @override
  State<DeleteAccountContent> createState() => _DeleteAccountContentState();
}

class _DeleteAccountContentState extends State<DeleteAccountContent> {
  AuthController authController = Get.find<AuthController>();

  TextEditingController passwordController = TextEditingController();

  bool loading = false;

  void toggleLoading() {
    setState(() {
      loading = !loading;
    });
  }

  @override
  void initState() {
    super.initState();
    passwordController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      bool isTablet = DeviceUtils.isTablet(context);
      bool isSmallTablet = DeviceUtils.isSmallTablet(context);

      double titleFontSize = isTablet
          ? 32.sp
          : isSmallTablet
              ? 34.sp
              : 36.sp;

      double subtitleFontSize = isTablet
          ? 18.sp
          : isSmallTablet
              ? 20.sp
              : 22.sp;

      return GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.h),
          color: Colors.transparent,
          child: ClipRRect(
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
                    // image
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'icons/sad_close.svg',
                          height: 155.r,
                          width: 155.r,
                        ),
                      ],
                    ),
                    // title
                    SizedBox(
                      height: 25.h,
                    ),
                    Text(
                      "Are You Sure You Want to Delete Your Account?",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontSize: titleFontSize,
                        fontWeight: FontWeight.w700,
                        color: const Color.fromRGBO(52, 74, 106, 1),
                      ),
                    ),

                    // text
                    SizedBox(
                      height: 15.h,
                    ),
                    Text(
                      "Deleting your account will remove all your data from our servers. This action cannot be undone.",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontSize: subtitleFontSize,
                        fontWeight: FontWeight.w400,
                        color: const Color.fromRGBO(89, 89, 89, 1),
                      ),
                    ),

                    SizedBox(
                      height: 20.h,
                    ),
                    SettingsInput(
                      controller: passwordController,
                      label: "Enter Pin",
                      type: TextInputType.number,
                      isPassword: true,
                      radius: 20,
                      formatter: PinInputFormatter(),
                    ),

                    // button
                    Stack(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            if (passwordController.text.isNotEmpty &&
                                !loading) {
                              toggleLoading();

                              var data = await authController.deleteAccount(
                                  passwordController.text.trim());

                              if (data['status'] == "error") {
                                Get.back();

                                showSnackbar(
                                    context,
                                    "Problem Deleting Account",
                                    data['error'],
                                    true);
                              } else {
                                passwordController.text = "";

                                Navigator.pop(context);
                                await authController.logout();
                                Get.back();
                                Get.back();

                                showSnackbar(context, "Update Successful",
                                    "Account deleted successfully.", false);
                              }

                              toggleLoading();
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 30.h),
                            child: normalButton(
                              passwordController.text.isNotEmpty && !loading
                                  ? const Color.fromRGBO(254, 101, 93, 1)
                                  : unselectedButtonColor,
                              passwordController.text.isNotEmpty && !loading
                                  ? Colors.white
                                  : const Color.fromRGBO(52, 74, 106, 1),
                              "Delete Account",
                              20,
                            ),
                          ),
                        ),

                        // loading
                        if (loading)
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 30.h),
                            child: buttonLoading(unselectedButtonColor, 16),
                          ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
