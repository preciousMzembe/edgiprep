import 'package:cached_network_image/cached_network_image.dart';
import 'package:edgiprep/controllers/auth/auth_controller.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:edgiprep/utils/device_utils.dart';
import 'package:edgiprep/views/components/general/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';

Widget settingsUserImage() {
  return LayoutBuilder(
    builder: (context, constraints) {
      AuthController authController = Get.find<AuthController>();

      bool isTablet = DeviceUtils.isTablet(context);
      bool isSmallTablet = DeviceUtils.isSmallTablet(context);

      double imageSize = isTablet
          ? 200.r
          : isSmallTablet
              ? 200.r
              : 200.r;

      double buttonSize = isTablet
          ? 64.r
          : isSmallTablet
              ? 64.r
              : 64.r;

      double iconSize = isTablet
          ? 30.r
          : isSmallTablet
              ? 30.r
              : 30.r;

      RxBool isLoading = false.obs;

      Future<void> pickAndUploadProfileImage() async {
        final ImagePicker picker = ImagePicker();
        final XFile? image =
            await picker.pickImage(source: ImageSource.gallery);
        if (image != null) {
          isLoading.value = true;

          final XFile imageFile = XFile(image.path);
          final int fileSize = await imageFile.length(); // size in bytes

          const int maxSizeInBytes = 5 * 1024 * 1024; // 5MB

          if (fileSize > maxSizeInBytes) {
            showSnackbar(context, "File Too Large",
                "Please select a file smaller than 5MB.", true);
            return;
          }

          Map data = await authController.uploadProfilePicture(image.path);

          isLoading.value = false;

          if (data['status'] == 'success') {
            showSnackbar(context, "Update Successful",
                "Your data was updated successfully.", false);
          } else {
            showSnackbar(context, "Update Failed",
                "There was an error updating your data.", true);
          }
        }
      }

      return Stack(
        children: [
          // image
          Obx(
            () {
              return Stack(
                children: [
                  SizedBox(
                    height: imageSize,
                    child: CachedNetworkImage(
                      imageUrl: "${authController.user.value?.profileImage}",
                      imageBuilder: (context, imageProvider) => Container(
                        height: imageSize,
                        width: imageSize,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 15.r,
                            color: primaryColor,
                          ),
                          borderRadius: BorderRadius.circular(200.r),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      placeholder: (context, url) => Container(
                        height: imageSize,
                        width: imageSize,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 15.r,
                            color: primaryColor,
                          ),
                          borderRadius: BorderRadius.circular(200.r),
                        ),
                        child: Center(
                          child: Lottie.asset(
                            'icons/loading.json',
                            height: 90.r,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        height: imageSize,
                        width: imageSize,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 15.r,
                            color: primaryColor,
                          ),
                          borderRadius: BorderRadius.circular(200.r),
                          image: const DecorationImage(
                            image: AssetImage("images/user.jpeg"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (isLoading.value)
                    SizedBox(
                      height: imageSize,
                      width: imageSize,
                      child: Center(
                        child: Lottie.asset(
                          'icons/loading.json',
                          height: 90.r,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),

          // image button
          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: () {
                // select image
                pickAndUploadProfileImage();
              },
              child: ClipOval(
                child: Container(
                  height: buttonSize,
                  width: buttonSize,
                  color: Colors.white,
                  child: Center(
                    child: SvgPicture.asset(
                      'icons/camera.svg',
                      height: iconSize,
                      width: iconSize,
                      colorFilter:
                          ColorFilter.mode(primaryColor, BlendMode.srcIn),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}
