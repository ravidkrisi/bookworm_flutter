import 'package:bookworm/features/books/presentation/bloc/books_bloc.dart';
import 'package:bookworm/features/books/presentation/bloc/books_event.dart';
import 'package:bookworm/features/books/presentation/bloc/books_states.dart';
import 'package:bookworm/features/books/presentation/components/book_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BooksPage extends StatefulWidget {
  const BooksPage({super.key});

  @override
  State<BooksPage> createState() => _BooksPageState();
}

class _BooksPageState extends State<BooksPage> {
  late final BooksBloc booksBloc;
  @override
  void initState() {
    super.initState();
    booksBloc = context.read<BooksBloc>();
    booksBloc.add(FetchBooksByTitle(title: 'lord of'));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BooksBloc, BooksState>(
      builder: (context, state) {
        // loading
        if (state is BooksLoading) {
          return Center(child: CircularProgressIndicator());
        }
        // loaded
        else if (state is BooksLoaded) {
          final books = state.books;
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ListView.separated(
                itemCount: 20,
                separatorBuilder: (context, index) => SizedBox(height: 5),
                itemBuilder: (context, index) => BookTile(book: books[index]),
              ),
            ),
          );
        }
        // default
        else {
          return Center(child: Text('nothing to show'));
        }
      },
      listener: (context, state) {
        if (state is BooksError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
    );
  }
}
