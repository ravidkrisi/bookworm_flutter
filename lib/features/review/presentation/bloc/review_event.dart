// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bookworm/features/review/data/models/review_model.dart';

abstract class ReviewEvent {}

// add review
class ReviewAddReview extends ReviewEvent {
  final ReviewModel review;
  ReviewAddReview({required this.review});
}

// get reviews by user id
class ReviewGetReviewsByUserId extends ReviewEvent {
  final String userId;
  ReviewGetReviewsByUserId({required this.userId});
}

// get reviews by book id
class ReviewGetReviewsByBookId extends ReviewEvent {
  final String bookId;
  ReviewGetReviewsByBookId({required this.bookId});
}

// get book rating
class ReviewGetBookRating extends ReviewEvent {
  final String bookId;
  ReviewGetBookRating({required this.bookId});
}
