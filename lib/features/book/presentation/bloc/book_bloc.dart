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
  }

  void _onGetUserBook(GetUserBook event, Emitter<BookState> emit) async {
    try {
      emit(BookLoading());
      final book = await repo.getUserBook(event.userId, event.bookId);
      emit(BookLoaded(book: book));
    } catch (e) {
      emit(BookError(message: '$e'));
    }
  }

  void _onUpdateBookStatus(
    UpdateBookStatus event,
    Emitter<BookState> emit,
  ) async {
    if (state is BookLoaded) {
      final currentBook = (state as BookLoaded).book;

      // Optimistically update UI
      final updatedBook = currentBook!.copyWith(status: event.book.status);
      emit(BookLoaded(book: updatedBook));
    }

    try {
      // Update the book in Firestore
      await repo.updateBookStatus(event.userId, event.book);
    } catch (e) {
      emit(BookError(message: 'Failed to update book status: $e'));
    }
  }
}
