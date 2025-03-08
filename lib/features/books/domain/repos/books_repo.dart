import 'package:bookworm/features/books/domain/entities/book.dart';

abstract class BooksRepo {
  // get books details by title
  Future<List<Book>> getBooksDetails(String title);
}
