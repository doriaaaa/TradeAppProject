import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sizer/sizer.dart';
import 'package:trade_app/widgets/reusableWidget.dart';

class searchResult extends StatefulWidget {
  // take title, author, description, category, rating
  final String title;
  final String author;
  final String description; 
  final String category;
  final String averageRating;
  final String imageUrl;

  const searchResult({
    Key? key,
    required this.title,
    required this.author,
    required this.description,
    required this.category,
    required this.averageRating,
    required this.imageUrl
  }) : super(key: key);

  @override 
  State<searchResult> createState() => _searchResultState();
}

class _searchResultState extends State<searchResult> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    final displayImageBox = Container(
      margin: EdgeInsets.only(left: 12.0.w, right: 12.0.w),
      width: 50.w,
      height: 60.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: const Color.fromARGB(100, 217, 217, 217)
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          image: DecorationImage(
            image: NetworkImage(widget.imageUrl), 
            fit: BoxFit.scaleDown
          )
        )
      )
    );

    final displayBookTitleText = Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Text(
            widget.title,
            textAlign: TextAlign.start,
            style: TextStyle( fontSize: 14.sp, fontWeight: FontWeight.bold)
          )
        )
      ]
    );

    final displayBookAuthorText = Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child:Text(
            "By ${widget.author}",
            textAlign: TextAlign.start,
            style: TextStyle( fontSize: 8.sp)
          )
        )
      ]
    );

    final ratingDisplayBox = Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: RatingBarIndicator(
            rating: double.parse(widget.averageRating),
            itemBuilder: (context, index) => 
            const Icon( Icons.star,  color: Colors.amber),
            itemCount: 5,
            itemSize: 20.0,
            direction: Axis.horizontal,
          ),
        )
      ]
    );

    final categoryTag = Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(1.5.w),
          decoration: BoxDecoration(
            border: themeData.brightness == Brightness.dark
              ? Border.all(color: const Color(0xE6ED764D))
              : Border.all(color: const Color(0xFF5E2750)),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Text(
            widget.category, 
            style: TextStyle( 
              fontSize: 10.sp,
              color: themeData.brightness == Brightness.dark
              ? const Color(0xE6ED764D)
              : const Color(0xFF5E2750)
            )
          )
        ),
      ]
    );

    final descriptionBox = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text( 
          widget.description, 
          textAlign: TextAlign.justify,
          style: TextStyle(fontSize: 12.0.sp, height: 1.5),
        )
      ],
    );

    return Scaffold(
      appBar: ReusableWidgets.persistentAppBar("Search Result"),
      body: Stack(
        children: [
          ListView(
            padding: EdgeInsets.only(left: 7.0.w, right: 7.0.w, top: 2.h),
            children: <Widget>[
              displayImageBox,
              SizedBox(height: 1.h),
              displayBookTitleText,
              SizedBox(height: 0.5.h),
              displayBookAuthorText,
              SizedBox(height: 1.h),
              ratingDisplayBox,
              SizedBox(height: 1.h),
              categoryTag,
              SizedBox(height: 1.h),
              descriptionBox,
              SizedBox(height: 1.h),
            ],
          ),
          Positioned.fill(
            child: Visibility(
              visible: _isLoading,
              replacement: Container(),
              child: Container(
                color: Colors.black.withOpacity(0.5),
                child: const Center(
                  child: CupertinoActivityIndicator(),
                ),
              ),
            ),
          )
        ]
      )
    );
  }
}