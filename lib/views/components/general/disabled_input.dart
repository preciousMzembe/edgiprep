import 'package:edgiprep/utils/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class DisabledInput extends StatefulWidget {
  final String label;
  final IconData icon;
  final double radius;
  const DisabledInput(
      {super.key,
      required this.label,
      required this.icon,
      required this.radius});

  @override
  State<DisabledInput> createState() => _NormalInputState();
}

class _NormalInputState extends State<DisabledInput> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isTablet = DeviceUtils.isTablet(context);
        bool isSmallTablet = DeviceUtils.isSmallTablet(context);

        double fontSize = isTablet
            ? 18.sp
            : isSmallTablet
                ? 20.sp
                : 22.sp;

        double iconSize = isTablet
            ? 26.h
            : isSmallTablet
                ? 28.h
                : 30.h;

        double verticalPadding = isTablet
            ? 20.h
            : isSmallTablet
                ? 22.h
                : 24.h;

        return Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(widget.radius.r),
            child: TextFormField(
              enabled: false,
              style: GoogleFonts.inter(
                color: Colors.black,
                fontSize: fontSize,
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: widget.label,
                hintStyle: GoogleFonts.inter(
                  color: const Color.fromRGBO(191, 198, 216, 1),
                  fontSize: fontSize,
                ),
                contentPadding: EdgeInsets.symmetric(vertical: verticalPadding),
                border: InputBorder.none,
                prefixIcon: Icon(
                  widget.icon,
                  color: const Color.fromRGBO(191, 198, 216, 1),
                  size: iconSize,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
