import 'package:flutter/material.dart';

class ReusableWidgets { 
  static accountPageAppBar(String title) {
    return AppBar(
      toolbarHeight: 70,
      backgroundColor: Colors.green,
      title: Text(title),
    );
  }

  static LoginPageAppBar(String title) {
    return AppBar(
      centerTitle: true,
      title: Text(title),
    );
  }
}