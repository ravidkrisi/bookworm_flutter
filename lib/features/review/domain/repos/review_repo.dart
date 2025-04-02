import 'package:bookworm/features/profile/data/firebase_profile_repo.dart';
import 'package:bookworm/features/review/data/firebase_review_repo.dart';
import 'package:bookworm/features/review/data/models/review_model.dart';
import 'package:bookworm/features/review/domain/entities/review.dart';

abstract class ReviewRepo {
  // create new review
  Future<void> createReview(ReviewModel review);

  // get all reviews by book id
  Future<List<Review>> getReviewsByBookId(String bookId);

  // get all reviews by user id
  Future<List<Review>> getReviewsByUserId(String userId);

  // get book rating
  Future<double?> getBookRating(String bookId);
}

class ReviewRepoImpl implements ReviewRepo {
  final ReviewRemoteDB reviewRemoteDB;
  final FirebaseProfileRepo firebaseProfileRepo;

  ReviewRepoImpl({
    required this.reviewRemoteDB,
    required this.firebaseProfileRepo,
  });

  @override
  Future<void> createReview(ReviewModel review) async {
    try {
      await reviewRemoteDB.createReview(review);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<double?> getBookRating(String bookId) async {
    try {
      return await reviewRemoteDB.getBookRating(bookId);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Review>> getReviewsByBookId(String bookId) async {
    try {
      final reviewModels = await reviewRemoteDB.getReviewsByBookId(bookId);

      List<Review> reviews = [];
      for (var model in reviewModels) {
        final user = await firebaseProfileRepo.getUserProfile(model.userId);
        if (user != null) {
          final review = Review(
            id: model.id,
            bookId: model.bookId,
            userId: model.userId,
            userName: user.name ?? '',
            rating: model.rating,
            reviewText: model.reviewText,
            createdAt: model.createdAt,
          );
          reviews.add(review);
        }
      }

      return reviews;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Review>> getReviewsByUserId(String userId) {
    // TODO: implement getReviewsByUserId
    throw UnimplementedError();
  }
}
