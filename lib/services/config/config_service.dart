import 'package:edgiprep/db/boxes.dart';
import 'package:edgiprep/db/config/config.dart';
import 'package:flutter/material.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:get/get.dart';

class ConfigService extends GetxService {
  final remoteConfig = FirebaseRemoteConfig.instance;

  // Fetch config data from Firebase
  Future<void> fetchConfigFromFirebase() async {
    try {
      await remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 1),
        minimumFetchInterval: const Duration(seconds: 5),
      ));

      await remoteConfig.fetchAndActivate();
      String apiUrl = remoteConfig.getString('API_URL');
      String appUrl = remoteConfig.getString('APP_URL');
      String imagesUrl = remoteConfig.getString('IMAGES_URL');
      String privacyPolicyUrl = remoteConfig.getString('PRIVACY_POLICY_URL');
      String quizQuestions = remoteConfig.getString('QUIZ_QUESTIONS');
      
      Config config = Config(
        apiUrl: apiUrl,
        imagesUrl: imagesUrl,
        privacyPolicyUrl: privacyPolicyUrl,
        appUrl: appUrl,
        quizQuestions: int.parse(quizQuestions),
      );

      await configBox.clear();
      await configBox.add(config);
    } catch (e) {
      debugPrint(
          "Error fetching remote config ------------------- config service");
    }
  }

  Future<Config?> getConfig() async {
    if (configBox.isNotEmpty) {
      Config localConfig = await configBox.values.first;
      return localConfig;
    }

    if (configBox.isEmpty) await fetchConfigFromFirebase();

    return null;
  }

  @override
  void onInit() {
    super.onInit();

    fetchConfigFromFirebase();
  }
}
