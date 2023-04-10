class Book {
  final String title;
  final String author; // take the first one
  final String description;
  final String category; // take the first one
  final String averageRating; // no rating then default to 0, do typecasting
  final String imageUrl; //['imageLinks']['thumbnail']

  Book({
    required this.title,
    required this.author,
    required this.description,
    required this.category,
    required this.averageRating,
    required this.imageUrl
  });

  factory Book.fromJson(Map<String, dynamic> json) => Book(
    title: json['title'], 
    author: json['author'], 
    description: json['description'], 
    category: json['category'], 
    averageRating: json['averageRating'], 
    imageUrl: json['imageUrl']
  );

  Map<String, dynamic> toJson() => {
    'title': title,
    'author': author,
    'description': description,
    'category': category,
    'averageRating': averageRating,
    'imageUrl': imageUrl
  };
}