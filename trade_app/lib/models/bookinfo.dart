import 'dart:convert';

class BookInfo {
  final String title;
  final String author;
  final String publishedDate;

  BookInfo({
    required this.title, 
    required this.author,
    required this.publishedDate
  });

  factory BookInfo.fromJson(Map<String, dynamic> json) {
    final title = json['title'] as String;
    final author = json['author'] as String;
    final publishedDate = json['publishedDate'] as String;
    // return data with book title and publish date only
    return BookInfo(
      title: title, 
      author: author, 
      publishedDate: publishedDate
    );
  }
}