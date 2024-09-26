import 'package:edgiprep/controllers/settings_controller.dart';
import 'package:edgiprep/controllers/user_controller.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:edgiprep/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PersonalInformation extends StatefulWidget {
  const PersonalInformation({super.key});

  @override
  State<PersonalInformation> createState() => _PersonalInformationState();
}

class _PersonalInformationState extends State<PersonalInformation> {
  SettingsController settingsController = Get.find<SettingsController>();
  UserController userController = Get.find<UserController>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    _nameController.text = userController.user['fullName'];
    _emailController.text = userController.user['email'];
    _phoneController.text = userController.user['phone'];

    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constants) {
        final isTall = constants.maxHeight > constants.maxWidth;
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
                            "Personal Information",
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
                        Text(
                          "Full Name",
                          style: GoogleFonts.nunito(
                            fontSize: 25.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        TextField(
                          controller: _nameController,
                          style: TextStyle(fontSize: 25.sp),
                          decoration: InputDecoration(
                            isDense: true,
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1.0,
                                  color: Color.fromARGB(90, 158, 158, 158)),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: primaryColor),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5.0,
                            ),
                          ),
                        ),

                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          "Email",
                          style: GoogleFonts.nunito(
                            fontSize: 25.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        TextField(
                          controller: _emailController,
                          style: TextStyle(fontSize: 25.sp),
                          decoration: InputDecoration(
                            isDense: true,
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1.0,
                                  color: Color.fromARGB(90, 158, 158, 158)),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: primaryColor),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5.0,
                            ),
                          ),
                        ),

                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          "Phone Number",
                          style: GoogleFonts.nunito(
                            fontSize: 25.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        TextField(
                          controller: _phoneController,
                          style: TextStyle(fontSize: 25.sp),
                          decoration: InputDecoration(
                            isDense: true,
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1.0,
                                  color: Color.fromARGB(90, 158, 158, 158)),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1.0, color: primaryColor),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5.0,
                            ),
                          ),
                        ),

                        // button
                        const SizedBox(
                          height: 40,
                        ),
                        GestureDetector(
                          onTap: () async {
                            // update data
                            String name = _nameController.text.trim();
                            String email = _emailController.text.trim();
                            String phone = _phoneController.text.trim();

                            if (name.isNotEmpty) {
                              settingsController.resetController();
                              showLoadingDialog(context, "Updating Details",
                                  "Please wait we update yor details.");

                              await settingsController.updateUserDetails(
                                  name, email, phone);
                              Navigator.pop(context);

                              if (settingsController.saveError.value) {
                                showDataError(context, "Error Updating Details",
                                    settingsController.saveErrorMessage.value);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: const Text(
                                        "Your details updated successfully."),
                                    duration: const Duration(seconds: 2),
                                    backgroundColor: primaryColor,
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: const Text(
                                      "Your full name can not be empty."),
                                  duration: const Duration(seconds: 2),
                                  backgroundColor: primaryColor,
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 50.w,
                            ),
                            height: 80.h,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1.0,
                                color: primaryColor,
                              ),
                              color: const Color.fromRGBO(47, 59, 98, 0.123),
                              borderRadius: BorderRadius.circular(80.r),
                            ),
                            child: Center(
                              child: Text(
                                "Update Information",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.nunito(
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          "Ensure your details are accurate.",
                          style: GoogleFonts.nunito(
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        // bottom
                        const SizedBox(
                          height: 100,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class Contact extends StatelessWidget {
  final String name;
  final String detail;
  final Icon icon;
  const Contact(
      {super.key,
      required this.name,
      required this.detail,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 30,
      ),
      color: const Color.fromARGB(255, 243, 243, 243),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // icon
          ClipRRect(
            borderRadius: BorderRadius.circular(100.r),
            child: Container(
              height: 90.w,
              width: 90.w,
              color: const Color.fromRGBO(124, 180, 66, 0.123),
              child: Center(
                child: icon,
              ),
            ),
          ),
          // details
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  name,
                  style: GoogleFonts.nunito(
                    fontSize: 35.sp,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  detail,
                  style: GoogleFonts.nunito(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
