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
