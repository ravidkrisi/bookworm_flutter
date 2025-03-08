import 'package:bookworm/features/books/data/models/book_model.dart';
import 'package:bookworm/features/books/data/models/response.dart';
import 'package:dio/dio.dart';

abstract class BooksRemoteDataSource {
  Future<List<BookModel>> getBooksDetails(String title);
}

class BooksRemoteDataSourceImpl implements BooksRemoteDataSource {
  final Dio dio = Dio();

  @override
  Future<List<BookModel>> getBooksDetails(String title) async {
    try {
      // Get response from API
      final response = await dio.get(
        'https://openlibrary.org/search.json?title=$title',
      );

      if (response.statusCode == 200) {
        try {
          // Attempt to parse response
          final data = ResponseApi.fromJson(response.data);
          return data.books;
        } catch (e, stacktrace) {
          print('❌ Error decoding JSON: $e');
          print('🔍 Full response data: ${response.data}');
          print('🛠 Stacktrace: $stacktrace');
          rethrow; // Re-throw to let the app handle it
        }
      } else {
        throw Exception('Failed to get data from remote API');
      }
    } catch (e, stacktrace) {
      print('❌ General error fetching book details: $e');
      print('🛠 Stacktrace: $stacktrace');
      rethrow;
    }
  }
}
