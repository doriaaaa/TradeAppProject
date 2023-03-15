import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/error_handling.dart';
import 'package:provider/provider.dart';
import 'package:trade_app/provider/user_provider.dart';

class AuthService {
  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(Uri.parse('http://${dotenv.env['IP_ADDRESS']}:3000/api/signin'),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'}
      );
      // debugPrint(res.body);
      debugPrint("ipaddress: ${dotenv.env['IP_ADDRESS']}");
      // ignore: use_build_context_synchronously
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          //store token in app memory
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);
          // ignore: use_build_context_synchronously
          Provider.of<UserProvider>(context, listen: false).setUser(res.body);
          // ignore: use_build_context_synchronously
          Navigator.pushNamedAndRemoveUntil( context, "/navBar", (route) => false); //return res.body['name']
        },
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void signUpUser({
    required BuildContext context,
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(Uri.parse('http://${dotenv.env['IP_ADDRESS']}:3000/api/signup'),
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
        }),
        headers: <String, String>{ 'Content-Type': 'application/json; charset=UTF-8'}
      );
      // ignore: use_build_context_synchronously
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          //store token in app memory
          SharedPreferences prefs = await SharedPreferences.getInstance();
          //await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);
          // ignore: use_build_context_synchronously
          Navigator.pushNamed( context, "/login");
        },
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void changeUserPassword({
    required BuildContext context,
    required String oldPassword,
    required String newPassword
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(Uri.parse('http://${dotenv.env['IP_ADDRESS']}:3000/api/user/changePassword'),
        body: jsonEncode({
          'oldPassword': oldPassword,
          'newPassword': newPassword,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token
        }
      );
      // ignore: use_build_context_synchronously
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
        },
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
