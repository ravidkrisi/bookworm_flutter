// ignore_for_file: public_member_api_docs, sort_constructors_first
enum BookStatus {
  unknown,
  wantToRead,
  reading,
  read;

  static BookStatus fromString(String? status) {
    return BookStatus.values.firstWhere(
      (value) => value.name == status,
      orElse: () => BookStatus.unknown,
    );
  }
}

class Book {
  final String title;
  final String author;
  final String coverUrl;
  final int firstPublishYear;
  final BookStatus status;

  Book({
    required this.title,
    required this.author,
    required this.coverUrl,
    required this.firstPublishYear,
    this.status = BookStatus.unknown,
  });

  // JSON
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'author': author,
      'cover_url': coverUrl,
      'first_publish_uear': firstPublishYear,
      'book_status': status.name,
    };
  }

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      title: json['title'] ?? '',
      author: json['author'] ?? '',
      coverUrl: json['cover_url'] ?? '',
      firstPublishYear: json['first_publis_year'] ?? 0,
      status: BookStatus.fromString(json['staus']),
    );
  }
}
