// ignore_for_file: public_member_api_docs, sort_constructors_first
abstract class SearchEvent {}

// search book by title
class SearchBookByTitleReq extends SearchEvent {
  final String title;
  SearchBookByTitleReq({required this.title});
}

// clear serarch
class SearchClearSearch extends SearchEvent {}
