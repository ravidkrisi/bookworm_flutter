// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bookworm/features/books/domain/entities/book.dart';

abstract class SearchState {}

// init
class SearchInit extends SearchState {}

// loading
class SearchLoading extends SearchState {}

// loaded
class SearchLoaded extends SearchState {
  final List<Book> books;
  SearchLoaded({required this.books});
}

// errors
class SearchErrors extends SearchState {
  final String message;
  SearchErrors({required this.message});
}
