import 'dart:convert';

class User {
  final String id;
  final String name;
  final String email;
  final String password;
  final String profilePicture;
  final String type;
  final String token;
  final int userId;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.profilePicture,
    required this.type,
    required this.token,
    required this.userId
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'profilePicture': profilePicture,
      'type': type,
      'token': token,
      'userId': userId
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      profilePicture: map['profilePicture'],
      type: map['type'] ?? '',
      token: map['token'] ?? '',
      userId: map['userId'] ?? 0
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? password,
    String? profilePicture,
    String? type,
    String? token,
    int? userId
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      profilePicture: profilePicture ?? this.profilePicture,
      type: type ?? this.type,
      token: token ?? this.token,
      userId: userId ?? this.userId
    );
  }
}
