import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';
import 'package:trade_app/provider/user_provider.dart';
import '../constants/error_handling.dart';
import '../screens/uploadPage.dart';

class uploadService {
  void uploadPost({
    required BuildContext context,
    required File? image, // this is a base64 image string
    required String bookInfo, // this is a json response, use Map extractedDetails = json.decode(widget.bookInfoDetails); // map json response
    required String description, // this is the book description, can be ""
  }) async {
    // final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(Uri.parse('http://${dotenv.env['IP_ADDRESS']}:3000/api/uploadImage'),
        body: jsonEncode({ "image": image }),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        }
      );
      // debugPrint(res.body); 
      // ignore: use_build_context_synchronously
      uploadDB(context, jsonDecode(res.body)['result'], bookInfo, description);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void uploadDB(BuildContext context, String imageURL, String bookInfo, String description) async {
    // store to db by calling backend server
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(Uri.parse('http://${dotenv.env['IP_ADDRESS']}:3000/api/user/upload'),
        body: jsonEncode({
          "bookInfo": bookInfo,
          "image": imageURL,
          "description": description
        }),
        headers: { 
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token
        }
      );
      // debugPrint(res.body);
      // ignore: use_build_context_synchronously
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          debugPrint('Post is uploaded to database successfully');
          Navigator.pushNamedAndRemoveUntil( context, "/navBar", (route) => false); //return to home page
        },
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<String> getBookData( BuildContext context, Barcode barcode, MobileScannerArguments? args) async {
    bool _screenOpened = false;
    // final userProvider = Provider.of<UserProvider>(context, listen: false);
    void _screenWasClosed() { _screenOpened = false; }

    if (!_screenOpened) {
      final String code = barcode.rawValue ?? "---";
      try {
        if (code != "---") {
          debugPrint('Barcode found: $code');
          _screenOpened = true;
          http.Response res = await http.post(Uri.parse('http://${dotenv.env['IP_ADDRESS']}:3000/api/bookinfo'),
            body: jsonEncode({
              "book_isbn": code
            }),
            headers: { 
              'Content-Type': 'application/json; charset=UTF-8',
              // 'x-auth-token': userProvider.user.token
            }
          );
          debugPrint(res.body);
          // ignore: use_build_context_synchronously
          httpErrorHandle(
            response: res,
            context: context,
            onSuccess: () {
              debugPrint("isbn code: $code");
              Navigator.push( context, MaterialPageRoute( builder: (context) => uploadPage(screenClosed: _screenWasClosed, bookInfoDetails: res.body)));
            },
          );
        }
      } catch (e) {
        debugPrint(e.toString());
      }
    }
    return "Success!";
  }
}