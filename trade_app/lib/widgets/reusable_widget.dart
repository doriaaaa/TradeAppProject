import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReusableWidgets {
  static loginPageAppBar(String title) {
    return AppBar(
      title: Text(
        title,
        style: GoogleFonts.ubuntuMono(
          textStyle: const TextStyle(
            fontWeight: FontWeight.w300,
            color: Colors.white,
            height: 0.9,
            fontSize: 25)
          ),
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
