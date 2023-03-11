import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:sizer/sizer.dart';
import 'package:trade_app/screens/search.dart';
import 'package:trade_app/screens/homePage.dart';
import 'package:trade_app/screens/notificationPage.dart';
import 'package:trade_app/screens/settingsPage.dart';
import 'package:trade_app/widgets/camera.dart';

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
    const Camera(),
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
            print("pages: ${value.toString()}");
          })
        },
        gap: 0.5,
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
        backgroundColor: Colors.black,
        color: Colors.white,
        activeColor: Colors.white,
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
