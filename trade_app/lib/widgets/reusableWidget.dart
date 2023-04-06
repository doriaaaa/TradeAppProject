import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ReusableWidgets {
  static persistentAppBar(String title) {
    return AppBar(
      backgroundColor: Colors.transparent,
      title: Text(
        title,
        style: TextStyle( color: Colors.white, fontSize: 15.0.sp ),
      ),
      flexibleSpace: const Opacity(
        opacity: 0.8,
        child: Image(
          image: AssetImage('assets/book_title.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      centerTitle: true,
    );
  }
}
