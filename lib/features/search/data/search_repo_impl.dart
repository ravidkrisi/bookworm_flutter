import 'package:bookworm/features/books/domain/entities/book.dart';
import 'package:bookworm/features/datasources/books_remote_data_source.dart';
import 'package:bookworm/features/search/domain/search_repo.dart';

class SearchRepoImpl implements SearchRepo {
  final BooksRemoteDataSource db;

  SearchRepoImpl({required this.db});

  @override
  Future<List<Book>> searchBookByTitle(String title) async {
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
