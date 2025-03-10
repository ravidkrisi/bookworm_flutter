// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bookworm/features/search/domain/search_repo.dart';
import 'package:bookworm/features/search/presentation/blocs/search_event.dart';
import 'package:bookworm/features/search/presentation/blocs/search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchRepo repo;
  SearchBloc({required this.repo}) : super(SearchInit()) {
    // register events handlers
    on<SearchBookByTitleReq>(_onFetchBooksByTitle);
  }

  // handlers
  void _onFetchBooksByTitle(
    SearchBookByTitleReq event,
    Emitter<SearchState> emit,
  ) async {
    try {
      emit(SearchLoading());
      final books = await repo.searchBookByTitle(event.title);
      emit(SearchLoaded(books: books));
    } catch (e) {
      emit(SearchErrors(message: '$e'));
    }
  }
}
