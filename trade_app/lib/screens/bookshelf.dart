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
    final scrollBarController = ScrollController(initialScrollOffset: 50.0);
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
            image: NetworkImage(imageUrl), //dummy image
            fit: BoxFit.scaleDown
          )
        ),
      ),
      onTap: () => showDialog<String>(
        context: context, 
        builder: (BuildContext context) => Dialog(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Scrollbar(
              thumbVisibility: true,
              controller: scrollBarController,
              child: ListView(
                shrinkWrap: true,
                controller: scrollBarController,
                children: <Widget>[
                  SizedBox(height:2.h),
                  Container(
                    margin: EdgeInsets.only(left: 12.0.w, right: 12.0.w),
                    width: 50.w,
                    height: 60.w,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        image: DecorationImage(
                          image: NetworkImage(imageUrl), 
                          fit: BoxFit.scaleDown
                        )
                      )
                    )
                  ),
                  SizedBox(height:2.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          title,
                          textAlign: TextAlign.center,
                          style: TextStyle( fontSize: 14.sp, fontWeight: FontWeight.w500)
                        )
                      )
                    ]
                  ),
                  SizedBox(height:1.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child:Text(
                          "By $author",
                          textAlign: TextAlign.center,
                          style: TextStyle( fontSize: 12.sp, fontStyle: FontStyle.italic)
                        )
                      )
                    ]
                  ),
                  SizedBox(height:0.5.h),
                  Container(
                    margin: EdgeInsets.all(4.w),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text( 
                          description, 
                          textAlign: TextAlign.justify,
                          style: TextStyle(fontSize: 12.0.sp, height: 1.5),
                        )
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      OutlinedButton(
                        onPressed: () {}, 
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)
                          )
                        ),
                        child: Row(
                          children: const <Widget>[
                            Icon( Icons.favorite_border ),
                            Text("LIKE")
                          ]
                        )
                      ),
                      // share button --> redirect to new post 
                      OutlinedButton(
                        onPressed: () { Navigator.pushNamed(context, '/createNewThread', arguments: {'title': title}); }, 
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)
                          )
                        ),
                        child: Row(
                          children: const <Widget>[
                            Icon( Icons.share ),
                            Text("SHARE")
                          ]
                        )
                      ),
                    ]
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Close'),
                  ),
                ],
              )
            ),
          ),
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    final scrollBarController = ScrollController(initialScrollOffset: 50.0);

    return Scaffold(
      appBar: ReusableWidgets.persistentAppBar('My Bookshelf'),
      body: Scrollbar(
        thumbVisibility: true,
        controller: scrollBarController,
        child: ListView(
          shrinkWrap: true,
          controller: scrollBarController,
          padding: EdgeInsets.only(left: 7.0.w, right: 7.0.w),
          children: isLoading
          ? [
            SizedBox(height: 10.h),
            const Center(child: CircularProgressIndicator())
          ]
          : displayItemList,
        )
      )
    );
  }
}
