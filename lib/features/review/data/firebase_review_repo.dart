import 'package:bookworm/features/review/domain/entities/review.dart';
import 'package:bookworm/features/review/domain/repos/review_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseReviewRepo implements ReviewRepo {
  final reviewsCollection = FirebaseFirestore.instance.collection('reviews');
  @override
  Future<void> createReview(Review review) async {
    try {
      await reviewsCollection.doc(review.id).set(review.toJson());
    } catch (e) {
      throw Exception('failed to add review to firebase: $e');
    }
  }

  Future<List<Review>> _fetchEqualTo(String key, String value) async {
    try {
      // get query
      final querySnapshot =
          await reviewsCollection.where(key, isEqualTo: value).get();

      // get docs
      final docs = querySnapshot.docs;

      // docs -> reviews list
      List<Review> reviews = [];

      for (var doc in docs) {
        reviews.add(Review.fromJson(doc.data()));
      }

      return reviews;
    } catch (e) {
      throw Exception('failed to get reviews for $key value: $value: $e');
    }
  }

  @override
  Future<List<Review>> getReviewsByBookId(String bookId) {
    try {
      return _fetchEqualTo('bookId', bookId);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Review>> getReviewsByUserId(String userId) {
    try {
      return _fetchEqualTo('userId', userId);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<double?> getBookRating(String bookId) async {
    try {
      // get all reviews
      final reviews = await getReviewsByBookId(bookId);

      // if no reviews return null
      if (reviews.isEmpty) return null;

      // else return averge
      var totalRating = 0;
      for (var review in reviews) {
        totalRating += review.rating;
      }

      final rating = totalRating / reviews.length;
      return rating;
    } catch (e) {
      throw Exception('failed to get book rating: $e');
    }
  }
}
