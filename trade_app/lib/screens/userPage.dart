// load other user data when user clicks in icon / name tag
// username, profilePicture, bookList, threads? 
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:trade_app/widgets/reusableWidget.dart';

class userPage extends StatefulWidget {
  final String username;
  final String profilePicture;
  final List bookList;
  // need userId and call api
  const userPage({
    Key? key,
    required this.username,
    required this.profilePicture,
    required this.bookList
  }) : super(key: key);

  @override
  State<userPage> createState() => _userPageState();
}

class _userPageState extends State<userPage> {
  // bool isLoading = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final scrollBarController = ScrollController(initialScrollOffset: 0.0);
    return Scaffold(
      appBar: ReusableWidgets.persistentAppBar(widget.username),
      // body: isLoading
      // ? const Center(child: CupertinoActivityIndicator())
      // : 
      body: Scrollbar(
        thumbVisibility: true,
        controller: scrollBarController,
        child: SingleChildScrollView(
          controller: scrollBarController,
          padding: EdgeInsets.only(left: 7.0.w, right: 7.0.w),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(height: 4.h),
                CircularProfileAvatar(
                  widget.profilePicture,
                  cacheImage: true,
                  imageFit: BoxFit.scaleDown,
                  radius: 100,
                  borderWidth: 5
                ),
                SizedBox(height: 4.h),
                Container(
                  
                )
              ],
            )
          )
        )
      )
    );
  }
}