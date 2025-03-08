import 'package:bookworm/features/books/domain/repos/books_repo.dart';
import 'package:bookworm/features/books/presentation/blocs/books_event.dart';
import 'package:bookworm/features/books/presentation/blocs/books_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BooksBloc extends Bloc<BooksEvent, BooksState> {
  final BooksRepo repo;

  BooksBloc({required this.repo}) : super(BooksInitial()) {
    // register events handlers
    on<FetchBooksByTitle>(_onFetchBooksByTitle);
  }

  void _onFetchBooksByTitle(
    FetchBooksByTitle event,
    Emitter<BooksState> emit,
  ) async {
    try {
      emit(BooksLoading());
      final books = await repo.getBooksDetails(event.title);
      emit(BooksLoaded(books: books));
    } catch (e) {
      emit(BooksError(message: '$e'));
    }
  }
}
