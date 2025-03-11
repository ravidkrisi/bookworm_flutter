import 'package:bookworm/features/books/data/repos/datasources/books_remote_data_source.dart';
import 'package:bookworm/features/books/domain/entities/book.dart';
import 'package:bookworm/features/books/domain/repos/books_repo.dart';

class BooksRepoImpl implements BooksRepo {
  final BooksRemoteDataSource db;

  BooksRepoImpl({required this.db});

  @override
  Future<List<Book>> getBooksDetails(String title) async {
    try {
      final booksModel = await db.getBooksDetails(title);
      final books =
          booksModel.map((bookModel) => bookModel.toEntity()).toList();
      return books;
    } catch (e) {
      throw Exception('failed to get books: ${e.toString()}');
    }
  }
}
