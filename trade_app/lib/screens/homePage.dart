import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:sizer/sizer.dart';
import 'package:trade_app/services/getUserInfo.dart';
import 'package:trade_app/widgets/reusableWidget.dart';
import 'package:trade_app/provider/user_provider.dart';
import 'package:provider/provider.dart';

class homePage extends StatefulWidget {
  static const String routeName = '/home';
  const homePage({Key? key}) : super(key: key);

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  // final slide = ImageSlideshow(
  //   indicatorColor: Colors.white,
  //   // onPageChanged: (value) { debugPrint('Page changed: $value');},
  //   children: [
  //     Image.network("http://books.google.com/books/content?id=-VfNSAAACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api"),
  //     Image.network("http://books.google.com/books/content?id=fltxyAEACAAJ&printsec=frontcover&img=1&zoom=5&source=gbs_api"),
  //     Image.network("http://books.google.com/books/content?id=T929zgEACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api"),
  //   ],
  // );
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
    print(uploadedBookList);

    for (int count = 0; count < 5; count++) {
      displayItemList.add(gapBox);
      displayItemList.add(displayItem);
    }
  }

  var displayItem = GestureDetector(
      onTap: () {
        // redirect to next page for discussion
      },
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset("assets/avatar.jpg"),
            Padding(
                padding: EdgeInsets.all(3.w),
                child: Text("test",
                    style: TextStyle(fontSize: 12.0.sp, height: 1.0)))
          ],
        ),
      ));

  // final recommendationHeaderDisplayText = Text("Latest Recommendation", style: TextStyle(fontSize: 20.0.sp));
  // final bestBookHeaderDisplayText = Text("The best books that we choose for you", style: TextStyle(fontSize: 20.0.sp));
  @override
  Widget build(BuildContext context) {
    final scollBarController = ScrollController(initialScrollOffset: 50.0);
    var username = context.watch<UserProvider>().user.name;
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
              // SizedBox(height: 3.h),
              // recommendationHeaderDisplayText,
              // SizedBox(height: 3.h),
              // slide,
              // SizedBox(height: 3.h),
              // bestBookHeaderDisplayText,
              // SizedBox(height: 3.h),
              // slide,
              // SizedBox(height: 3.h),
              // slide,
              ),
        ));
  }
}
