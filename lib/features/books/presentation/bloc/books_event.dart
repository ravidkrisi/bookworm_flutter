abstract class BooksEvent {}

// fetch books by title
class FetchBooksByTitle extends BooksEvent {
  final String title;
  FetchBooksByTitle({required this.title});
}
