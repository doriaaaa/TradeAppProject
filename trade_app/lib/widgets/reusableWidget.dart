import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ReusableWidgets {
  static persistentAppBar(String title) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle( color: Colors.white, fontSize: 18.0.sp ),
        textAlign: TextAlign.center,
      ),
      flexibleSpace: const Image(
        image: AssetImage('assets/book_title.jpg'),
        fit: BoxFit.cover,
      ),
      backgroundColor: Colors.transparent,
    );
  }
}
