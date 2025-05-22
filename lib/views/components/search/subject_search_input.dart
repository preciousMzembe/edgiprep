import 'package:edgiprep/utils/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class SubjectSearchInput extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final TextInputType type;
  final double radius;
  const SubjectSearchInput(
      {super.key,
      required this.controller,
      required this.label,
      required this.type,
      required this.radius});

  @override
  State<SubjectSearchInput> createState() => _SubjectSearchInputState();
}

class _SubjectSearchInputState extends State<SubjectSearchInput> {
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
              controller: widget.controller,
              style: GoogleFonts.inter(
                color: Colors.black,
                fontSize: fontSize,
              ),
              onChanged: (value) {
                setState(() {});
              },
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
                  FontAwesomeIcons.magnifyingGlass,
                  color: const Color.fromRGBO(191, 198, 216, 1),
                  size: iconSize,
                ),
                suffixIcon: widget.controller.text.isNotEmpty
                    ? IconButton(
                        icon: Icon(
                          FontAwesomeIcons.xmark,
                          color: const Color.fromARGB(255, 64, 74, 95),
                          size: iconSize,
                        ),
                        onPressed: () {
                          setState(() {
                            widget.controller.clear();
                          });
                        },
                      )
                    : null,
              ),
            ),
          ),
        );
      },
    );
  }
}
