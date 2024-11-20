import 'package:edgiprep/utils/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class TimePicker extends StatefulWidget {
  const TimePicker({super.key});

  @override
  State<TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  int selectedHourIndex = 0;
  int selectedMinuteIndex = 0;
  bool isAm = true;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: _buildTimeWheel(
            List.generate(
                12, (index) => (index + 1).toString().padLeft(2, '0')),
            selectedHourIndex,
            (index) => setState(() => selectedHourIndex = index),
          ),
        ),
        Text(
          ':',
          style: GoogleFonts.inter(
            fontSize: 42.sp,
            fontWeight: FontWeight.w800,
            color: const Color.fromRGBO(92, 101, 120, 1),
          ),
        ),
        Expanded(
          child: _buildTimeWheel(
            List.generate(60, (index) => index.toString().padLeft(2, '0')),
            selectedMinuteIndex,
            (index) => setState(() => selectedMinuteIndex = index),
          ),
        ),
        Expanded(
          child: _buildTimeWheel(
            ['AM', 'PM'],
            isAm ? 0 : 1,
            (index) => setState(() => isAm = index == 0),
          ),
        ),
      ],
    );
  }

  Widget _buildTimeWheel(List<String> items, int selectedIndex,
      ValueChanged<int> onSelectedItemChanged) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isTablet = DeviceUtils.isTablet(context);
        bool isSmallTablet = DeviceUtils.isSmallTablet(context);

        double fontSize = isTablet
            ? 36.sp
            : isSmallTablet
                ? 38.sp
                : 46.sp;

        double height = isTablet
            ? 100.h
            : isSmallTablet
                ? 100.h
                : 100.h;

        return SizedBox(
          height: height,
          child: ListWheelScrollView.useDelegate(
            itemExtent: 30,
            perspective: 0.005,
            diameterRatio: 2.0,
            physics: const FixedExtentScrollPhysics(),
            onSelectedItemChanged: onSelectedItemChanged,
            childDelegate: ListWheelChildBuilderDelegate(
              builder: (context, index) {
                if (index < 0 || index >= items.length) return null;
                final isSelected = index == selectedIndex;
                return Center(
                  child: Text(
                    items[index],
                    style: GoogleFonts.inter(
                      fontSize: fontSize,
                      color: isSelected
                          ? const Color.fromRGBO(92, 101, 120, 1)
                          : const Color.fromRGBO(161, 168, 183, 1),
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                );
              },
              childCount: items.length,
            ),
          ),
        );
      },
    );
  }
}
