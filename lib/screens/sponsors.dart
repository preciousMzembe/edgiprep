import 'package:edgiprep/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Sponsors extends StatelessWidget {
  const Sponsors({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constants) {
        final isTall = constants.maxHeight > constants.maxWidth;
        return Scaffold(
          backgroundColor: backgroundColor,
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
                      SizedBox(
                        width: 20.w,
                      ),
                      Expanded(
                        child: Text(
                          "EdgiPrep Sponsors",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.nunito(
                            fontSize: 40.sp,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // about info
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 30.w,
                      vertical: 30.w,
                    ),
                    child: ListView(
                      children: const [
                        SizedBox(
                          height: 10,
                        ),
                        // organizations
                        Organization(),
                        SizedBox(
                          height: 20,
                        ),
                        Organization(),
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

class Organization extends StatelessWidget {
  const Organization({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(
        20.r,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 30,
        ),
        color: const Color.fromARGB(255, 243, 243, 243),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // logo
            Image.asset(
              'icons/logo.png',
              width: 80.w,
            ),

            // name
            const SizedBox(
              width: 20,
            ),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Edgicate",
                    style: GoogleFonts.nunito(
                      fontSize: 30.sp,
                      fontWeight: FontWeight.w800,
                    ),
                  ),

                  // subjects
                  Text(
                    "JCE Biology, MSCE Biology",
                    style: GoogleFonts.nunito(
                      // fontSize: 35.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  // Row(
                  //   crossAxisAlignment: CrossAxisAlignment.center,
                  //   children: [
                  //     Text(
                  //       "Biology",
                  //       style: GoogleFonts.nunito(
                  //         // fontSize: 35.sp,
                  //         fontWeight: FontWeight.w600,
                  //       ),
                  //     ),
                  //     const SizedBox(width: 7),
                  //     const Icon(
                  //       FontAwesomeIcons.minus,
                  //       size: 12,
                  //     ),
                  //     const SizedBox(width: 7),
                  //     Text(
                  //       "JCE",
                  //       style: GoogleFonts.nunito(
                  //         // fontSize: 35.sp,
                  //         fontWeight: FontWeight.w600,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
