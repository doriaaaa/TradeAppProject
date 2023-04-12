import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class recommendationModal extends StatelessWidget {
  final String title;
  final String author;
  final String bookCoverUrl;
  final String description;
  
  const recommendationModal({
    Key? key,
    required this.title,
    required this.author,
    required this.bookCoverUrl,
    required this.description
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final scrollBarController = ScrollController(initialScrollOffset: 0.0);

    return Material(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Scrollbar(
            thumbVisibility: true,
            controller: scrollBarController,
            child: ListView(
              shrinkWrap: true,
              controller: scrollBarController,
              children: <Widget>[
                SizedBox(height: 4.h),
                Container(
                  margin: EdgeInsets.only(left:12.w, right: 12.w),
                  width: 50.w,
                  height: 60.w,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(bookCoverUrl),
                        fit: BoxFit.scaleDown
                      )
                    ),
                  ),
                ),
                SizedBox(height:3.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        title,
                        textAlign: TextAlign.center,
                        style: TextStyle( fontSize: 14.sp, fontWeight: FontWeight.w500)
                      )
                    )
                  ]
                ),
                SizedBox(height:2.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child:Text(
                        "By $author",
                        textAlign: TextAlign.center,
                        style: TextStyle( fontSize: 12.sp, fontStyle: FontStyle.italic)
                      )
                    )
                  ]
                ),
                // SizedBox(height:2.h),
                Container(
                  margin: EdgeInsets.all(4.w),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text( 
                        description, 
                        textAlign: TextAlign.justify,
                        style: TextStyle(fontSize: 12.0.sp, height: 1.5),
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    OutlinedButton(
                      onPressed: () {}, 
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)
                        )
                      ),
                      child: Row(
                        children: const <Widget>[
                          Icon( Icons.favorite_border ),
                          Text("LIKE")
                        ]
                      )
                    ),
                    // share button --> redirect to new post 
                    OutlinedButton(
                      onPressed: () { Navigator.pushNamed(context, '/createNewThread', arguments: {'title': title}); }, 
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)
                        )
                      ),
                      child: Row(
                        children: const <Widget>[
                          Icon( Icons.share ),
                          Text("SHARE")
                        ]
                      )
                    ),
                  ]
                ),
              ],
            ),
          )
        )
      ),
    );
  }
}