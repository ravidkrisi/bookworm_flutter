import 'package:bookworm/features/review/domain/entities/review.dart';
import 'package:bookworm/features/review/presentation/components/rating_starts.dart';
import 'package:flutter/material.dart';

class ReviewTile extends StatelessWidget {
  final Review review;
  const ReviewTile({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            // user name
            Text(review.reviewText),
          ],
        ),

        Spacer(),

        // rating starts
        RatingStarts(rating: review.rating),
      ],
    );
  }
}
