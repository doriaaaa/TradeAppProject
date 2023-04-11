import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ReusableWidgets {
  static persistentAppBar(
    String title, 
    { 
      List<Widget>? actions, 
      Widget? leading
    }
  ) {
    return AppBar(
      backgroundColor: Colors.transparent,
      title: Text(
        title,
        style: TextStyle(color: Colors.white, fontSize: 13.0.sp),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      flexibleSpace: const Opacity(
        opacity: 0.8,
        child: Image(
          image: AssetImage('assets/book_title.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      centerTitle: true,
      actions: actions,
      leading: leading,
    );
  }
}
