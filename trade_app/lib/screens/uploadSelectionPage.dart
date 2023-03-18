// when user clicks the middle button
// it will arrive to this page
// this page only consists of two buttons
// first one is uploading a book button
// second one is uploading a post
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:trade_app/widgets/reusableWidget.dart';

class uploadSelectionPage extends StatefulWidget {
  const uploadSelectionPage({ Key? key}) : super(key: key);

  @override
  State<uploadSelectionPage> createState() => _uploadSelectionPageState();
}

class _uploadSelectionPageState extends State<uploadSelectionPage> {
  @override 
  Widget build(BuildContext) {

    final uploadBookButton = ElevatedButton(
      onPressed: () {}, 
      child: const Text("Upload a new book")
    );

    final createThreadButton = ElevatedButton(
      onPressed: () {}, 
      child: const Text("Create a new thread")
    );

    return Scaffold(
      appBar: ReusableWidgets.persistentAppBar('Upload'),
      body: ListView(
        padding: EdgeInsets.only(left: 7.0.w, right: 7.0.w),
        physics: const NeverScrollableScrollPhysics(),
        children: <Widget>[
          SizedBox(height: 2.h),
          uploadBookButton,
          SizedBox(height: 2.h),
          createThreadButton
        ],
      )
    );
  }
}