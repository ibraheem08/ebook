import 'package:ebook/homepage.dart';
import 'package:ebook/homepage/screens/bookmark.dart';
import 'package:ebook/homepage/screens/profile.dart';
// import 'package:ebook/homepage/screens/searchscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../color.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currentIndex = 0;
  final screens = [
    HomePage(),
    // Search(),
    BookMark(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
          unselectedItemColor: KFourthColor.withOpacity(0.4),
          selectedItemColor: KFourthColor,
          currentIndex: currentIndex,
          onTap: (index) => setState(() => currentIndex = index),
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/Icons/home.svg',
                color: KFourthColor,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/Icons/search.svg',
                color: KFourthColor,
              ),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/Icons/bookmark.svg',
                color: KFourthColor,
              ),
              label: 'Bookmarks',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/Icons/profile.svg',
                color: KFourthColor,
              ),
              label: 'Profile',
            ),
          ]),
    );
  }
}
