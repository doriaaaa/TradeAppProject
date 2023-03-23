import 'package:trade_app/models/comment.dart';
import 'package:flutter/material.dart';

// {
//   "body": "this is a testing comment",
//   "username": "super@dmin",
//   "date": "2023-03-18T17:33:31.028Z"
// }
class CommentProvider extends ChangeNotifier {
  final List<Comment> _comments = [];

  List<Comment> get comments => _comments;

  void setComment(String comment) {
    // final parsedComment = Comment.fromJson(comment);
    _comments.add(Comment.fromJson(comment));
    notifyListeners();
  }

  void setCommentFromModel(Comment comment) {
    _comments.add(comment);
    notifyListeners();
  }

  void updateCommentFromModel(Comment comment, int position) {
    _comments[position] = comment;
    notifyListeners();
  }

  void clearComments() {
    _comments.clear();
    notifyListeners();
  }
}
