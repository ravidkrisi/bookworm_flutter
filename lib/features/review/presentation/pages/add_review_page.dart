import 'package:bookworm/features/book/presentation/bloc/book_bloc.dart';
import 'package:bookworm/features/book/presentation/bloc/book_event.dart';
import 'package:bookworm/features/books/domain/entities/book.dart';
import 'package:bookworm/features/review/data/models/review_model.dart';
import 'package:bookworm/features/review/domain/entities/review.dart';
import 'package:bookworm/features/review/presentation/bloc/review_bloc.dart';
import 'package:bookworm/features/review/presentation/bloc/review_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

class AddReviewPage extends StatefulWidget {
  final Book book;
  final String userId;
  const AddReviewPage({super.key, required this.book, required this.userId});

  @override
  State<AddReviewPage> createState() => _AddReviewPageState();
}

class _AddReviewPageState extends State<AddReviewPage> {
  // controllers
  final reviewTextController = TextEditingController();
  final ratingTextController = TextEditingController();
  double _ratingValue = 2;

  void _onAddReviewPressed(BuildContext context) {
    // make sure review is not empty
    if (reviewTextController.text.isEmpty) return;

    // prepare data
    final reviewText = reviewTextController.text;
    final rating = _ratingValue.round();

    // create review
    final review = ReviewModel(
      id: Uuid().v4(),
      bookId: widget.book.id,
      userId: widget.userId,
      rating: rating,
      reviewText: reviewText,
      createdAt: DateTime.now(),
    );

    context.read<ReviewBloc>().add(ReviewAddReview(review: review));
    context.read<BookBloc>().add(
      UpdateBookReviewId(
        userId: widget.userId,
        bookId: widget.book.id,
        reviewId: review.id,
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Review')),
      body: Column(
        children: [
          // review text
          TextField(
            controller: reviewTextController,
            decoration: InputDecoration(hintText: 'write something'),
          ),

          Slider(
            value: _ratingValue,
            min: 0,
            max: 5,
            divisions: 4,
            label: _ratingValue.round().toString(),
            onChanged: (value) {
              setState(() {
                _ratingValue = value;
              });
            },
          ),

          // submit btn
          ElevatedButton(
            onPressed: () => _onAddReviewPressed(context),
            child: Text('Add'),
          ),
        ],
      ),
    );
  }
}
