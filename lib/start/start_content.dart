import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StartContent extends StatelessWidget {
  final String image;
  final RichText message;
  const StartContent({super.key, required this.image, required this.message});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // image
        Image.asset(
          image,
          // "images/learn2.png",
          width: 400.w,
          // color: primaryColor,
        ),
        SizedBox(
          height: 30.h,
        ),
        message,
        // Text(
        //   message,
        //   // "Let's See How Much \n You Remember",
        //   textAlign: TextAlign.center,
        //   style: GoogleFonts.nunito(
        //     fontSize: 35.sp,
        //     fontWeight: FontWeight.w700,
        //   ),
        // ),
      ],
    );
  }
}
