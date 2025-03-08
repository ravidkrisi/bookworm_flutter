// ignore_for_file: public_member_api_docs, sort_constructors_first
abstract class BooksEvent {}

// fetch books by title
class FetchBooksByTitle extends BooksEvent {
  final String title;
  FetchBooksByTitle({required this.title});
}
