import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../constants/error_handling.dart';
import '../../constants/utils.dart';
import '../../provider/user_provider.dart';

class commentService {
  void createNewComment({
    required BuildContext context,
    required String body,
    required Int threadId
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(Uri.parse('http://${dotenv.env['IP_ADDRESS']}:3000/api/upload/createComment'),
        body: jsonEncode({
          'body': body,
          'thread_id': threadId,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token
        }
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<String> displayAllCommentsInThread({
    required BuildContext context,
    required Int threadId
  }) async {
    try {
      http.Response res = await http.get(Uri.parse('http://${dotenv.env['IP_ADDRESS']}:3000/api/upload/showAllComments/thread/$threadId'),);
      return res.body;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception("Failed to load user data");
    }
  }
}