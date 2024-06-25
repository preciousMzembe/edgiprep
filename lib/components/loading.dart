import 'package:edgiprep/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:loading_indicator/loading_indicator.dart';

class LoadingPane extends StatelessWidget {
  final String title;
  final String subTitle;
  const LoadingPane({super.key, required this.title, required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.h),
      child: Column(
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
                      indicatorType: Indicator.circleStrokeSpin,
                      colors: [primaryColor],
                      strokeWidth: 3,
                      pathBackgroundColor: Colors.grey.shade300,
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
            title,
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
            subTitle,
            textAlign: TextAlign.center,
            style: GoogleFonts.nunito(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }
}
