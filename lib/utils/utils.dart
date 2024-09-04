// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:math';

import 'package:edgiprep/components/close_quiz.dart';
import 'package:edgiprep/components/loading.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

// remot configarations
String? ApiUrl = "";
String? ImagesUrl = "";
String? PrivacyUrl = "";
String? AppUrl = "";
int? QuizQuestionNumber = 0;
int? MockQuestionNumber = 0;
Map? MockExamTime = {};
int? ChallangeQuestionNumber = 0;

// contact details
String? Phone = "";
String? Email = "";
String? Location = "";

List getRandomSubjects(List subjects, int count) {
  Random random = Random();
  List shuffledSubjects = List.from(subjects)..shuffle(random);
  return shuffledSubjects.take(count).toList();
}

Future<void> fetchRemoteConfigValues() async {
  try {
    final remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: const Duration(seconds: 2),
    ));
    await remoteConfig.fetchAndActivate();
    ApiUrl = remoteConfig.getString('V1_API');
    ImagesUrl = remoteConfig.getString('IMAGES_URL');
    PrivacyUrl = remoteConfig.getString('PRIVACY_URL');
    AppUrl = remoteConfig.getString('APP_URL');
    QuizQuestionNumber =
        int.parse(remoteConfig.getString('QUIZ_QUESTION_NUMBER'));
    MockQuestionNumber =
        int.parse(remoteConfig.getString('MOCK_QUESTION_NUMBER'));
    MockExamTime = jsonDecode(remoteConfig.getString('MOCK_EXAM_TIME'));
    ChallangeQuestionNumber =
        int.parse(remoteConfig.getString('CHALLANGE_QUESTION_NUMBER'));

    // contact details
    Phone = remoteConfig.getString('PHONE');
    Email = remoteConfig.getString('EMAIL');
    Location = remoteConfig.getString('LOCATION');
  } catch (e) {
    debugPrint('Error fetching remote config');
  }
}

// loading
Future<void> showLoadingDialog(
    BuildContext context, String title, String subTitle) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              LoadingPane(
                title: title,
                subTitle: subTitle,
              )
            ],
          ),
        ),
      );
    },
  );
}

// close
Future<void> showCloseQuizDialog(
    BuildContext context, String title, String subTitle, Function close) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              CloseQuizPane(
                title: title,
                subTitle: subTitle,
                close: close,
              )
            ],
          ),
        ),
      );
    },
  );
}

Future<void> showErrorLoading(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          width: 180.h,
                          height: 180.h,
                          child: Center(
                            child: ClipOval(
                              child: Container(
                                color: const Color.fromARGB(57, 244, 67, 54),
                                padding: EdgeInsets.all(
                                  40.w,
                                ),
                                child: const Icon(
                                  FontAwesomeIcons.exclamation,
                                  color: Colors.red,
                                  size: 40.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 180.h,
                          height: 180.h,
                          child: Center(
                            child: Container(
                              width: 145.h,
                              height: 145.h,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(85, 244, 67, 54),
                                borderRadius: BorderRadius.circular(140.r),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      "Error Loading Data",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.nunito(
                          fontSize: 40.sp,
                          fontWeight: FontWeight.w900,
                          color: primaryColor),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      "We had a problem getting data. check your internet connection and try again.",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.nunito(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade600),
                    ),

                    // close
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.r),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              height: 60.h,
                              width: 200.w,
                              color: grayColor,
                              padding: EdgeInsets.symmetric(
                                horizontal: 30.w,
                              ),
                              child: const Center(
                                child: Text("Close"),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}
