import 'package:edgiprep/controllers/nav_controller.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SideMenu extends StatefulWidget {
  final Function navigate;
  const SideMenu({super.key, required this.navigate});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  final navController = Get.find<NavController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        color: const Color.fromARGB(255, 235, 235, 235),
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
          vertical: 50.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // logo
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // name
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      FontAwesomeIcons.slack,
                      color: primaryColor,
                      size: 70.h,
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Text(
                      "EdgiPrep",
                      style: GoogleFonts.nunito(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),

                // notifications
                SizedBox(
                  width: 30.w,
                ),
                Image.asset(
                  "icons/bell.png",
                  height: 40.w,
                  color: primaryColor,
                ),
              ],
            ),

            // user
            SizedBox(
              height: 40.h,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(20.r),
              child: Container(
                color: primaryColor,
                padding: EdgeInsets.symmetric(
                  horizontal: 10.w,
                  vertical: 10.w,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // account
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100.r),
                            child: Container(
                              height: 40.w,
                              width: 40.w,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('images/male.jpg'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: MaterialButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    85.r,
                                  ),
                                ),
                                color: Colors.transparent,
                                height: 50.w,
                                onPressed: () {},
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Precious",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.nunito(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w900,
                                    height: 1.3,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  "MSCE",
                                  style: TextStyle(
                                    fontSize: 8.sp,
                                    fontWeight: FontWeight.bold,
                                    color: const Color.fromARGB(
                                        255, 189, 189, 189),
                                    // height: .9,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // settings
                    SizedBox(
                      width: 30.w,
                    ),
                    Image.asset(
                      "icons/settings.png",
                      height: 20.w,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),

            // nav
            SizedBox(
              height: 20.h,
            ),
            Expanded(
              child: ListView(
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  // home
                  NavOption(
                    name: "Home",
                    image: "home.png",
                    selected: navController.selectedIndex == 0,
                    navigate: () {
                      widget.navigate(0);
                    },
                  ),

                  // learn
                  const SizedBox(
                    height: 10.0,
                  ),
                  NavOption(
                    name: "Learn",
                    image: "bulb.png",
                    selected: navController.selectedIndex == 1,
                    navigate: () {
                      widget.navigate(1);
                    },
                  ),
                  // test
                  const SizedBox(
                    height: 10.0,
                  ),
                  NavOption(
                    name: "Test",
                    image: "timer.png",
                    selected: navController.selectedIndex == 2,
                    navigate: () {
                      widget.navigate(2);
                    },
                  ),

                  // notes
                  const SizedBox(
                    height: 10.0,
                  ),
                  NavOption(
                    name: "Notes",
                    image: "notes.png",
                    selected: navController.selectedIndex == 3,
                    navigate: () {
                      widget.navigate(3);
                    },
                  ),

                  // settings
                  const SizedBox(
                    height: 10.0,
                  ),
                  NavOption(
                    name: "Settings",
                    image: "settings.png",
                    selected: navController.selectedIndex == 4,
                    navigate: () {
                      widget.navigate(4);
                    },
                  ),
                ],
              ),
            ),

            // bottom
          ],
        ),
      ),
    );
  }
}

class NavOption extends StatelessWidget {
  final String name;
  final String image;
  final bool selected;
  final Function navigate;
  const NavOption(
      {super.key,
      required this.name,
      required this.image,
      required this.selected,
      required this.navigate});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigate();
      },
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "icons/$image",
              height: 80.h,
              color: selected
                  ? primaryColor
                  : const Color.fromARGB(255, 136, 136, 136),
            ),
            const SizedBox(
              width: 10.0,
            ),
            Text(
              name,
              style: GoogleFonts.nunito(
                fontSize: 14.sp,
                fontWeight: FontWeight.w900,
                color: selected
                    ? primaryColor
                    : const Color.fromARGB(255, 136, 136, 136),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
