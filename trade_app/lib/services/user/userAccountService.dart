import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trade_app/constants/utils.dart';
import 'package:provider/provider.dart';
import 'package:trade_app/provider/user_provider.dart';
import '../../constants/error_handling.dart';
import '../../models/user.dart';

class userAccountService {
  void signIn({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(Uri.parse('http://${dotenv.env['IP_ADDRESS']}:3000/api/user/account/signIn'),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        }
      );
      // debugPrint(res.body);
      // debugPrint("ipaddress: ${dotenv.env['IP_ADDRESS']}");
      if (context.mounted) {
        httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () async {
            showSnackBar(context, 'You have logged in successfully.');
            //store token in app memory
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);
            if (context.mounted) {
              Provider.of<UserProvider>(context, listen: false).setUser(res.body);
              Navigator.pushNamedAndRemoveUntil(context, "/navBar", (route) => false);
            }
          },
        );
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void signUp({
    required BuildContext context,
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post( Uri.parse('http://${dotenv.env['IP_ADDRESS']}:3000/api/account/signUp'),
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        }
      );
      if (context.mounted) {
        httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () async {
            showSnackBar(context, "Your account has been created successfully. Please login.");
            Navigator.pushNamed(context, "/login");
          },
        );
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void changePassword(
      {required BuildContext context,
      required String oldPassword,
      required String newPassword}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
          Uri.parse(
              'http://${dotenv.env['IP_ADDRESS']}:3000/api/user/account/changePassword'),
          body: jsonEncode({
            'oldPassword': oldPassword,
            'newPassword': newPassword,
          }),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token
          });
      if (context.mounted) {
        httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () async {
            showSnackBar(context, 'Your password has updated. Please login again');
            logout(context);
          },
        );
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void updateProfilePicture({
    required BuildContext context,
    required File? image,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    // upload the image, fetch the link, update user profile
    try {
      List<int> imageBytes = image!.readAsBytesSync();
      String base64Image = base64Encode(imageBytes);
      http.Response res = await http.post( Uri.parse('http://${dotenv.env['IP_ADDRESS']}:3000/api/universal/image'),
        body: jsonEncode({"image": base64Image}),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        }
      );
      var imageUrl = jsonDecode(res.body)['result'];
      if (imageUrl!) imageUrl = "";
      http.Response result = await http.post( Uri.parse('http://${dotenv.env['IP_ADDRESS']}:3000/api/user/account/updateProfilePicture'),
        body: jsonEncode({"profilePicture": imageUrl}),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token
        }
      );
      if (context.mounted) {
        httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            User user = userProvider.user.copyWith(profilePicture: jsonDecode(result.body)['result']);
            userProvider.setUserFromModel(user);
          },
        );
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void logout(BuildContext context) async {
    try {
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      await sharedPreferences.setString('x-auth-token', ''); // reset the auth token
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
