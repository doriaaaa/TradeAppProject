import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:sizer/sizer.dart';
import 'package:trade_app/screens/search.dart';
import 'package:trade_app/screens/homePage.dart';
import 'package:trade_app/screens/notificationPage.dart';
import 'package:trade_app/screens/settingsPage.dart';
import 'package:trade_app/widgets/camera.dart';

import '../screens/uploadSelectionPage.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);
  static const String routeName = '/navBar';

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedindex = 0;
  final List<Widget> _children = [
    const homePage(),
    const SearchPage(),
    const uploadSelectionPage(),
    const notificationPage(),
    const settingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children.elementAt(_selectedindex),
      bottomNavigationBar: GNav(
        onTabChange: (value) => {
          setState(() {
            _selectedindex = value;
            debugPrint("pages: ${value.toString()}");
          })
        },
        gap: 0.5,
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
        tabs: const [
          GButton( icon: Icons.home_outlined, text: 'home'),
          GButton( icon: Icons.search, text: 'search'),
          GButton( icon: Icons.bookmark_outline, text: 'books'),
          GButton( icon: Icons.notifications_outlined, text: 'news'),
          GButton( icon: Icons.settings_outlined, text: 'settings'),
        ]
      )
    );
  }
}
