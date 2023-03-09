import 'package:flutter/material.dart';

class ReusableWidgets {
  static persistentAppBar(String title) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle( color: Colors.white, fontSize: 25 ),
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
