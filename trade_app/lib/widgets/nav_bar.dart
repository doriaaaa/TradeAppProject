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
      bottomNavigationBar: Container(
        child: GNav(
          gap: 0.5,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          backgroundColor: Colors.black,
          color: Colors.white,
          activeColor: Colors.white,
          onTabChange: (value) {
            print(value);
          },
          tabs: [
            GButton(
              icon: Icons.list, 
              text: 'wishlist',
              onPressed: () => {},
            ),
            GButton(
              icon: Icons.history, 
              text: 'history',
              onPressed: () => {},
            ),
            GButton(
              icon: Icons.bookmark_outline, 
              text: 'books', 
              onPressed: () => _slidingPanel(),
            ),
            GButton(
              icon: Icons.notifications_outlined, 
              text: 'notifications',
              onPressed: () => {},
            ),
            GButton(
              icon: Icons.settings_outlined, 
              text: 'settings',
              onPressed: () => {},
            ),
          ]
        )
      )
    );
  }

  void _slidingPanel() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      builder: (context) {
        return Column(
          children: <Widget>[
            GridView.count(
              shrinkWrap: true,
              primary: true,
              crossAxisCount: 2,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // Expanded(child: Container()),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {}, 
                          icon: const Icon (
                            Icons.calendar_month,
                            color: Colors.redAccent,
                            size: 25.0,
                          )
                        ),
                        const Text(
                          'calendar', 
                          style: TextStyle(
                            color: Colors.redAccent
                          )
                        )
                      ],
                    )
                  ]
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // Expanded(child: Container()),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {}, 
                          icon: const Icon (
                            Icons.upload,
                            color: Colors.amberAccent,
                            size: 25.0,
                          )
                        ),
                        const Text(
                          'add', 
                          style: TextStyle(
                            color: Colors.amberAccent
                          )
                        )
                      ],
                    )
                  ]
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // Expanded(child: Container()),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {}, 
                          icon: const Icon (
                            Icons.handshake,
                            color: Colors.blueAccent,
                            size: 25.0,
                          )
                        ),
                        const Text(
                          'exchange', 
                          style: TextStyle(
                            color: Colors.blueAccent
                          )
                        )
                      ],
                    )
                  ]
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // Expanded(child: Container()),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {}, 
                          icon: const Icon (
                            Icons.search,
                            color: Colors.purpleAccent,
                            size: 25.0,
                          )
                        ),
                        const Text(
                          'search', 
                          style: TextStyle(
                            color: Colors.purpleAccent
                          )
                        )
                      ],
                    )
                  ]
                ),
              ],
            ),
          ]
        );
      }
    );
  }
}
