import 'package:edgiprep/controllers/auth/auth_controller.dart';
import 'package:edgiprep/views/screens/auth/welcome.dart';
import 'package:edgiprep/views/screens/wrapper.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class MyRoot extends StatelessWidget {
  const MyRoot({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();

    return Obx(
      () {
        return authController.authToken.value.isNotEmpty
            ? const Wrapper()
            : const Welcome();
      },
    );
  }
}
