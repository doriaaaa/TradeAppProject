// load other user data when user clicks in icon / name tag
// username, profilePicture, bookList, threads? 
import 'package:cached_network_image/cached_network_image.dart';
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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final scrollBarController = ScrollController(initialScrollOffset: 0.0);
    return Scaffold(
      appBar: ReusableWidgets.persistentAppBar(widget.username),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 2.h),
            CircularProfileAvatar(
              widget.profilePicture,
              cacheImage: true,
              imageFit: BoxFit.scaleDown,
              radius: 90,
              borderWidth: 5,
              elevation: 5.0,
              borderColor: Theme.of(context).brightness == Brightness.dark
              ? const Color(0xFF5E2750)
              : const Color(0xE6ED764D),
            ),
            SizedBox(height: 2.h),
            const Center( 
              child: Text(
                "My Bookshelf",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)
              )
            ),
            SizedBox(height: 1.h),
            Divider(
              thickness: 2,
              indent: 10.w,
              endIndent: 10.w,
            ),
            Expanded(
              child: Scrollbar(
                thumbVisibility: false,
                controller: scrollBarController,
                child: widget.bookList.isEmpty
                ? Center(child: Text("${widget.username} has not upload any book yet."))
                : ListView.separated(
                  separatorBuilder: (BuildContext context, int index) { 
                    return const Divider(thickness: 1.0); 
                  },
                  controller: scrollBarController,
                  shrinkWrap: true,
                  padding: EdgeInsets.only(left: 7.0.w, right: 7.0.w),
                  itemCount: widget.bookList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {},
                      leading: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: 50.h,
                          maxWidth: 10.w
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: CachedNetworkImage(imageUrl: widget.bookList[index]['image'])
                        )
                      ),
                      title: Padding(
                        padding: EdgeInsets.only(bottom: 1.h),
                        child: Text(
                          widget.bookList[index]['bookInfo']['title'],
                          style: TextStyle(fontSize: 12.0.sp),
                        ),
                      ),
                    );
                  },
                )
              )
            ),
            SizedBox(height: 1.h),
          ],
        )
      )
    );
  }
}