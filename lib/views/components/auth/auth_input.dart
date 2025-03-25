import 'package:edgiprep/utils/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthInput extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final TextInputType type;
  final bool isPassword;
  final IconData icon;
  final double radius;
  final TextInputFormatter? formatter;
  const AuthInput({
    super.key,
    required this.label,
    required this.type,
    required this.isPassword,
    required this.icon,
    required this.radius,
    required this.controller,
    this.formatter,
  });

  @override
  State<AuthInput> createState() => _AuthInputState();
}

class _AuthInputState extends State<AuthInput> {
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
                : 24.sp;

        double iconSize = isTablet
            ? 28.h
            : isSmallTablet
                ? 30.h
                : 32.h;

        double verticalPadding = isTablet
            ? 22.h
            : isSmallTablet
                ? 24.h
                : 26.h;

        return Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(widget.radius.r),
            child: TextFormField(
              inputFormatters: [
                widget.formatter ?? FilteringTextInputFormatter.deny('')
              ],
              obscureText: _show,
              controller: widget.controller,
              style: GoogleFonts.inter(
                color: Colors.black,
                fontSize: fontSize,
              ),
              keyboardType: widget.type,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: widget.label,
                hintStyle: GoogleFonts.inter(
                  color: const Color.fromRGBO(172, 174, 179, 1),
                  fontSize: fontSize,
                ),
                contentPadding: EdgeInsets.symmetric(vertical: verticalPadding),
                border: InputBorder.none,
                prefixIcon: Icon(
                  widget.icon,
                  color: const Color.fromRGBO(172, 174, 179, 1),
                  size: iconSize,
                ),
                suffixIcon: widget.isPassword
                    ? IconButton(
                        icon: Icon(
                          _show ? Icons.visibility : Icons.visibility_off,
                          color: const Color.fromRGBO(214, 220, 233, 1),
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
