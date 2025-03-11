import 'package:bookworm/features/books/domain/entities/book.dart';

abstract class BooksState {}

// initial
class BooksInitial extends BooksState {}

// loading
class BooksLoading extends BooksState {}

// loaded
class BooksLoaded extends BooksState {
  final List<Book> books;
  BooksLoaded({required this.books});
}

// errors
class BooksError extends BooksState {
  final String message;
  BooksError({required this.message});
}
