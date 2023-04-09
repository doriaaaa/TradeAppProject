import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../constants/error_handling.dart';
import '../../constants/utils.dart';
import '../../provider/user_provider.dart';

class threadService {
  void createThread({
    required BuildContext context,
    required String title,
    required String content
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse(
            'http://${dotenv.env['IP_ADDRESS']}:3000/api/thread/createThread'),
        body: jsonEncode({
          'title': title,
          'content': content,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token
        }
      );
      if (context.mounted) {
        httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () async {
            showSnackBar(context, "Thread created.");
            Navigator.pushNamedAndRemoveUntil( context, "/navBar", (route) => false);
          },
        );
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<String> showAllThreads({
    required BuildContext context,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.get(Uri.parse('http://${dotenv.env['IP_ADDRESS']}:3000/api/thread/showAllThreads'),
      headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token
        }
      );
      return res.body;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception("Failed to load user data");
    }
  }

  // thread liked by user
  void userLikedThread({
    required BuildContext context,
    required int threadId,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.put(Uri.parse('http://${dotenv.env['IP_ADDRESS']}:3000/api/thread/userLikedThread/$threadId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token
        }
      );
      if (context.mounted) {
        httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(context, "You liked this thread!");
          },
          onDuplicates: () {
            showSnackBar(context, "You liked this thread already.");
          }
        );
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  // thread disliked by user
  void userDislikedThread({
    required BuildContext context,
    required int threadId,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.put(Uri.parse('http://${dotenv.env['IP_ADDRESS']}:3000/api/thread/userDislikedThread/$threadId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token
        }
      );
      if (context.mounted) {
        httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(context, "You disliked this thread!");
          },
          onDuplicates: () {
            showSnackBar(context, "You disliked this thread already.");
          }
        );
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
