import 'package:bookworm/features/book/domain/book_repo.dart';
import 'package:bookworm/features/book/presentation/bloc/book_event.dart';
import 'package:bookworm/features/book/presentation/bloc/book_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  final BookRepo repo;

  BookBloc({required this.repo}) : super(BookInitial()) {
    // register events handlers
    on<GetUserBook>(_onGetUserBook);
    on<UpdateBookStatus>(_onUpdateBookStatus);
    on<DeleteUserBook>(_onDeleteUserBook);
    on<UpdateBookReviewId>(_onUpdateReviewId);
  }

  void _onGetUserBook(GetUserBook event, Emitter<BookState> emit) async {
    try {
      emit(BookLoading());
      final book = await repo.getUserBook(event.userId, event.bookId);
      print('reviewid: ${book?.reviewId ?? 'no'}');
      emit(BookLoaded(book: book));
    } catch (e) {
      emit(BookError(message: '$e'));
    }
  }

  void _onUpdateBookStatus(
    UpdateBookStatus event,
    Emitter<BookState> emit,
  ) async {
    emit(BookLoaded(book: event.book));

    try {
      // Update the book in Firestore
      await repo.updateBookStatus(event.userId, event.book);
    } catch (e) {
      emit(BookError(message: 'Failed to update book status: $e'));
    }
  }

  void _onUpdateReviewId(
    UpdateBookReviewId event,
    Emitter<BookState> emit,
  ) async {
    try {
      // Update the book review id in firestore
      await repo.updateBookReviewId(event.userId, event.bookId, event.reviewId);
      add(GetUserBook(userId: event.userId, bookId: event.bookId));
    } catch (e) {
      emit(BookError(message: 'Failed to update book status: $e'));
    }
  }

  void _onDeleteUserBook(DeleteUserBook event, Emitter<BookState> emit) async {
    try {
      // Update the book in Firestore
      await repo.deleteUserBook(event.userId, event.bookId);
    } catch (e) {
      emit(BookError(message: 'Failed to delete book: $e'));
    }
  }
}
