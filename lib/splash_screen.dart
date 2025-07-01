import 'dart:math';

import 'package:edgiprep/root.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:edgiprep/utils/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:edgiprep/controllers/auth/auth_controller.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final authController = Get.find<AuthController>();

  final random = Random.secure();
  double randomAngle = 0;

  bool showLoading = false;

  Future<void> _init() async {
    await Future.delayed(const Duration(milliseconds: 0), () {
      setState(() {
        showLoading = true;
      });
    });

    await Future.delayed(const Duration(milliseconds: 3000), () {
      Get.offAll(() => const MyRoot());
    });
  }

  @override
  void initState() {
    super.initState();

    randomAngle = random.nextDouble() * 360;

    _init();
  }

  @override
  Widget build(BuildContext context) {
    setWhiteStatusBarIcons();

    return LayoutBuilder(builder: (context, constraints) {
      bool isTablet = DeviceUtils.isTablet(context);
      bool isSmallTablet = DeviceUtils.isSmallTablet(context);

      double iconSize = isTablet
          ? 100.r
          : isSmallTablet
              ? 110.r
              : 120.r;

      return Scaffold(
        backgroundColor: primaryColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedSlide(
                duration: const Duration(milliseconds: 500),
                offset: showLoading ? Offset.zero : const Offset(0, 1),
                child: Image.asset(
                  'icons/transparent_logo.png',
                  height: iconSize,
                ),
              ),
              Transform.rotate(
                angle: randomAngle * (pi / 180),
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 800),
                  opacity: showLoading ? 1.0 : 0.0,
                  child: Lottie.asset(
                    'icons/white_loading.json',
                    height: 120.h,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
