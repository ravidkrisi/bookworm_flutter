import 'package:bookworm/features/books/domain/entities/book.dart';
import 'package:bookworm/features/books/presentation/components/book_tile.dart';
import 'package:flutter/material.dart';

class BooksList extends StatelessWidget {
  final List<Book> books;
  final bool showStatus;
  const BooksList({super.key, required this.books, this.showStatus = false});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        itemCount: books.length,
        separatorBuilder: (context, index) => SizedBox(height: 5),
        itemBuilder:
            (context, index) =>
                BookTile(book: books[index], showStatus: showStatus),
      ),
    );
  }
}
