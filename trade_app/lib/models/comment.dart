import 'dart:convert';

// {
//   "body": "this is a testing comment",
//   "username": "super@dmin",
//   "date": "2023-03-18T17:33:31.028Z"
//   "comment_id": 1
// }

class Comment {
  final String body;
  final String username;
  final String date;
  final int userId;
  final int comment_id;
  final int thread_id;

  Comment({
    required this.body,
    required this.username,
    required this.date,
    required this.userId,
    required this.thread_id,
    required this.comment_id,
  });

  Map<String, dynamic> toMap() {
    return {
      'body': body,
      'username': username,
      'userId':userId,
      'date': date,
      'thread_id': thread_id,
      'comment_id': comment_id
    };
  }

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      body: map['body'] ?? '',
      username: map['username'] ?? '',
      userId: map['userId'] ?? 0,
      date: map['date'] ?? '',
      thread_id: map['thread_id'] ?? 0,
      comment_id: map['comment_id'] ?? 0
    );
  }

  String toJson() => json.encode(toMap());

  factory Comment.fromJson(String source) => Comment.fromMap(json.decode(source));

  Comment copyWith({
    String? body, 
    String? username, 
    String? date, 
    int? userId,
    int? comment_id,
    int? thread_id
  }) {
    return Comment(
      body: body ?? this.body,
      username: username ?? this.username,
      userId: userId ?? this.userId,
      date: date ?? this.date,
      thread_id: thread_id ?? this.thread_id,
      comment_id: comment_id ?? this.comment_id
    );
  }
}
