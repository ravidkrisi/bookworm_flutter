import 'package:bookworm/features/books/domain/entities/book.dart';
import 'package:bookworm/features/books/presentation/components/book_tile.dart';
import 'package:flutter/material.dart';

class BooksList extends StatelessWidget {
  final List<Book> books;
  const BooksList({super.key, required this.books});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: ListView.separated(
            itemCount: books.length,
            separatorBuilder: (context, index) => SizedBox(height: 5),
            itemBuilder: (context, index) => BookTile(book: books[index]),
          ),
        ),
      ),
    );
  }
}
