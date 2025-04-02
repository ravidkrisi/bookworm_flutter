// ignore_for_file: public_member_api_docs, sort_constructors_first
enum BookStatus {
  wantToRead,
  reading,
  read;

  // Custom string representation
  String get displayName {
    switch (this) {
      case BookStatus.wantToRead:
        return 'want to read';
      case BookStatus.reading:
        return 'reading';
      case BookStatus.read:
        return 'read';
    }
  }

  static BookStatus fromString(String? status) {
    return BookStatus.values.firstWhere((value) => value.name == status);
  }
}

class Book {
  final String id;
  final String title;
  final String author;
  final String coverUrl;
  final int firstPublishYear;
  final BookStatus? status;
  final String? reviewId;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.coverUrl,
    required this.firstPublishYear,
    this.status,
    this.reviewId,
  });

  // JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'cover_url': coverUrl,
      'first_publish_year': firstPublishYear,
      'status': status?.name,
      'review_id': reviewId,
    };
  }

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      author: json['author'] ?? '',
      coverUrl: json['cover_url'] ?? '',
      firstPublishYear: json['first_publish_year'] ?? 0,
      status:
          json['status'] != null ? BookStatus.fromString(json['status']) : null,
      reviewId: json['review_id'],
    );
  }

  Book copyWith({
    String? id,
    String? title,
    String? author,
    String? coverUrl,
    int? firstPublishYear,
    BookStatus? status,
    String? reviewId,
  }) {
    return Book(
      id: id ?? this.id,
      title: title ?? this.title,
      author: author ?? this.author,
      coverUrl: coverUrl ?? this.coverUrl,
      firstPublishYear: firstPublishYear ?? this.firstPublishYear,
      status: status ?? this.status,
      reviewId: reviewId ?? this.reviewId,
    );
  }
}
