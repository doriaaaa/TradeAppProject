import 'dart:convert';
import 'package:flutter/cupertino.dart';
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
  bool isLoading = true;

  @override
  void initState() {
    _buildDisplayItemList();
    super.initState();
  }

  Future<void> _buildDisplayItemList() async {
    final String res = await threadService().showAllThreads(context: context);
    Map threadList = jsonDecode(res);

    // list starts with the latest one first
    for (int count = threadList['result'].length-1; count >= 0; count--) {
      String title = threadList['result'][count]['title'];
      String author = threadList['result'][count]['author'];
      String content = threadList['result'][count]['content'];
      int userId = threadList['result'][count]['userId'];
      int threadId = threadList['result'][count]['thread_id'];
      int likes = threadList['result'][count]['likes'];
      int dislikes = threadList['result'][count]['dislikes'];
      String createdAt = threadList['result'][count]['createdAt'];
      bool userLiked = threadList['result'][count]['userLiked'];
      bool userDisliked = threadList['result'][count]['userDisliked'];
      int totalComments = threadList['result'][count]['totalComments'];

      displayItemList.add(gapBox);
      displayItemList.add(GestureDetector(
        onTap: () async {
          commentService().showAllCommentsInThread(
            context: context, 
            title: title,
            author: author,
            userId: userId,
            content: content,
            threadId: threadId,
            likes: likes,
            dislikes: dislikes,
            createdAt: createdAt,
            userLiked: userLiked,
            userDisliked: userDisliked
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
                    const Spacer(),
                    Icon(
                      likes - dislikes >= 0 
                        ? Icons.thumb_up_alt_outlined 
                        : Icons.thumb_down_alt_outlined,
                      color: likes - dislikes >= 0 
                        ? Colors.green 
                        : Colors.red,
                    ),
                    SizedBox(width: 2.0.w),
                    Text(
                      likes >= dislikes ? '$likes' : '-$dislikes', 
                      style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.bold)
                    ),
                    SizedBox(width: 4.0.w),
                    const Icon( Icons.chat_bubble_outline),
                    SizedBox(width: 2.0.w),
                    Text(
                      '$totalComments', 
                      style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.bold)
                    )
                  ],
                )
              ],
            )
          ),
        )
      ));
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final scrollBarController = ScrollController(initialScrollOffset: 0.0);
    String username = context.watch<UserProvider>().user.name;
    return Scaffold(
      appBar: ReusableWidgets.persistentAppBar('Welcome back! $username'),
      body: isLoading
      ? const Center(child: CupertinoActivityIndicator())
      : Scrollbar(
        thumbVisibility: true,
        controller: scrollBarController,
        child: ListView(
          shrinkWrap: true,
          controller: scrollBarController,
          padding: EdgeInsets.only(left: 7.0.w, right: 7.0.w),
          children: displayItemList
        ),
      )
    );
  }
}
