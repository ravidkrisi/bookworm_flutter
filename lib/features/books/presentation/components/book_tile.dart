import 'package:bookworm/features/books/domain/entities/book.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BookTile extends StatelessWidget {
  final Book book;
  const BookTile({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // cover image
        Container(
          height: 80,
          width: 60,
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(8),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              imageUrl: book.coverUrl,
              errorWidget: (context, url, error) => Icon(Icons.error),
              placeholder:
                  (context, url) => Center(child: CircularProgressIndicator()),
              imageBuilder:
                  (context, imageProvider) =>
                      Image(image: imageProvider, fit: BoxFit.cover),
            ),
          ),
        ),

        SizedBox(width: 10),

        // book info
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // book title
              Text(
                book.title,
                style: TextStyle(fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),

              // book author
              Text(
                book.author,
                // style: TextStyle(fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ],
          ),
        ),
        // navigator -> book Page
        Icon(FontAwesomeIcons.chevronRight, color: Colors.grey),
      ],
    );
  }
}
