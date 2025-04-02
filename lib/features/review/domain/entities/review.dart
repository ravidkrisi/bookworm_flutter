import 'package:cloud_firestore/cloud_firestore.dart';

class Review {
  final String id;
  final String bookId;
  final String userId;
  final String userName;
  final int rating;
  final String reviewText;
  final DateTime createdAt;
  Review({
    required this.id,
    required this.bookId,
    required this.userId,
    required this.userName,
    required this.rating,
    required this.reviewText,
    required this.createdAt,
  });

  // Map<String, dynamic> toJson() {
  //   return <String, dynamic>{
  //     'id': id,
  //     'bookId': bookId,
  //     'userId': userId,
  //     'rating': rating,
  //     'reviewText': reviewText,
  //     'createdAt': Timestamp.fromDate(createdAt),
  //   };
  // }

  // factory Review.fromJson(Map<String, dynamic> map) {
  //   return Review(
  //     id: map['id'] as String,
  //     bookId: map['bookId'] as String,
  //     userId: map['userId'] as String,
  //     rating: map['rating'] as int,
  //     reviewText: map['reviewText'] as String,
  //     createdAt: (map['createdAt'] as Timestamp).toDate(),
  //   );
  // }
}
