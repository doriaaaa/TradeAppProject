import 'dart:convert';

import 'package:basic_utils/basic_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:sizer/sizer.dart';
import 'package:trade_app/services/user/userBookService.dart';
import 'package:trade_app/widgets/reusableWidget.dart';

import '../widgets/recommendationModal.dart';

class bookshelfPage extends StatefulWidget {
  const bookshelfPage({Key? key}) : super(key: key);

  @override
  State<bookshelfPage> createState() => _bookshelfPageState();
}

class _bookshelfPageState extends State<bookshelfPage> {
  final gapBox = SizedBox(height: 2.h);
  List<Widget> displayItemList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _buildDisplayItemList();
  }

  void _buildDisplayItemList() async {
    final String res = await userBookService().bookList(context: context);
    Map bookList = jsonDecode(res);
    // print(bookList['result'].length);
    if(context.mounted) {
      for (int i = 0; i < bookList['result'].length; i+=2) {
        displayItemList.add(gapBox);
        // Create a new row with two books if available
        // print(bookList['result'][i]['bookInfo']['title']);
        Row row;
        if (i + 1 < bookList['result'].length) {
          row = Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              bookToWidget(context, jsonEncode(bookList['result'][i])),
              bookToWidget(context, jsonEncode(bookList['result'][i + 1])),
            ]
          );
        } else {
          // Otherwise create a single book row
          row = Row(children: [bookToWidget(context, jsonEncode(bookList['result'][i]))]);
        }
        // Add the row to our shelf list
        displayItemList.add(row);
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  Widget bookToWidget(BuildContext context, String bookObj) {
    final scrollBarController = ScrollController(initialScrollOffset: 0.0);
    Map book = jsonDecode(bookObj);
    String imageUrl = book['image'];
    String title = book['bookInfo']['title'];
    String description = (book['bookInfo'].containsKey('description')) ? book['bookInfo']['description'] : "Description is not available.";
    String author = (book['bookInfo'].containsKey('authors') && book['bookInfo']['authors'].length != 0) ? book['bookInfo']['authors'][0] : "unknown";

    return GestureDetector(
      child: Container(
        width: 40.w,
        height: 30.h,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          image: DecorationImage(
            image: CachedNetworkImageProvider(imageUrl), //dummy image
            fit: BoxFit.scaleDown
          )
        ),
      ),
      onTap: () => showBarModalBottomSheet(
        expand: false,
        context: context, 
        backgroundColor: Colors.transparent,
        builder: (context) => recommendationModal(
          // pass title, author, book picture url, description
          title: title,
          author: author,
          bookCoverUrl: imageUrl,
          description: description
        )
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scrollBarController = ScrollController(initialScrollOffset: 0.0);
    return Scaffold(
      appBar: ReusableWidgets.persistentAppBar('My Bookshelf'),
      body: isLoading
      ? const Center(child: CupertinoActivityIndicator())
      : Scrollbar(
        thumbVisibility: true,
        controller: scrollBarController,
        child: ListView(
          shrinkWrap: true,
          controller: scrollBarController,
          padding: EdgeInsets.only(left: 7.0.w, right: 7.0.w),
          children: displayItemList,
        )
      )
    );
  }
}
