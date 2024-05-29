import 'package:edgiprep/screens/learn.dart';
import 'package:edgiprep/screens/home.dart';
import 'package:edgiprep/screens/notes.dart';
import 'package:edgiprep/screens/settings.dart';
import 'package:edgiprep/screens/test.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  late PageController _controller;
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _controller.jumpToPage(index);
  }

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = PageController(initialPage: _selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
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
      // body: SafeArea(
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.stretch,
      //     children: [
      //       // pages
      //       Expanded(
      //         child: _pages[_selectedIndex],
      //       ),
      //     ],
      //   ),
      // ),

      // bottom navigation
      bottomNavigationBar: BottomAppBar(
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
                selected: _selectedIndex == 0,
                click: () {
                  _onItemTapped(0);
                },
              ),

              // learn
              NavOption(
                name: "Learn",
                image: "bulb.png",
                selected: _selectedIndex == 1,
                click: () {
                  _onItemTapped(1);
                },
              ),
              // GestureDetector(
              //   onTap: () {
              //     _onItemTapped(2);
              //   },
              //   child: Container(
              //     height: 60,
              //     width: 60,
              //     decoration: BoxDecoration(
              //       color: _selectedIndex == 2
              //           ? primaryColor
              //           : const Color.fromARGB(214, 47, 59, 98),
              //       borderRadius: BorderRadius.circular(80.r),
              //     ),
              //     child: Center(
              //       child: Image.asset(
              //         "icons/bulb.png",
              //         height: 35,
              //         color: Colors.white,
              //       ),
              //     ),
              //   ),
              // ),

              // test
              NavOption(
                name: "Test",
                image: "timer.png",
                selected: _selectedIndex == 2,
                click: () {
                  _onItemTapped(2);
                },
              ),

              // notes
              NavOption(
                name: "Notes",
                image: "notes.png",
                selected: _selectedIndex == 3,
                click: () {
                  _onItemTapped(3);
                },
              ),
              // profile
              NavOption(
                name: "Settings",
                image: "settings.png",
                selected: _selectedIndex == 4,
                click: () {
                  _onItemTapped(4);
                },
              ),
            ],
          ),
        ),
      ),

      // bottomNavigationBar: NavigationBar(
      //   backgroundColor: primaryColor,
      //   indicatorColor: Colors.white,
      //   destinations: [
      //     NavigationDestination(
      //       icon: const Icon(
      //         FontAwesomeIcons.house,
      //         color: Colors.white,
      //       ),
      //       selectedIcon: Icon(
      //         FontAwesomeIcons.house,
      //         color: primaryColor,
      //       ),
      //       label: 'Home',
      //     ),
      //     NavigationDestination(
      //       icon: const Icon(
      //         FontAwesomeIcons.brain,
      //         color: Colors.white,
      //       ),
      //       selectedIcon: Icon(
      //         FontAwesomeIcons.brain,
      //         color: primaryColor,
      //       ),
      //       label: 'Learn',
      //     ),
      //     NavigationDestination(
      //       icon: const Icon(
      //         FontAwesomeIcons.stopwatch,
      //         color: Colors.white,
      //       ),
      //       selectedIcon: Icon(
      //         FontAwesomeIcons.stopwatch,
      //         color: primaryColor,
      //       ),
      //       label: 'Test',
      //     ),
      //     NavigationDestination(
      //       icon: const Icon(
      //         FontAwesomeIcons.pencil,
      //         color: Colors.white,
      //       ),
      //       selectedIcon: Icon(
      //         FontAwesomeIcons.pencil,
      //         color: primaryColor,
      //       ),
      //       label: 'Notes',
      //     ),
      //   ],
      //   selectedIndex: _selectedIndex,
      //   // selectedItemColor: Colors.white,
      //   // unselectedItemColor: Colors.white54,
      //   onDestinationSelected: _onItemTapped,
      // ),
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
