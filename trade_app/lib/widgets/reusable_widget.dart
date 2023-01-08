import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReusableWidgets {
  static accountPageAppBar(String title) {
    return AppBar(
      toolbarHeight: 70,
      backgroundColor: Colors.green,
      title: Text(title),
    );
  }

  static loginPageAppBar(String title) {
    return AppBar(
      title: Text(
        title,
        style: GoogleFonts.montserrat(
            textStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                height: 0.9,
                fontSize: 25)),
        textAlign: TextAlign.left,
      ),
      flexibleSpace: const Image(
        image: AssetImage('assets/book_title.jpg'),
        fit: BoxFit.cover,
      ),
      backgroundColor: Colors.transparent,
    );
  }
}
