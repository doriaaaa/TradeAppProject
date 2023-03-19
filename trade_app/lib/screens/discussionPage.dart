import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../widgets/reusableWidget.dart';

class discussionPage extends StatefulWidget {
  final String thread;

  const discussionPage({Key? key, required this.thread}) : super(key: key);

  @override
  State<discussionPage> createState() => _discussionPageState();
}

class _discussionPageState extends State<discussionPage> {
  @override
  Widget build(BuildContext context) {
    // debugPrint(widget.thread);
    Map fullThread = json.decode(widget.thread);
    String title = fullThread['title'];
    String timestamp = fullThread['createdAt'];

    final scollBarController = ScrollController(initialScrollOffset: 50.0);
    // thread content always display above
    final threadContentDisplayBox = Container(
      // height: 30.h,
      margin: EdgeInsets.fromLTRB(7.w, 2.h, 7.w, 2.h),
      // decoration: BoxDecoration(border: Border.all(color:const Color(0xFFFF9000))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 10.w,
                height: 10.h,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('assets/avatar.jpg'), //dummy image
                    fit: BoxFit.scaleDown
                  )
                ),
              ),
              SizedBox(width: 2.w),
              Text(fullThread['author'], style: TextStyle(fontSize: 12.sp),),
              const Spacer(),
              Text(timestamp.substring(0, timestamp.indexOf('T')))
            ]
          ),
          Text(fullThread['content']),
          SizedBox(height: 2.h),
          Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              const Spacer(),
              const Icon(Icons.thumb_up_alt_outlined),
              SizedBox(width: 4.w),
              const Icon(Icons.thumb_down_alt_outlined),
            ],
          ),
        ],
      )
    );

    //build commentlists
    
    final commentsDisplayList = Container(
      
    );

    return Scaffold(
      appBar: ReusableWidgets.persistentAppBar(title),
      body: Scrollbar(
        thumbVisibility: true,
        controller: scollBarController,
        child: ListView(
          shrinkWrap: true,
          controller: scollBarController,
          // padding: EdgeInsets.only(left: 7.0.w, right: 7.0.w),
          children: <Widget>[
            threadContentDisplayBox,
            Divider(
              color: Colors.grey.withOpacity(0.5),
              thickness: 1,
            ),
            SizedBox(height: 2.h),
          ]
          // display comments
        ),
      )
    );
  }
}
