// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bookworm/features/review/domain/entities/review.dart';

abstract class ReviewState {}

// init
class ReviewInit extends ReviewState {}

// loading
class ReviewLoading extends ReviewState {}

// loaded
class ReviewLoaded extends ReviewState {
  final double rating;
  final List<Review> reviews;
  ReviewLoaded({required this.reviews, required this.rating});
}

// errors
class ReviewErrors extends ReviewState {
  final String message;
  ReviewErrors({required this.message});
}
