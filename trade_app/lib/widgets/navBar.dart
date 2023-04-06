import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:sizer/sizer.dart';
import 'package:trade_app/screens/bookshelf.dart';
import 'package:trade_app/screens/homePage.dart';
import 'package:trade_app/screens/settingsPage.dart';
import '../screens/chat.dart';
import '../screens/uploadSelectionPage.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);
  static const String routeName = '/navBar';

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedPageIndex = 0;
  final List<Widget> _pages = [
    const homePage(),
    const chatPage(),
    const uploadSelectionPage(),
    const bookshelfPage(),
    const settingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedPageIndex,
        children:_pages
      ),
      bottomNavigationBar: GNav(
        onTabChange: (value) => {
          setState(() {
            _selectedPageIndex = value;
            debugPrint("pages: ${value.toString()}");
          })
        },
        gap: 0.5,
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
        tabs: const [
          GButton( icon: Icons.home_outlined, text: 'home'),
          GButton( icon: Icons.chat_outlined, text: 'chat'),
          GButton( icon: Icons.keyboard_option_key_sharp, text: 'options'),
          GButton( icon: Icons.library_books_outlined ,text: 'bookshelf'),
          GButton( icon: Icons.settings_outlined, text: 'settings'),
        ]
      )
    );
  }
}
