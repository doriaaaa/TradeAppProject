import 'package:flutter/material.dart';
import 'package:trade_app/screens/home_page.dart';
import 'package:trade_app/screens/history_page.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case HomePage.routeName: 
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const HomePage() 
      );
    case HistoryPage.routeName: 
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const HistoryPage() 
      );
    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
          body: Center(
            child: Text('Screen does not exist!'),
          ),
        ),
      );
  }
}