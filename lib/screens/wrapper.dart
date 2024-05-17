import 'package:edgiprep/screens/learn.dart';
import 'package:edgiprep/screens/home.dart';
import 'package:edgiprep/screens/notes.dart';
import 'package:edgiprep/screens/test.dart';
import 'package:edgiprep/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static const List<Widget> _pages = [
    Home(),
    Learn(),
    Test(),
    Notes(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // pages
            Expanded(
              child: _pages[_selectedIndex],
            ),
          ],
        ),
      ),

      // bottom navigation
      bottomNavigationBar: NavigationBar(
        backgroundColor: primaryColor,
        indicatorColor: Colors.white,
        destinations: [
          NavigationDestination(
            icon: const Icon(
              FontAwesomeIcons.house,
              color: Colors.white,
            ),
            selectedIcon: Icon(
              FontAwesomeIcons.house,
              color: primaryColor,
            ),
            label: 'Home',
          ),
          NavigationDestination(
            icon: const Icon(
              FontAwesomeIcons.brain,
              color: Colors.white,
            ),
            selectedIcon: Icon(
              FontAwesomeIcons.brain,
              color: primaryColor,
            ),
            label: 'Learn',
          ),
          NavigationDestination(
            icon: const Icon(
              FontAwesomeIcons.stopwatch,
              color: Colors.white,
            ),
            selectedIcon: Icon(
              FontAwesomeIcons.stopwatch,
              color: primaryColor,
            ),
            label: 'Test',
          ),
          NavigationDestination(
            icon: const Icon(
              FontAwesomeIcons.pencil,
              color: Colors.white,
            ),
            selectedIcon: Icon(
              FontAwesomeIcons.pencil,
              color: primaryColor,
            ),
            label: 'Notes',
          ),
        ],
        selectedIndex: _selectedIndex,
        // selectedItemColor: Colors.white,
        // unselectedItemColor: Colors.white54,
        onDestinationSelected: _onItemTapped,
      ),
    );
  }
}
