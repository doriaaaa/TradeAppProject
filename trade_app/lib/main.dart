import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sizer/sizer.dart';
import 'package:trade_app/screens/loginPage.dart';
import 'package:trade_app/routes/router.dart';
import 'package:provider/provider.dart';
import 'package:trade_app/provider/user_provider.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
      ], 
    child: const MyApp()
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        title: 'Trade App',
        home: const loginPage(),
        theme: ThemeData(fontFamily: 'Menlo'),
        // home: uploadPage(
        //   screenClosed: () { false; }, 
        //   bookInfoDetails: res
        // ),
        // home: const Camera(),
        onGenerateRoute: (settings) => generateRoute(settings),
      );
    });
  }
}
