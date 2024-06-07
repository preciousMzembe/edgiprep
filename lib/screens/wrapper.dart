import 'package:edgiprep/components/side_menu.dart';
import 'package:edgiprep/controllers/nav_controller.dart';
import 'package:edgiprep/screens/learn.dart';
import 'package:edgiprep/screens/home.dart';
import 'package:edgiprep/screens/notes.dart';
import 'package:edgiprep/screens/settings.dart';
import 'package:edgiprep/screens/test.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:edgiprep/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  final navController = Get.find<NavController>();

  late PageController _controller;
  void _onItemTapped(int index) {
    navController.changeSelectedIndex(index);
    _controller.jumpToPage(index);
  }

  void _onPageChanged(int index) {
    navController.changeSelectedIndex(index);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = PageController(initialPage: navController.selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isTablet = Responsive.isTablet(context);
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Row(
          children: [
            // nav
            if (isTablet)
              Expanded(
                flex: 4,
                child: SideMenu(
                  navigate: (index) {
                    _onItemTapped(index);
                  },
                ),
              ),

            // body
            Expanded(
              flex: 7,
              child: PageView(
                controller: _controller,
                onPageChanged: _onPageChanged,
                children: [
                  Home(seeAll: () {
                    _onItemTapped(1);
                  }),
                  const Learn(),
                  const Test(),
                  const Notes(),
                  const Settings(),
                ],
              ),
            ),
          ],
        ),
      ),

      // bottom navigation
      bottomNavigationBar: isMobile
          ? Obx(
              () => BottomAppBar(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                color: Colors.white,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: grayColor, // Set your desired color
                        width: .5, // Set border width
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // home
                      NavOption(
                        name: "Home",
                        image: "home.png",
                        selected: navController.selectedIndex == 0,
                        click: () {
                          _onItemTapped(0);
                        },
                      ),

                      // learn
                      NavOption(
                        name: "Learn",
                        image: "bulb.png",
                        selected: navController.selectedIndex == 1,
                        click: () {
                          _onItemTapped(1);
                        },
                      ),
                      // test
                      NavOption(
                        name: "Test",
                        image: "timer.png",
                        selected: navController.selectedIndex == 2,
                        click: () {
                          _onItemTapped(2);
                        },
                      ),

                      // notes
                      NavOption(
                        name: "Notes",
                        image: "notes.png",
                        selected: navController.selectedIndex == 3,
                        click: () {
                          _onItemTapped(3);
                        },
                      ),
                      // profile
                      NavOption(
                        name: "Settings",
                        image: "settings.png",
                        selected: navController.selectedIndex == 4,
                        click: () {
                          _onItemTapped(4);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            )
          : SizedBox(
              height: 0.0,
            ),
    );
  }
}

class NavOption extends StatelessWidget {
  final String name;
  final String image;
  final bool selected;
  final Function click;
  const NavOption(
      {super.key,
      required this.image,
      required this.selected,
      required this.click,
      required this.name});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            click();
          },
          child: SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "icons/$image",
                  height: 40,
                  color: selected ? primaryColor : Colors.grey[500],
                ),
                Text(
                  name,
                  style: GoogleFonts.nunito(
                    color: selected ? primaryColor : Colors.grey[500],
                    fontWeight: selected ? FontWeight.w900 : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
