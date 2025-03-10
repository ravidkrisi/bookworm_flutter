import 'package:bookworm/features/books/domain/entities/book.dart';

abstract class SearchRepo {
  // fetch books list by title
  Future<List<Book>> searchBookByTitle(String title);
}
