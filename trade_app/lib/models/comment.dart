import 'dart:convert';

// {
//   "body": "this is a testing comment",
//   "username": "super@dmin",
//   "date": "2023-03-18T17:33:31.028Z"
// }

class Comment {
  final String body;
  final String username;
  final String date;

  Comment({
    required this.body,
    required this.username,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'body': body,
      'username': username,
      'date': date
    };
  }

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      body: map['body'] ?? '',
      username: map['username'] ?? '',
      date: map['date'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Comment.fromJson(String source) => Comment.fromMap(json.decode(source));

  Comment copyWith({
    String? body,
    String? username,
    String? date,
  }) {
    return Comment(
      body: body ?? this.body,
      username: username ?? this.username,
      date: date ?? this.date
    );
  }
}
