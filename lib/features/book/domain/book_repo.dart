import 'package:bookworm/features/book/data/firebase_books_repo.dart';
import 'package:bookworm/features/books/domain/entities/book.dart';

abstract class BookRepo {
  // update book status
  Future<void> updateBookStatus(String userId, Book book);

  // get user data on book
  Future<Book?> getUserBook(String userId, String bookId);

  // delete book for user's list

  Future<void> deleteUserBook(String userId, String bookId);
}

class BookRepoImpl implements BookRepo {
  final FirebaseBookRepo firebaseBookRepo;

  BookRepoImpl({required this.firebaseBookRepo});

  @override
  Future<Book?> getUserBook(String userId, String bookId) async {
    try {
      final book = await firebaseBookRepo.getBookFromFirebase(userId, bookId);
      return book;
    } catch (e) {
      throw Exception('failed to fetch book from firestore: $e');
    }
  }

  @override
  Future<void> updateBookStatus(String userId, Book book) async {
    try {
      await firebaseBookRepo.updateBookStatus(userId, book);
    } catch (e) {
      throw Exception('failed to update book status in firestore: $e');
    }
  }

  @override
  Future<void> deleteUserBook(String userId, String bookId) async {
    try {
      await firebaseBookRepo.deleteBookFromdb(userId, bookId);
    } catch (e) {
      throw Exception('error deleting book: $e');
    }
  }
}
