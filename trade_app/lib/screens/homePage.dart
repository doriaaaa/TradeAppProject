import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:trade_app/screens/discussionPage.dart';
import 'package:trade_app/services/getUserInfo.dart';
import 'package:trade_app/widgets/reusableWidget.dart';
import 'package:trade_app/provider/user_provider.dart';
import 'package:provider/provider.dart';

class homePage extends StatefulWidget {
  const homePage({Key? key}) : super(key: key);

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {

  final gapBox = SizedBox(height: 2.h);
  List<Widget> displayItemList = [];

  @override
  void initState() {
    super.initState();
    _buildDisplayItemList();
  }

  void _buildDisplayItemList() async {
    final String res = await getUserInfo().getUploadedBookInfo(context: context);
    Map uploadedBookList = jsonDecode(res);
    print(uploadedBookList['result'].length);
    print("image link: ${uploadedBookList['result'][0]['image']}");
    print("title: ${uploadedBookList['result'][0]['bookInfo']['title']}");

    for (int count = 0; count < uploadedBookList['result'].length; count++) {
      displayItemList.add(gapBox);
      displayItemList.add(GestureDetector(
        onTap: () {
          // redirect to next page for discussion
          Navigator.push( context, MaterialPageRoute( builder: (context) => discussionPage(book: uploadedBookList['result'][count])));
        }, 
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(uploadedBookList['result'][count]['image']),
              Padding(
                padding: EdgeInsets.all(3.w),
                child: Text(uploadedBookList['result'][count]['bookInfo']['title'],
                style: TextStyle(fontSize: 12.0.sp, height: 1.0))
              )
            ],
          ),
        )
      ));
    }
  }

  // final recommendationHeaderDisplayText = Text("Latest Recommendation", style: TextStyle(fontSize: 20.0.sp));
  // final bestBookHeaderDisplayText = Text("The best books that we choose for you", style: TextStyle(fontSize: 20.0.sp));
  @override
  Widget build(BuildContext context) {
    final scollBarController = ScrollController(initialScrollOffset: 50.0);
    String username = context.watch<UserProvider>().user.name;
    return Scaffold(
      appBar: ReusableWidgets.persistentAppBar('Welcome back! $username'),
      body: Scrollbar(
        thumbVisibility: true,
        controller: scollBarController,
        child: ListView(
          shrinkWrap: true,
          controller: scollBarController,
          padding: EdgeInsets.only(left: 7.0.w, right: 7.0.w),
          children: displayItemList
        ),
      )
    );
  }
}
