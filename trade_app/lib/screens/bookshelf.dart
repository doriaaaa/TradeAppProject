import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:trade_app/services/user/userBookService.dart';
import 'package:trade_app/widgets/reusableWidget.dart';

class bookshelfPage extends StatefulWidget {
  const bookshelfPage({Key? key}) : super(key: key);

  @override
  State<bookshelfPage> createState() => _bookshelfPageState();
}

class _bookshelfPageState extends State<bookshelfPage> {
  final gapBox = SizedBox(height: 2.h);
  List<Widget> displayItemList = [];

  @override
  void initState() {
    super.initState();
    _buildDisplayItemList();
  }

  void _buildDisplayItemList() async {
    final String res = await userBookService().bookList(context: context);
    Map bookList = jsonDecode(res);
    print(bookList['result'].length);

    for (int i = 0; i < bookList['result'].length; i+=2) {
      displayItemList.add(gapBox);
      // Create a new row with two books if available
      // print(bookList['result'][i]['bookInfo']['title']);
      Row row;
      if (i + 1 < bookList['result'].length) {
        row = Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            bookToWidget(bookList['result'][i]['image']),
            bookToWidget(bookList['result'][i + 1]['image']),
          ]
        );
      } else {
        // Otherwise create a single book row
        row = Row(children: [bookToWidget(bookList['result'][i]['image'])]);
      }
      // Add the row to our shelf list
      displayItemList.add(row);
    }
  }

  Widget bookToWidget(String imageUrl) {
    return GestureDetector(
      child: Container(
        width: 40.w,
        height: 30.h,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          image: DecorationImage(
            image: NetworkImage(imageUrl), //dummy image
            fit: BoxFit.scaleDown
          )
        ),
      ),
      onTap: () {
        
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    final scollBarController = ScrollController(initialScrollOffset: 50.0);

    return Scaffold(
      appBar: ReusableWidgets.persistentAppBar('My Bookshelf'),
      body: Scrollbar(
        thumbVisibility: true,
        controller: scollBarController,
        child: ListView(
          shrinkWrap: true,
          controller: scollBarController,
          padding: EdgeInsets.only(left: 7.0.w, right: 7.0.w),
          children: displayItemList,
        )
      )
    );
  }
}
