import 'package:bookworm/features/books/domain/entities/book.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class FirebaseBookRepo {
  // add book to user's books collection
  Future<void> addBookToFirestore(String userId, Book book);

  // update book status
  Future<void> updateBookStatus(String userId, Book book);

  // get book from firebase if exist
  Future<Book?> getBookFromFirebase(String userId, String bookId);
}

class FirebaseBookRepoImpl implements FirebaseBookRepo {
  final firestore = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> _getBooksCollection(String userId) {
    final booksCollection = firestore
        .collection('users')
        .doc(userId)
        .collection('books');
    return booksCollection;
  }

  Future<DocumentReference<Map<String, dynamic>>> _getBookDocRef(
    String userId,
    String bookId,
  ) async {
    // get books collection
    final booksCollection = _getBooksCollection(userId);

    // get book doc
    final docRef = await booksCollection.doc(bookId);

    return docRef;
  }

  @override
  Future<void> addBookToFirestore(String userId, Book book) async {
    try {
      // get books collection
      final booksCollection = _getBooksCollection(userId);

      // add book to collection
      await booksCollection.doc(book.id).set(book.toJson());
    } catch (e) {
      throw Exception('failed to add book to firestore: $e');
    }
  }

  @override
  Future<void> updateBookStatus(String userId, Book book) async {
    try {
      // get book doc
      final docRef = await _getBookDocRef(userId, book.id);
      final doc = await docRef.get();

      // doc exists -> update book status
      if (doc.exists) {
        await docRef.update({'status': book.status.name});
      }
      // doc not exist -> add book to firestore
      else {
        await addBookToFirestore(userId, book);
      }
    } catch (e) {
      throw Exception('failed to update book status: $e');
    }
  }

  @override
  Future<Book?> getBookFromFirebase(String userId, String bookId) async {
    try {
      final docRef = await _getBookDocRef(userId, bookId);
      final doc = await docRef.get();

      if (!doc.exists) {
        print('Document does not exist for userId: $userId, bookId: $bookId');
        return null;
      }

      final data = doc.data();
      if (data == null) {
        print('Document data is null!');
        return null;
      }

      print('Fetched data: $data');

      final book = Book.fromJson(data);
      return book;
    } catch (e, stackTrace) {
      print('Error fetching book: $e');
      print(stackTrace);

      // Prevent app crash
      return null;
    }
  }
}
