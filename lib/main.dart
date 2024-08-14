import 'dart:ui';

import 'package:edgiprep/auth/auth.dart';
import 'package:edgiprep/controllers/controllers.dart';
import 'package:edgiprep/controllers/user_controller.dart';
import 'package:edgiprep/firebase_options.dart';
import 'package:edgiprep/screens/wrapper.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:edgiprep/utils/firebase_api.dart';
import 'package:edgiprep/utils/utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> main() async {
  // firebase
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    debugPrint("Error initializing Firebase");
  }

  await fetchRemoteConfigValues();

  // FlutterError.onError = (errorDetails) {
  //   FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  // };
  // PlatformDispatcher.instance.onError = (error, stack) {
  //   FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
  //   return true;
  // };

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    //   statusBarColor: Color.fromRGBO(65, 75, 105, 1),
    // ));
    return ScreenUtilInit(
      designSize: const Size(720, 1280),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          // initialize controllers
          initialBinding: Controllers(),
          onInit: () async {
            await FirebaseApi().initNotifications();
          },
          title: 'EdgiPrep',
          theme: ThemeData(
            fontFamily: GoogleFonts.nunito().fontFamily,
            colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
            useMaterial3: true,
            navigationBarTheme: NavigationBarThemeData(
              labelTextStyle: WidgetStateProperty.resolveWith((state) {
                if (state.contains(WidgetState.selected)) {
                  return const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  );
                }
                return const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                );
              }),
            ),
          ),
          home: Obx(() {
            final userController = Get.find<UserController>();
            if (userController.userKey.isEmpty) {
              return const Auth();
            } else {
              return const Wrapper();
            }
          }),
        );
      },
    );
  }
}
