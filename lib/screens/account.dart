import 'package:edgiprep/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  late TextEditingController pinController;
  late TextEditingController verifyPinController;
  late FocusNode focusNode;
  late FocusNode verifyFocusNode;

  @override
  void initState() {
    super.initState();

    pinController = TextEditingController();
    verifyPinController = TextEditingController();
    focusNode = FocusNode();
    verifyFocusNode = FocusNode();
  }

  @override
  void dispose() {
    pinController.dispose();
    verifyPinController.dispose();
    focusNode.dispose();
    verifyFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color focusedBorderColor = primaryColor;
    const fillColor = Color.fromRGBO(243, 246, 249, 0);
    Color borderColor = primaryColor;
    final defaultPinTheme = PinTheme(
      width: 60,
      height: 60,
      textStyle: TextStyle(
        fontSize: 22,
        color: primaryColor,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.r),
        border: Border.all(color: borderColor),
      ),
    );
    return LayoutBuilder(
      builder: (context, constants) {
        final isTall = constants.maxHeight > constants.maxWidth;
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 30.h,
                ),
                // top
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // back
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          width: 50.w,
                          height: 50.w,
                          color: Colors.transparent,
                          child: Icon(
                            FontAwesomeIcons.arrowLeft,
                            size: 40.w,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: ListView(
                    children: [
                      // heading
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30.w),
                        child: Text(
                          "Manage your \naccount",
                          style: GoogleFonts.nunito(
                            fontSize: 60.sp,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),

                      // update username and pin
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // Username
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Username",
                              style: GoogleFonts.nunito(
                                fontSize: 25.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            TextField(
                              style: TextStyle(fontSize: 25.sp),
                              decoration: InputDecoration(
                                isDense: true,
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1.0,
                                      color: Color.fromARGB(90, 158, 158, 158)),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1.0, color: primaryColor),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5.0,
                                ),
                              ),
                            ),

                            // button
                            const SizedBox(
                              height: 20,
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 50.w,
                                ),
                                height: 80.h,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1.0,
                                    color: primaryColor,
                                  ),
                                  color:
                                      const Color.fromRGBO(47, 59, 98, 0.123),
                                  borderRadius: BorderRadius.circular(80.r),
                                ),
                                child: Center(
                                  child: Text(
                                    "Update Username",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.nunito(
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            // Pin
                            const SizedBox(
                              height: 30,
                            ),
                            Text(
                              "New Pin",
                              style: GoogleFonts.nunito(
                                fontSize: 25.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                Pinput(
                                  obscureText: true,
                                  controller: pinController,
                                  focusNode: focusNode,
                                  defaultPinTheme: defaultPinTheme,
                                  separatorBuilder: (index) =>
                                      const SizedBox(width: 8),
                                  hapticFeedbackType:
                                      HapticFeedbackType.lightImpact,
                                  onChanged: (value) {},
                                  cursor: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 9),
                                        width: 22,
                                        height: 1,
                                        color: focusedBorderColor,
                                      ),
                                    ],
                                  ),
                                  focusedPinTheme: defaultPinTheme.copyWith(
                                    decoration:
                                        defaultPinTheme.decoration!.copyWith(
                                      borderRadius: BorderRadius.circular(30.r),
                                      border:
                                          Border.all(color: focusedBorderColor),
                                    ),
                                  ),
                                  submittedPinTheme: defaultPinTheme.copyWith(
                                    decoration:
                                        defaultPinTheme.decoration!.copyWith(
                                      color: fillColor,
                                      borderRadius: BorderRadius.circular(19),
                                      border:
                                          Border.all(color: focusedBorderColor),
                                    ),
                                  ),
                                  errorPinTheme: defaultPinTheme.copyBorderWith(
                                    border: Border.all(color: Colors.redAccent),
                                  ),
                                ),

                                // view pin
                                const SizedBox(
                                  width: 20,
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: Icon(
                                    FontAwesomeIcons.eye,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),

                            // verify pin
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Verify Pin",
                              style: GoogleFonts.nunito(
                                fontSize: 25.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                Pinput(
                                  obscureText: true,
                                  controller: verifyPinController,
                                  focusNode: verifyFocusNode,
                                  defaultPinTheme: defaultPinTheme,
                                  separatorBuilder: (index) =>
                                      const SizedBox(width: 8),
                                  hapticFeedbackType:
                                      HapticFeedbackType.lightImpact,
                                  onChanged: (value) {},
                                  cursor: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 9),
                                        width: 22,
                                        height: 1,
                                        color: focusedBorderColor,
                                      ),
                                    ],
                                  ),
                                  focusedPinTheme: defaultPinTheme.copyWith(
                                    decoration:
                                        defaultPinTheme.decoration!.copyWith(
                                      borderRadius: BorderRadius.circular(30.r),
                                      border:
                                          Border.all(color: focusedBorderColor),
                                    ),
                                  ),
                                  submittedPinTheme: defaultPinTheme.copyWith(
                                    decoration:
                                        defaultPinTheme.decoration!.copyWith(
                                      color: fillColor,
                                      borderRadius: BorderRadius.circular(19),
                                      border:
                                          Border.all(color: focusedBorderColor),
                                    ),
                                  ),
                                  errorPinTheme: defaultPinTheme.copyBorderWith(
                                    border: Border.all(color: Colors.redAccent),
                                  ),
                                ),

                                // view pin
                                const SizedBox(
                                  width: 20,
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: Icon(
                                    FontAwesomeIcons.eye,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),

                            // button
                            const SizedBox(
                              height: 20,
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 50.w,
                                ),
                                height: 80.h,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1.0,
                                    color: primaryColor,
                                  ),
                                  color:
                                      const Color.fromRGBO(47, 59, 98, 0.123),
                                  borderRadius: BorderRadius.circular(80.r),
                                ),
                                child: Center(
                                  child: Text(
                                    "Update Pin",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.nunito(
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // delete account
                      const SizedBox(
                        height: 40,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30.w),
                        child: Text(
                          "Permanently delete your account and \nall associated data.",
                          style: GoogleFonts.nunito(
                            // fontSize: 60.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),

                      // button
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30.w),
                        child: GestureDetector(
                          onTap: () {
                            showDeleteDialog(
                              context,
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 50.w,
                            ),
                            height: 80.h,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1.0,
                                color: const Color.fromRGBO(244, 67, 54, 1),
                              ),
                              color: const Color.fromRGBO(244, 67, 54, 0.123),
                              borderRadius: BorderRadius.circular(80.r),
                            ),
                            child: Center(
                              child: Text(
                                "Delete Account",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.nunito(
                                  fontWeight: FontWeight.w600,
                                  color: const Color.fromRGBO(244, 67, 54, 1),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30.w),
                        child: Text(
                          "Deleting your account will log you out and all your data will be deleted.",
                          style: GoogleFonts.nunito(
                            fontWeight: FontWeight.w500,
                            color: const Color.fromRGBO(244, 67, 54, 1),
                          ),
                        ),
                      ),

                      // bottom
                      const SizedBox(
                        height: 100,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

Future<void> showDeleteDialog(BuildContext context) async {
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
                                  FontAwesomeIcons.solidTrashCan,
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
                      "Delete Account?",
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
                      "Are you sure you want to delete your account? This action is irreversible.",
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
                                child: Text("Cancel"),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.r),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              height: 60.h,
                              width: 200.w,
                              color: Colors.red,
                              padding: EdgeInsets.symmetric(
                                horizontal: 30.w,
                              ),
                              child: const Center(
                                child: Text(
                                  "Delete",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
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
