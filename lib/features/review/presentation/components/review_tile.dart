// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bookworm/features/profile/presentation/blocs/profile_bloc.dart';
import 'package:bookworm/features/profile/presentation/blocs/profile_event.dart';
import 'package:flutter/material.dart';

import 'package:bookworm/features/review/domain/entities/review.dart';
import 'package:bookworm/features/review/presentation/components/rating_starts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReviewTile extends StatefulWidget {
  final Review review;
  const ReviewTile({Key? key, required this.review}) : super(key: key);

  @override
  State<ReviewTile> createState() => _ReviewTileState();
}

class _ReviewTileState extends State<ReviewTile> {
  @override
  void initState() {
    super.initState();
  }

  void _fetchUser() {}
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // user name
            Text(
              widget.review.userName,
              style: TextStyle(fontWeight: FontWeight.w500),
            ),

            // review text
            Text(
              widget.review.reviewText,
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ],
        ),

        Spacer(),

        // rating starts
        RatingStarts(rating: widget.review.rating),
      ],
    );
  }
}
