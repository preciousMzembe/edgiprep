import 'dart:async';

import 'package:edgiprep/controllers/navigation/nav_controller.dart';
import 'package:edgiprep/responsive/responsive_layout.dart';
import 'package:edgiprep/views/screens/auth/auth.dart';
import 'package:edgiprep/views/components/auth/welcome_fade_text.dart';
import 'package:edgiprep/views/components/auth/nav_dots.dart';
import 'package:edgiprep/views/components/auth/welcome_page.dart';
import 'package:edgiprep/views/components/general/normal_button.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  NavController navController = Get.find<NavController>();
  int currentIndex = 0;

  final List<String> images = [
    'images/students.png',
    'images/students_2.jpg',
    'images/students_3.png',
  ];

  final List<String> titles = [
    'Welcome to \n EdgiPrep',
    'Learn Smarter \n And Flexible',
    'Test Your \n Knowledge',
  ];

  final List<String> subTitles = [
    'Your ultimate study companion. Explore structured lessons and quizzes tailored to help you excel in every exam.',
    'Access interactive lessons designed to break down complex topics into simple, digestible parts. Study at your own pace, anywhere, anytime.',
    'Put your knowledge to the test with quizzes after each lesson. Track your progress and identify areas for improvement to stay on top of your game.',
  ];

  final PageController _pageController = PageController();
  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 8), (Timer timer) {
      if (currentIndex < images.length - 1) {
        currentIndex++;
      } else {
        currentIndex = 0;
      }

      if (_pageController.hasClients) {
        _pageController.animateToPage(
          currentIndex,
          duration: const Duration(seconds: 2),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      body: Container(
        color: backgroundColor,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 50.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 30.h),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: PageView.builder(
                              controller: _pageController,
                              itemCount: images.length,
                              onPageChanged: (int index) {
                                setState(() {
                                  currentIndex = index;
                                });
                              },
                              itemBuilder: (context, index) {
                                // pages
                                return welcomePage(
                                  titles[index],
                                  subTitles[index],
                                  images[index],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30.h),
                    // indicators
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        navDot(
                          currentIndex == 0,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        navDot(
                          currentIndex == 1,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        navDot(
                          currentIndex == 2,
                        ),
                      ],
                    ),
                    SizedBox(height: 40.h),
                    // message
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.w),
                      child: welcomeFadeText(
                        "Master Your Exams with Lessons, Practice, and Confidence!",
                      ),
                    ),
                  ],
                ),
              ),
              // buttons
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 30.h),
                  GestureDetector(
                    onTap: () {
                      navController.changePageIndex(0);
                      Get.to(() => const Auth(
                            initialPage: 0,
                          ));
                    },
                    child: normalButton(
                      primaryColor,
                      primaryTextColor,
                      "Sign In",
                      22,
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  GestureDetector(
                    onTap: () {
                      navController.changePageIndex(0);
                      Get.to(() => const Auth(
                            initialPage: 1,
                          ));
                    },
                    child: normalButton(
                      unselectedButtonColor,
                      Colors.black,
                      "Sign Up",
                      22,
                    ),
                  ),
                  SizedBox(height: 80.h),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
