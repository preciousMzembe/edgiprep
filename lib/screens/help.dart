import 'package:edgiprep/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Help extends StatelessWidget {
  const Help({super.key});

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
                    ],
                  ),
                ),

                Expanded(
                  child: ListView(
                    children: [
                      // heading
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30.w),
                        child: Text(
                          "How can we \nHelp you today?",
                          style: GoogleFonts.nunito(
                            fontSize: 60.sp,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30.w),
                        child: Text(
                          "Get in touch with our support team for personalized assistance.",
                          style: GoogleFonts.nunito(
                            // fontSize: 60.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),

                      // contacts
                      const SizedBox(
                        height: 40,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Contact(
                              icon: const Icon(
                                FontAwesomeIcons.phone,
                                size: 20,
                                color: Color.fromRGBO(124, 180, 66, 1),
                              ),
                              name: 'Phone',
                              detail: "$Phone",
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Contact(
                              icon: const Icon(
                                FontAwesomeIcons.solidEnvelope,
                                size: 20,
                                color: Color.fromRGBO(124, 180, 66, 1),
                              ),
                              name: 'Email',
                              detail: "$Email",
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Contact(
                              icon: const Icon(
                                FontAwesomeIcons.locationDot,
                                size: 20,
                                color: Color.fromRGBO(124, 180, 66, 1),
                              ),
                              name: 'Address',
                              detail: "$Location",
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            Text(
                              "Feel free to reach out to us at any time.",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.nunito(
                                // fontSize: 60.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // bottom
                      const SizedBox(
                        height: 100,
                      ),
                    ],
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
                SelectableText(
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
