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

  final headerDisplayText = Text('CUHK FYP project', style: TextStyle(fontSize: 20.0.sp), textAlign: TextAlign.center,);
  static String desc = "Passing reading material such as UGFN/H books from senior to junior years is always a tradition in CUHK, but due to COVID-19, it's harder now to meet new friends. Most of them after finishing the course will just simply throw the textbooks away as they have no one to pass them on to. It will become a waste of paper and money since those books are quite thick and consumed lots of paper to print instead. To address the waste and encourage students in CUHK to meet each other, we decided to develop an application, which lets people trade stuff that they won't need for something useful while promising them social interactions, letting them have a chance to meet some new friends.";

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
          SizedBox(height: 5.h),
          about
        ],
      ),
    );
  }
}
