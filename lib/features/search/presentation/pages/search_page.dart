import 'dart:async';

import 'package:bookworm/features/books/presentation/components/books_list.dart';
import 'package:bookworm/features/search/presentation/blocs/search_bloc.dart';
import 'package:bookworm/features/search/presentation/blocs/search_event.dart';
import 'package:bookworm/features/search/presentation/blocs/search_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchPage extends StatefulWidget {
  final String currUid;
  const SearchPage({super.key, required this.currUid});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController searchController = TextEditingController();
  Timer? debounceTimer;

  @override
  void initState() {
    super.initState();

    // Add a listener to trigger rebuild when text changes
    searchController.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    debounceTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Search text field
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                suffixIcon:
                    searchController.text.isNotEmpty
                        ? IconButton(
                          onPressed: () {
                            searchController.clear();
                            context.read<SearchBloc>().add(SearchClearSearch());
                            setState(() {}); // Trigger rebuild to remove icon
                          },
                          icon: const Icon(Icons.cancel, color: Colors.grey),
                        )
                        : null,
                prefixIcon: Icon(
                  FontAwesomeIcons.magnifyingGlass,
                  color: Colors.grey.shade300,
                ),
              ),
              onChanged: (value) {
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

            const SizedBox(height: 10),

            BlocConsumer<SearchBloc, SearchState>(
              builder: (context, state) {
                if (state is SearchLoading) {
                  return Expanded(
                    child: const Center(child: CircularProgressIndicator()),
                  );
                }
                if (state is SearchLoaded) {
                  final books = state.books;
                  if (books.isEmpty) {
                    return const Center(child: Text('Nothing found'));
                  }
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: BooksList(books: books),
                    ),
                  );
                }
                return const Center(child: Text('Search for books'));
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
