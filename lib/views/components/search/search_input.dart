import 'package:edgiprep/utils/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchInput extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final TextInputType type;
  final bool isPassword;
  final IconData icon;
  final double radius;
  const SearchInput(
      {super.key,
      required this.controller,
      required this.label,
      required this.type,
      required this.isPassword,
      required this.icon,
      required this.radius});

  @override
  State<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  bool _show = false;

  @override
  void initState() {
    super.initState();

    if (widget.isPassword) {
      _show = true;
    }
  }

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

        return Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(widget.radius.r),
            child: TextFormField(
              controller: widget.controller,
              obscureText: _show,
              autofocus: true,
              style: GoogleFonts.inter(
                color: Colors.black,
                fontSize: fontSize,
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color.fromARGB(0, 0, 0, 0),
                hintText: widget.label,
                hintStyle: GoogleFonts.inter(
                  color: Colors.black45,
                  fontSize: fontSize,
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 0, horizontal: 20.w),
                border: InputBorder.none,
              ),
            ),
          ),
        );
      },
    );
  }
}
