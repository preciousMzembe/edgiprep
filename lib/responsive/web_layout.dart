import 'package:edgiprep/utils/constants.dart';
import 'package:edgiprep/utils/device_utils.dart';
import 'package:flutter/material.dart';

class WebLayout extends StatelessWidget {
  final Widget body;
  const WebLayout({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      bool isSmallWeb = DeviceUtils.isSmallWeb(context);

      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: isSmallWeb ? MediaQuery.of(context).size.width : 800.0,
            color: backgroundColor,
            child: body,
          ),
        ],
      );
    });
  }
}
