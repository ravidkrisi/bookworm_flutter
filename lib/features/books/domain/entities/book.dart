// ignore_for_file: public_member_api_docs, sort_constructors_first
class Book {
  final String title;
  final String author;
  final String coverUrl;

  Book({required this.title, required this.author, required this.coverUrl});

  // JSON
  Map<String, dynamic> toJson() {
    return {'title': title, 'author': author, 'cover_url': coverUrl};
  }

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      title: json['title'] ?? '',
      author: json['author'] ?? '',
      coverUrl: json['cover_url'] ?? '',
    );
  }
}
