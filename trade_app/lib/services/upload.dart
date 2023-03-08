import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_scanner/mobile_scanner.dart';
import '../constants/error_handling.dart';
import '../screens/upload_imagePage.dart';

class uploadService {

  void uploadPost({
    required BuildContext context,
    required File? imageURL,
    required String title,
    required String author,
    required String publishedDate
  }) async {

  }

  Future<String> getBookData( BuildContext context, Barcode barcode, MobileScannerArguments? args) async {
    bool _screenOpened = false;

    void _screenWasClosed() {
      _screenOpened = false;
    }

    if (!_screenOpened) {
      final String code = barcode.rawValue ?? "---";
      try {
        if (code != "---") {
          debugPrint('Barcode found! $code');
          _screenOpened = true;
          http.Response res = 
            await http.post(Uri.parse('http://172.20.10.4:3000/api/bookinfo'),
              body: jsonEncode({
                "book_isbn": code
              }),
              headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            });
          debugPrint(res.body);
          // ignore: use_build_context_synchronously
          httpErrorHandle(
            response: res,
            context: context,
            onSuccess: () {
              debugPrint(code);
              Navigator.push( context, MaterialPageRoute( builder: (context) => uploadImagePage(screenClosed: _screenWasClosed, bookInfoDetails: res.body)));
            },
          );
        }
      } catch (e) {
        print(e.toString());
      }
    }
    return "Success!";
  }
}