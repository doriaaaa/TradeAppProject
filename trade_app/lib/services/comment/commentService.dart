import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:trade_app/models/comment.dart';
import 'package:trade_app/screens/discussionPage.dart';
import '../../constants/error_handling.dart';
import '../../provider/comment_provider.dart';
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
      // update ui
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void displayAllCommentsInThread({
    required BuildContext context,
    required String title,
    required String author,
    required String content,
    required int threadId,
    required int likes,
    required int views,
    required String createdAt
  }) async {
    try {
      http.Response res = await http.get(Uri.parse('http://${dotenv.env['IP_ADDRESS']}:3000/api/upload/showAllComments/thread/$threadId'));
      // print('res: ${res.body}');
      Map commentList = jsonDecode(res.body);
      // print('comments_1: ${commentList['result'][0]}');
      // print('comments_2: ${commentList['result'][1]}');
      final commentProvider = CommentProvider();
      if (context.mounted) {
        httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () async {
            if (context.mounted) {
              // print(commentList['result']);
              for (int i = 0; i < commentList['result'].length; i++) {
                Provider.of<CommentProvider>(context, listen: false).setComment( jsonEncode({
                  "body": commentList['result'][i]["body"],
                  "username": commentList['result'][i]["username"],
                  "date": commentList['result'][i]["date"]
                }));
              }
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => discussionPage(
                  title: title,
                  author: author,
                  content: content,
                  threadId: threadId,
                  likes: likes,
                  views: views,
                  createdAt: createdAt
                )
              ));
            }
          },
        );
      }
    } catch (e) {
      debugPrint(e.toString());
      throw Exception("Failed to load user data");
    }
  }
}