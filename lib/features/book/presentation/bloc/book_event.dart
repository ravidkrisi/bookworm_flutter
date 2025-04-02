// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bookworm/features/books/domain/entities/book.dart';

abstract class BookEvent {}

// get book staus
class GetUserBook extends BookEvent {
  final String userId;
  final String bookId;
  GetUserBook({required this.userId, required this.bookId});
}

// update book status
class UpdateBookStatus extends BookEvent {
  final String userId;
  final Book book;
  UpdateBookStatus({required this.userId, required this.book});
}

// update book review id
class UpdateBookReviewId extends BookEvent {
  final String userId;
  final String bookId;
  final String reviewId;
  UpdateBookReviewId({
    required this.userId,
    required this.bookId,
    required this.reviewId,
  });
}

// delete book
class DeleteUserBook extends BookEvent {
  final String userId;
  final String bookId;
  DeleteUserBook({required this.userId, required this.bookId});
}
