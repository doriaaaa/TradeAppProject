import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import '../services/upload.dart';
import '../widgets/reusableWidget.dart';

class discussionPage extends StatefulWidget {
  final String book;

  discussionPage({
    Key? key,
    required this.book
  }) : super(key: key);

  @override
  State<discussionPage> createState() => _discussionPageState();
}

class _discussionPageState extends State<discussionPage> {
  @override
  Widget build(BuildContext context) {
    final scollBarController = ScrollController(initialScrollOffset: 50.0);
    return Scaffold(
      appBar: ReusableWidgets.persistentAppBar(''),
      body: Scrollbar(
        thumbVisibility: true,
        controller: scollBarController,
        child: ListView(
          shrinkWrap: true,
          controller: scollBarController,
          padding: EdgeInsets.only(left: 7.0.w, right: 7.0.w),
          children: <Widget>[]
        ),
      )
    );
  } 
}