import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:trade_app/screens/discussionPage.dart';
import '../../constants/error_handling.dart';
import '../../models/comment.dart';
import '../../provider/comment_provider.dart';
import '../../provider/user_provider.dart';

class commentService {
  Future<bool> createComment({
    required BuildContext context,
    required String body,
    required int threadId,
    required int userId
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(Uri.parse('http://${dotenv.env['IP_ADDRESS']}:3000/api/comment/createComment'),
        body: jsonEncode({
          'body': body,
          'thread_id': threadId,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token
        }
      );
      // print('res: ${res.body}');
      // print(res.statusCode);
      Map comment = jsonDecode(res.body);
      // update ui
      if (context.mounted) {
        httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            var newComment = jsonEncode({
              "body": comment["result"]["body"],
              "username": userProvider.user.name,
              "userId": userProvider.user.userId,
              "date": comment["result"]["date"],
              "comment_id": comment["result"]["comment_id"]
            });
            Provider.of<CommentProvider>(context, listen: false).setComment(newComment);
            // print(commentProvider.comments);
          },
        );
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return true;
  }

  void showAllCommentsInThread({
    required BuildContext context,
    required String title,
    required String author,
    required int userId,
    required String content,
    required int threadId,
    required int likes,
    required int dislikes,
    required String createdAt,
    required bool userLiked,
    required bool userDisliked
  }) async {
    try {
      http.Response res = await http.get(Uri.parse('http://${dotenv.env['IP_ADDRESS']}:3000/api/comment/showAllComments/thread/$threadId'));
      // print('res: ${res.body}');
      Map commentList = jsonDecode(res.body);
      // print('comments_1: ${commentList['result'][0]}');
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
                  "userId":commentList['result'][i]["userId"],
                  "thread_id": commentList['result'][i]["thread_id"],
                  "date": commentList['result'][i]["date"],
                  "comment_id":commentList["result"][i]["comment_id"] 
                }));
              }
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => discussionPage(
                  title: title,
                  author: author,
                  content: content,
                  threadId: threadId,
                  userId: userId,
                  likes: likes,
                  dislikes: dislikes,
                  createdAt: createdAt,
                  userLiked: userLiked,
                  userDisliked: userDisliked,
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

  Future<bool> editComment({
    required BuildContext context,
    required int comment_id,
    required int thread_id,
    required String body,
  }) async {
    try {
      http.Response res = await http.put(Uri.parse('http://${dotenv.env['IP_ADDRESS']}:3000/api/comment/editComment/thread/$thread_id/commentId/$comment_id'),
        body: jsonEncode({
          'body': body,
          'thread_id': thread_id,
          'comment_id': comment_id,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        }
      );
      if (context.mounted) {
        httpErrorHandle(
          response: res,
          // res.body should return body, comment_id and thread_id
          context: context,
          onSuccess: () async {
            // print("respone: ${jsonDecode(res.body)["result"]["body"]}");
            Comment updatedComment = Provider.of<CommentProvider>(context, listen: false).comments[comment_id-1].copyWith(body: jsonDecode(res.body)["result"]["body"]);
            Provider.of<CommentProvider>(context, listen: false).updateCommentFromModel(updatedComment, comment_id-1);
            // print("updatedComment.body : $updatedComment.body");
          },
        );
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return true;
  }
}