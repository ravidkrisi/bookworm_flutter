import 'package:bookworm/features/books/domain/entities/book.dart';

abstract class BookState {}

// initial
class BookInitial extends BookState {}

// loading
class BookLoading extends BookState {}

// loaded
class BookLoaded extends BookState {
  final Book? book;
  BookLoaded({required this.book});
}

// errors
class BookError extends BookState {
  final String message;
  BookError({required this.message});
}
