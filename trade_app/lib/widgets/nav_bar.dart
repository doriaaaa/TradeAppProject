import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  // final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: GNav(
        gap: 0.5,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        backgroundColor: Colors.black,
        color: Colors.white,
        activeColor: Colors.white,
        onTabChange: (value) {
          print(value);
        },
        tabs: const [
          GButton(icon: Icons.list, text: 'wishlist'),
          GButton(icon: Icons.history, text: 'history'),
          GButton(icon: Icons.bookmark_outline, text: 'books'),
          GButton(icon: Icons.notifications_outlined, text: 'notifications'),
          GButton(icon: Icons.settings_outlined, text: 'settings'),
        ]
      ),
    );
  }
}