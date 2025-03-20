import 'package:edgiprep/utils/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsInput extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final TextInputType type;
  final bool isPassword;
  final double radius;
  const SettingsInput({
    super.key,
    required this.controller,
    required this.label,
    required this.type,
    required this.isPassword,
    required this.radius,
  });

  @override
  State<SettingsInput> createState() => _SettingsInputState();
}

class _SettingsInputState extends State<SettingsInput> {
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

        double horizontalPadding = isTablet
            ? 20.w
            : isSmallTablet
                ? 22.w
                : 24.w;

        return Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(widget.radius.r),
            child: TextFormField(
              obscureText: _show,
              controller: widget.controller,
              keyboardType: widget.type,
              style: GoogleFonts.inter(
                color: Colors.black,
                fontSize: fontSize,
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color.fromRGBO(242, 244, 248, 1),
                hintText: widget.label,
                hintStyle: GoogleFonts.inter(
                  color: const Color.fromRGBO(97, 97, 115, 1),
                  fontSize: fontSize,
                ),
                contentPadding: EdgeInsets.symmetric(
                  vertical: verticalPadding,
                  horizontal: horizontalPadding,
                ),
                border: InputBorder.none,
                suffixIcon: widget.isPassword
                    ? IconButton(
                        icon: Icon(
                          _show ? Icons.visibility : Icons.visibility_off,
                          color: const Color.fromRGBO(97, 97, 115, 1),
                          size: iconSize,
                        ),
                        onPressed: () {
                          setState(() {
                            _show = !_show;
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
