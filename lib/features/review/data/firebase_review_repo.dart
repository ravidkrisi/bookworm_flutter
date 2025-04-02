import 'package:bookworm/features/review/data/models/review_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class ReviewRemoteDB {
  Future<void> createReview(ReviewModel review);
  Future<List<ReviewModel>> getReviewsByBookId(String bookId);
  Future<List<ReviewModel>> getReviewsByUserId(String userId);
  Future<double?> getBookRating(String bookId);
}

class FirebaseReviewRepo implements ReviewRemoteDB {
  final reviewsCollection = FirebaseFirestore.instance.collection('reviews');

  @override
  Future<void> createReview(ReviewModel review) async {
    try {
      await reviewsCollection.doc(review.id).set(review.toJson());
    } catch (e) {
      throw Exception('failed to add review to firebase: $e');
    }
  }

  Future<List<ReviewModel>> _fetchEqualTo(String key, String value) async {
    try {
      // get query
      final querySnapshot =
          await reviewsCollection.where(key, isEqualTo: value).get();

      // get docs
      final docs = querySnapshot.docs;

      // docs -> reviews list
      List<ReviewModel> reviews = [];

      for (var doc in docs) {
        reviews.add(ReviewModel.fromJson(doc.data()));
      }

      return reviews;
    } catch (e) {
      throw Exception('failed to get reviews for $key value: $value: $e');
    }
  }

  @override
  Future<List<ReviewModel>> getReviewsByBookId(String bookId) {
    try {
      return _fetchEqualTo('bookId', bookId);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<ReviewModel>> getReviewsByUserId(String userId) {
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
