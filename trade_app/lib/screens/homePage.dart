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
    // print(uploadedBookList['result'].length);
    // print("image link: ${uploadedBookList['result'][0]['image']}");
    // print("title: ${uploadedBookList['result'][0]['bookInfo']['title']}")

    for (int count = 0; count < uploadedBookList['result'].length; count++) {
      String summary = uploadedBookList['result'][count]['bookInfo']['description'];
      // print(summary);
      displayItemList.add(gapBox);
      displayItemList.add(GestureDetector(
        onTap: () {
          // redirect to next page for discussion
          Navigator.push( context, MaterialPageRoute( builder: (context) => discussionPage(book: jsonEncode(uploadedBookList['result'][count]))));
        }, 
        child: Card(
          elevation: 3,
          shape: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          child: Container(
            margin: EdgeInsets.all(5.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Flexible(child: Text(uploadedBookList['result'][count]['bookInfo']['title'], style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.bold))),
                SizedBox(height: 2.h),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.network(
                        uploadedBookList['result'][count]['image'],
                        height: 15.h,
                        width: 30.w,
                        fit: BoxFit.fill
                      ),
                    ),
                    SizedBox(width: 3.w),
                    Expanded(
                      child: SizedBox(
                        width: 30.w, 
                        child: Text(
                          summary.length > 120 
                          ? "${summary.substring(0,120)}..."
                          : summary,
                          style: TextStyle(fontSize: 10.sp)
                        )
                      ),
                    )
                  ],
                ),
                gapBox,
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon( Icons.remove_red_eye_outlined, color: Colors.grey[700]),
                    SizedBox(width: 2.0.w),
                    Text("0", style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.bold)), // dummy data
                    const Spacer(),
                    Icon( Icons.thumb_up_alt_outlined, color: Colors.grey[700]),
                    SizedBox(width: 2.0.w),
                    Text("0", style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.bold)) // dummy data
                  ],
                )
              ],
            )
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
