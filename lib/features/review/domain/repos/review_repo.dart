import 'package:bookworm/features/review/domain/entities/review.dart';

abstract class ReviewRepo {
  // create new review
  Future<void> createReview(Review review);

  // get all reviews by book id
  Future<List<Review>> getReviewsByBookId(String bookId);

  // get all reviews by user id
  Future<List<Review>> getReviewsByUserId(String userId);

  // get book rating
  Future<double?> getBookRating(String bookId);
}
