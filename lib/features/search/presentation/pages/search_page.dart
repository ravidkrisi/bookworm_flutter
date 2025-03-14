import 'dart:async';

import 'package:bookworm/features/books/presentation/components/books_list.dart';
import 'package:bookworm/features/search/presentation/blocs/search_bloc.dart';
import 'package:bookworm/features/search/presentation/blocs/search_event.dart';
import 'package:bookworm/features/search/presentation/blocs/search_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchPage extends StatelessWidget {
  final String currUid;
  const SearchPage({super.key, required this.currUid});

  @override
  Widget build(BuildContext context) {
    final searchController = TextEditingController();

    Timer? debounceTimer; // Timer to handle debounce
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // text field
            TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(
                  FontAwesomeIcons.magnifyingGlass,
                  color: Colors.grey.shade300,
                ),
              ),
              controller: searchController,

              onChanged: (value) {
                // Cancel any existing timer
                debounceTimer?.cancel();

                if (value.isNotEmpty) {
                  debounceTimer = Timer(const Duration(milliseconds: 300), () {
                    context.read<SearchBloc>().add(
                      SearchBookByTitleReq(title: value),
                    );
                  });
                }
              },
            ),

            SizedBox(height: 10),

            BlocConsumer<SearchBloc, SearchState>(
              builder: (context, state) {
                // loading
                if (state is SearchLoading) {
                  return Center(child: CircularProgressIndicator());
                }

                // loaded
                if (state is SearchLoaded) {
                  final books = state.books;
                  if (books.isEmpty) {
                    return Center(child: Text('nothing found'));
                  }
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: BooksList(books: books),
                    ),
                  );
                }
                // default
                else {
                  return Center(child: Text('search for books'));
                }
              },
              listener: (context, state) {
                if (state is SearchErrors) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.message)));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
