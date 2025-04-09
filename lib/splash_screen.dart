import 'dart:math';

import 'package:edgiprep/root.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
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

  final random = Random();
  double randomAngle = 0;

  bool showLoading = false;

  Future<void> _init() async {
    await Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {
        showLoading = true;
      });
    });

    await Future.delayed(const Duration(milliseconds: 2000), () {
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
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedSlide(
              duration: const Duration(milliseconds: 500),
              offset: showLoading ? Offset.zero : const Offset(0, 1),
              child: SvgPicture.asset(
                'icons/logo.svg',
                height: 100.h,
                colorFilter:
                    const ColorFilter.mode(Colors.white, BlendMode.srcIn),
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
  }
}
