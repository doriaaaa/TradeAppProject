import 'package:flutter/material.dart';
import 'package:trade_app/screens/changePassword.dart';
import 'package:trade_app/screens/createThreadPage.dart';
import 'package:trade_app/screens/registerPage.dart';
import 'package:trade_app/widgets/navBar.dart';
import 'package:trade_app/screens/loginPage.dart';
import '../screens/aboutApp.dart';
import '../widgets/camera.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case loginPage.routeName:
      return MaterialPageRoute( settings: routeSettings, builder: (_) => const loginPage());
    case registerPage.routeName:
      return MaterialPageRoute( settings: routeSettings, builder: (_) => const registerPage());
    case NavBar.routeName:
      return MaterialPageRoute( settings: routeSettings, builder: (_) => const NavBar());
    case aboutAppPage.routeName:
      return MaterialPageRoute( settings: routeSettings, builder: (_) => const aboutAppPage());
    case changePasswordPage.routeName:
      return MaterialPageRoute( settings: routeSettings, builder: (_) => const changePasswordPage());
    case Camera.routeName:
      return MaterialPageRoute( settings: routeSettings, builder: (_) => const Camera());
    case createThreadPage.routeName:
      return MaterialPageRoute( settings: routeSettings, builder: (_) => const createThreadPage());
    default:
      return MaterialPageRoute( settings: routeSettings, builder: (_) => const Scaffold( body: Center( child: Text('Screen does not exist!'))));
  }
}
