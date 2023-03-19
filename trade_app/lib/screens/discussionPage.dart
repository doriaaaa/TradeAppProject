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
    // debugPrint(widget.book);
    Map fullThread = json.decode(widget.thread);
    debugPrint(fullThread['content']);
    final scollBarController = ScrollController(initialScrollOffset: 50.0);

    return Scaffold(
      appBar: ReusableWidgets.persistentAppBar(fullThread['bookInfo']['title']),
      body: Scrollbar(
        thumbVisibility: true,
        controller: scollBarController,
        child: ListView(
          shrinkWrap: true,
          controller: scollBarController,
          padding: EdgeInsets.only(left: 7.0.w, right: 7.0.w),
          children: <Widget>[]
          // display comments
        ),
      )
    );
  }
}
