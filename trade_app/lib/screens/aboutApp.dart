import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../widgets/reusableWidget.dart';

class aboutAppPage extends StatefulWidget {
  static const String routeName = '/about';
  static String tag = 'information';
  const aboutAppPage({super.key});
  @override
  State<aboutAppPage> createState() => _aboutAppPageState();
}

class _aboutAppPageState extends State<aboutAppPage> {

  final headerDisplayText = Text('ChatGPT writes this', style: TextStyle(fontSize: 20.0.sp), textAlign: TextAlign.center,);
  static String desc = "A book exchange app is a platform that allows users to exchange books with each other. The app typically allows users to create listings for the books they have available for exchange, search for listings of books they want to acquire, and communicate with other users to arrange the exchange process. A book exchange app can be a valuable resource for book lovers who want to share their books with others and discover new books to read. By providing a platform for book exchanges, the app can also help to reduce waste and promote sustainability by encouraging the reuse of books. Additionally, a book exchange app can provide a community for book enthusiasts to connect and share their passion for reading.";

  final about = Card(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.all(5.w), 
          child: Text( 
            desc, 
            textAlign: TextAlign.justify,
            style: TextStyle(fontSize: 12.0.sp, height: 1.5),
          )
        )
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReusableWidgets.persistentAppBar('About'),
      body: ListView(
        padding: EdgeInsets.only(left: 7.0.w, right: 7.0.w),
        children: <Widget>[
          SizedBox(height: 7.h),
          headerDisplayText,
          SizedBox(height: 4.h),
          about
        ],
      ),
    );
  }
}
