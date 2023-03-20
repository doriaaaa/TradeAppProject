import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:trade_app/services/comment/commentService.dart';
import 'package:trade_app/services/thread/threadService.dart';
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
    final String res = await threadService().displayAllThreads(context: context);
    Map threadList = jsonDecode(res);

    // list starts with the latest one first
    for (int count = threadList['result'].length-1; count >= 0; count--) {
      String title = threadList['result'][count]['title'];
      String author = threadList['result'][count]['author'];
      String content = threadList['result'][count]['content'];
      int threadId = threadList['result'][count]['thread_id'];
      int likes = threadList['result'][count]['likes'];
      int views = threadList['result'][count]['views'];
      String createdAt = threadList['result'][count]['createdAt'];

      displayItemList.add(gapBox);
      displayItemList.add(GestureDetector(
        onTap: () async {
          commentService().displayAllCommentsInThread(
            context: context, 
            title: title,
            author: author,
            content: content,
            threadId: threadId,
            likes: likes,
            views: views,
            createdAt: createdAt
          );
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
                Flexible(child: Text('#$threadId\t$author', style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.bold))),
                SizedBox(height: 2.h),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: SizedBox(
                        width: 30.w, 
                        child: Text(title, style: TextStyle(fontSize: 12.sp))
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
                    Text('$likes', style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.bold)), // dummy data
                    const Spacer(),
                    Icon( Icons.thumb_up_alt_outlined, color: Colors.grey[700]),
                    SizedBox(width: 2.0.w),
                    Text('$views', style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.bold)) // dummy data
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
