import 'package:bookworm/features/books/domain/entities/book.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BookPage extends StatefulWidget {
  final Book book;
  const BookPage({super.key, required this.book});

  @override
  State<BookPage> createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            // cover image
            Container(
              height: 220,
              width: 140,
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(8),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  imageUrl: widget.book.coverUrl,
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  placeholder:
                      (context, url) =>
                          Center(child: CircularProgressIndicator()),
                  imageBuilder:
                      (context, imageProvider) =>
                          Image(image: imageProvider, fit: BoxFit.cover),
                ),
              ),
            ),

            SizedBox(height: 10),

            // book title
            Text(
              widget.book.title,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),

            // author
            Text(
              widget.book.author,
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),

            // first publish yaer
            Text(
              widget.book.firstPublishYear.toString(),
              style: TextStyle(
                fontSize: 12,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
