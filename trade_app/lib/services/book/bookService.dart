import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';
import 'package:trade_app/provider/user_provider.dart';
import '../../constants/error_handling.dart';
import '../../constants/utils.dart';
import '../../screens/uploadBookPage.dart';

class bookService {
  Future<void> universalImage({
    required BuildContext context,
    required File? image, 
    required String bookInfo, // this is a json response, use Map extractedDetails = json.decode(widget.bookInfoDetails); // map json response
  }) async {
    // final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      List<int> imageBytes = image!.readAsBytesSync();
      String base64Image = base64Encode(imageBytes);
      // print(base64Image);
      http.Response res = await http.post(Uri.parse('http://${dotenv.env['IP_ADDRESS']}:3000/api/universal/image'),
        body: jsonEncode({ 
          "image": base64Image
        }),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        }
      );
      // debugPrint(res.body); 
      debugPrint(res.body);
      if (context.mounted) bookUpload(context, jsonDecode(res.body)['result'], bookInfo);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void bookUpload(BuildContext context, String imageURL, String bookInfo) async {
    // store to db by calling backend server
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    Map bookDetails = jsonDecode(bookInfo);
    try {
      http.Response res = await http.post(Uri.parse('http://${dotenv.env['IP_ADDRESS']}:3000/api/book/upload'),
        body: jsonEncode({
          "bookInfo": bookDetails,
          "image": imageURL,
        }),
        headers: { 
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token
        }
      );
      // debugPrint(res.body);
      if (context.mounted) {
        httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(context, 'Post is uploaded to database successfully');
            Navigator.pushNamedAndRemoveUntil( context, "/navBar", (route) => false); //return to home page
          },
        );
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void bookInfo( 
    BuildContext context,
    Barcode barcode,
  ) async {
    final String code = barcode.rawValue ?? "---";
    try {
      if (code != "---") {
        debugPrint('Barcode found: $code');
        http.Response res = await http.post(Uri.parse('http://${dotenv.env['IP_ADDRESS']}:3000/api/book/info'),
          body: jsonEncode({
            "book_isbn": code
          }),
          headers: { 
            'Content-Type': 'application/json; charset=UTF-8',
          }
        );
        debugPrint(res.body);
        if (context.mounted) {
          httpErrorHandle(
            response: res,
            context: context,
            onSuccess: () {
              debugPrint("isbn code: $code");
              Navigator.push( context, MaterialPageRoute( builder: (context) => BookPage(bookInfo: res.body)));
            },
          );
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  // return a set of book search list, do not pass to backend
  // call by search
  Future<String> bookSearch({
    required BuildContext context,
    required String bookTitle
  }) async {
    try {
      http.Response res = await http.get(Uri.parse("https://www.googleapis.com/books/v1/volumes?q=\"$bookTitle\""));
      Map resbody = jsonDecode(res.body);
      if (context.mounted) {
        httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () async {
            
          },
        );
      }
    } catch (e) {
      debugPrint(e.toString());
    }
   return ''; 
  }
  // return trending list, do not pass to backend
  Future<String> trendingBookList() async {
    try {
      http.Response res = await http.get(Uri.parse("https://api.nytimes.com/svc/books/v3/lists/full-overview.json?api-key=${dotenv.env['NYTIMES_APIKEY']}"));
      return res.body;
    } catch (e) {
      debugPrint(e.toString());
    }
    return '';
  }
}