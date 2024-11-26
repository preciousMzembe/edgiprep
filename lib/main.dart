import 'package:edgiprep/controllers/auth/auth_controller.dart';
import 'package:edgiprep/db/hive_initializer.dart';
import 'package:edgiprep/firebase_options.dart';
import 'package:edgiprep/views/screens/auth/welcome.dart';
import 'package:edgiprep/controllers/controllers.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:edgiprep/views/screens/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebasr
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize Hive
  HiveInitializer hiveInitializer = HiveInitializer();
  await hiveInitializer.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(720, 1280),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          initialBinding: Controllers(),
          title: 'EdgiPrep',
          theme: ThemeData(
            fontFamily: GoogleFonts.inter().fontFamily,
            colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
            useMaterial3: true,
            navigationBarTheme: NavigationBarThemeData(
              labelTextStyle: WidgetStateProperty.resolveWith((state) {
                if (state.contains(WidgetState.selected)) {
                  return GoogleFonts.inter(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22.sp,
                  );
                }
                return GoogleFonts.inter(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 22.sp,
                );
              }),
            ),
          ),
          home: Obx(
            () {
              final authController = Get.find<AuthController>();
              return authController.authToken.value.isNotEmpty
                  ? const Wrapper()
                  : const Welcome();
            },
          ),
        );
      },
    );
  }
}
