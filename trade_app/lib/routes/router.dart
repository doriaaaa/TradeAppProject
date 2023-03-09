import 'package:flutter/material.dart';
import 'package:trade_app/screens/changePassword.dart';
import 'package:trade_app/screens/homePage.dart';
import 'package:trade_app/screens/registerPage.dart';
import 'package:trade_app/screens/search.dart';
import 'package:trade_app/widgets/navBar.dart';
import 'package:trade_app/screens/loginPage.dart';
import '../screens/aboutApp.dart';
import '../screens/notificationPage.dart';
import '../screens/settingsPage.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case loginPage.routeName:
      return MaterialPageRoute( settings: routeSettings, builder: (_) => const loginPage());
    case registerPage.routeName:
      return MaterialPageRoute( settings: routeSettings, builder: (_) => const registerPage());
    case NavBar.routeName:
      return MaterialPageRoute( settings: routeSettings, builder: (_) => const NavBar());
    case homePage.routeName:
      return MaterialPageRoute( settings: routeSettings, builder: (_) => const homePage());
    case SearchPage.routeName:
      return MaterialPageRoute( settings: routeSettings, builder: (_) => const SearchPage());
    case notificationPage.routeName:
      return MaterialPageRoute( settings: routeSettings, builder: (_) => const notificationPage());
    case settingsPage.routeName:
      return MaterialPageRoute( settings: routeSettings, builder: (_) => const settingsPage());
    case aboutAppPage.routeName:
      return MaterialPageRoute( settings: routeSettings, builder: (_) => const aboutAppPage());
    case changePasswordPage.routeName:
      return MaterialPageRoute( settings: routeSettings, builder: (_) => const changePasswordPage());
    default:
      return MaterialPageRoute( settings: routeSettings, builder: (_) => const Scaffold( body: Center( child: Text('Screen does not exist!'))));
  }
}
