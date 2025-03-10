// ignore_for_file: public_member_api_docs, sort_constructors_first
class Book {
  final String title;
  final String author;
  final String coverUrl;
  final int firstPublishYear;

  Book({
    required this.title,
    required this.author,
    required this.coverUrl,
    required this.firstPublishYear,
  });

  // JSON
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'author': author,
      'cover_url': coverUrl,
      'first_publish_uear': firstPublishYear,
    };
  }

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      title: json['title'] ?? '',
      author: json['author'] ?? '',
      coverUrl: json['cover_url'] ?? '',
      firstPublishYear: json['first_publis_year'] ?? 0,
    );
  }
}
