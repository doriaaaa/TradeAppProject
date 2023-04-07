import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sizer/sizer.dart';
import 'package:trade_app/provider/comment_provider.dart';
import 'package:trade_app/screens/loginPage.dart';
import 'package:trade_app/routes/router.dart';
import 'package:provider/provider.dart';
import 'package:trade_app/provider/user_provider.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider( create: (context) => UserProvider()),
        ChangeNotifierProvider( create: (context) => CommentProvider())
      ], 
      child: const MyApp()
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();

  /// InheritedWidget style accessor to our State object.
  /// We can call this static method from any descendant context to find our
  /// State object and switch the themeMode field value & call for a rebuild.
  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {
  /// 1) our themeMode "state" field
  ThemeMode _themeMode = ThemeMode.system;

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        title: 'Trade App',
        theme: ThemeData(),
        darkTheme: ThemeData.dark(),
        themeMode: _themeMode, // 2) ← ← ← use "state" field here //////////////
        home: const loginPage(),
        // home: const bookshelfPage(),
        onGenerateRoute: (settings) => generateRoute(settings),
      );
    });
  }
  /// 3) Call this to change theme from any context using "of" accessor
  /// e.g.:
  /// MyApp.of(context).changeTheme(ThemeMode.dark);
  void changeTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }
}