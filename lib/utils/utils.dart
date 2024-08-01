import 'dart:math';

import 'package:edgiprep/components/close_quiz.dart';
import 'package:edgiprep/components/loading.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';

// remot configarations
String? ApiUrl = "";
String? ImagesUrl = "";
String? PrivacyUrl = "";
String? AppUrl = "";

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
  } catch (e) {
    print('Error fetching remote config: $e');
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
