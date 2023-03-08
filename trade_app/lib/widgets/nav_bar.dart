import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:trade_app/screens/search.dart';
import 'package:trade_app/screens/home_page.dart';
import 'package:trade_app/screens/notification_page.dart';
import 'package:trade_app/screens/settings_page.dart';
import 'package:trade_app/widgets/camera.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);
  static const String routeName = '/info';

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedindex = 0;
  final List<Widget> _children = [
    const HomePage(),
    const SearchPage(),
    const Camera(),
    const NotificationPage(),
    const SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    // ButtonStyle buttonStyle = OutlinedButton.styleFrom(
    //   foregroundColor: Colors.white,
    //   side: const BorderSide(
    //     color: Color.fromARGB(210, 10, 10, 10),
    //     width: 3
    //   ),
    //   minimumSize: const Size(350, 50),
    //   shape: RoundedRectangleBorder(
    //     borderRadius: BorderRadius.circular(10.0),
    //   ),
    // );

    // Text buttonText (String text) {
    //   return Text(
    //     text, 
    //     style: const TextStyle(color: Color.fromARGB(210, 10, 10, 10))
    //   );
    // }

    // final scanISBNButton = OutlinedButton(
    //   style: buttonStyle,
    //   onPressed: () {
    //     //open camera widget
    //     Navigator.push(context, MaterialPageRoute(builder: (context) => const Camera()));
    //   },
    //   child: buttonText("Scan ISBN"),
    // );

    return Scaffold(
      body: _children.elementAt(_selectedindex),
      bottomNavigationBar: GNav(
          onTabChange: (value) => {
            setState(() {
              _selectedindex = value;
              print("pages: ${value.toString()}");
            })
          },
          gap: 0.5,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          backgroundColor: Colors.black,
          color: Colors.white,
          activeColor: Colors.white,
          tabs: const [
            GButton( icon: Icons.home_outlined, text: 'home'),
            GButton( icon: Icons.search, text: 'Search'),
            GButton( icon: Icons.bookmark_outline, text: 'books'),
            GButton( icon: Icons.notifications_outlined, text: 'news'),
            GButton( icon: Icons.settings_outlined, text: 'settings'),
          ]
        )
      );
  }

  // void _slidingPanel() {
  //   showModalBottomSheet(
  //       context: context,
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(30.0),
  //       ),
  //       builder: (context) {
  //         return Column(children: <Widget>[
  //           GridView.count(
  //             shrinkWrap: true,
  //             primary: true,
  //             crossAxisCount: 2,
  //             children: <Widget>[
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: <Widget>[
  //                   // Expanded(child: Container()),
  //                   Column(
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     children: [
  //                       IconButton(
  //                           onPressed: () {},
  //                           icon: const Icon(
  //                             Icons.calendar_month,
  //                             color: Colors.redAccent,
  //                             size: 30.0,
  //                           )),
  //                       const Text('calendar',
  //                           style: TextStyle(color: Colors.redAccent))
  //                     ],
  //                   )
  //                 ]),
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: <Widget>[
  //                   // Expanded(child: Container()),
  //                   Column(
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     children: [
  //                       IconButton(
  //                           onPressed: () {},
  //                           icon: const Icon(
  //                             Icons.upload,
  //                             color: Colors.amberAccent,
  //                             size: 30.0,
  //                           )),
  //                       const Text('add',
  //                           style: TextStyle(color: Colors.amberAccent))
  //                     ],
  //                   )
  //                 ]),
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: <Widget>[
  //                   // Expanded(child: Container()),
  //                   Column(
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     children: [
  //                       IconButton(
  //                           onPressed: () {},
  //                           icon: const Icon(
  //                             Icons.handshake,
  //                             color: Colors.blueAccent,
  //                             size: 30.0,
  //                           )),
  //                       const Text('exchange',
  //                           style: TextStyle(color: Colors.blueAccent))
  //                     ],
  //                   )
  //                 ]),
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: <Widget>[
  //                   // Expanded(child: Container()),
  //                   Column(
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     children: [
  //                       IconButton(
  //                           onPressed: () {},
  //                           icon: const Icon(
  //                             Icons.search,
  //                             color: Colors.purpleAccent,
  //                             size: 30.0,
  //                           )),
  //                       const Text('search',
  //                           style: TextStyle(color: Colors.purpleAccent))
  //                     ],
  //                   )
  //                 ]),
  //             ],
  //           ),
  //         ]);
  //       });
  // }
}
