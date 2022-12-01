import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trade_app/widgets/nav_bar.dart';
import '../../constants/error_handling.dart';
import 'package:trade_app/screens/login_page.dart';

class AuthService {
  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res =
          await http.post(Uri.parse('http://localhost:3000/api/signin'),
              body: jsonEncode({
                'email': email,
                'password': password,
              }),
              headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          //store token in app memory
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);
          // ignore: use_build_context_synchronously
          Navigator.pushNamedAndRemoveUntil(
            context,
            NavBar.routeName,
            (route) => false,
          ); //return res.body['name']
        },
      );
    } catch (e) {
      print(e.toString());
    }
  }

  void signUpUser({
    required BuildContext context,
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res =
          await http.post(Uri.parse('http://localhost:3000/api/signup'),
              body: jsonEncode({
                'name': name,
                'email': email,
                'password': password,
              }),
              headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          //store token in app memory
          SharedPreferences prefs = await SharedPreferences.getInstance();
          //await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);
          // ignore: use_build_context_synchronously
          Navigator.pushNamedAndRemoveUntil(
            context,
            LoginPage.routeName,
            (route) => false,
          );
        },
      );
    } catch (e) {
      print(e.toString());
    }
  }
}
