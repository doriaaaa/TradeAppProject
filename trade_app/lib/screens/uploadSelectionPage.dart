// when user clicks the middle button
// it will arrive to this page
// this page only consists of two buttons
// first one is uploading a book button
// second one is uploading a post
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
  Widget build(BuildContext context) {

    final uploadBookButton = ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xE6ED764D),
        elevation: 6.0,
        shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20.0)),
      ),
      onPressed: () {
        Navigator.pushNamed(context, '/camera');
      }, 
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon( Icons.library_books_outlined, size: 30.sp),
          SizedBox(height: 3.h),
          const Text("Upload a new book")
        ]
      )
    );

    final createThreadButton = ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xE6925375),
        elevation: 6.0,
        shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20.0)),
      ),
      onPressed: () {
        Navigator.pushNamed(context, '/createNewThread');
      }, 
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon( Icons.add_box_outlined, size: 30.sp),
          SizedBox(height: 3.h),
          const Text("Create a new thread")
        ]
      )
    );

    return Scaffold(
      appBar: ReusableWidgets.persistentAppBar('Choose upload options'),
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(left: 20.0.w, right: 20.0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(height: 10.0.h),
              Expanded(
                child: uploadBookButton,
              ),
              SizedBox(height: 10.0.h),
              Expanded(
                child: createThreadButton,
              ),
              SizedBox(height: 10.0.h),
            ],
          ),
        )
      )
    );
  }
}