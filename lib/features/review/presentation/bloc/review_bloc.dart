// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bookworm/features/review/domain/repos/review_repo.dart';
import 'package:bookworm/features/review/presentation/bloc/review_event.dart';
import 'package:bookworm/features/review/presentation/bloc/review_state.dart';

class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {
  final ReviewRepo repo;
  ReviewBloc({required this.repo}) : super(ReviewInit()) {
    // register handlers
    on<ReviewAddReview>(_onAddReview);
    on<ReviewGetReviewsByBookId>(_onGetReviewsByBookId);
    // on<ReviewGetReviewsByUserId>(_onGetReviewsByUserId);
  }

  // handlers
  void _onAddReview(ReviewAddReview event, Emitter<ReviewState> emit) async {
    try {
      await repo.createReview(event.review);
    } catch (e) {
      emit(ReviewErrors(message: e.toString()));
    }
  }

  // void _onGetReviewsByUserId(
  //   ReviewGetReviewsByUserId event,
  //   Emitter<ReviewState> emit,
  // ) async {
  //   try {
  //     emit(ReviewLoading());
  //     final reviews = await repo.getReviewsByUserId(event.userId);
  //     emit(ReviewLoaded(reviews: reviews));
  //   } catch (e) {
  //     emit(ReviewErrors(message: e.toString()));
  //   }
  // }

  void _onGetReviewsByBookId(
    ReviewGetReviewsByBookId event,
    Emitter<ReviewState> emit,
  ) async {
    try {
      emit(ReviewLoading());
      final reviews = await repo.getReviewsByBookId(event.bookId);
      final rating = await repo.getBookRating(event.bookId);
      emit(ReviewLoaded(reviews: reviews, rating: rating ?? 0));
    } catch (e) {
      emit(ReviewErrors(message: e.toString()));
    }
  }

  // void _onGetBookRating(
  //   ReviewGetBookRating event,
  //   Emitter<ReviewState> emit,
  // ) async {
  //   try {
  //     emit(ReviewLoading());
  //     final reviews = await repo.getReviewsByBookId(event.bookId);
  //     emit(ReviewLoaded(reviews: reviews));
  //   } catch (e) {
  //     emit(ReviewErrors(message: e.toString()));
  //   }
  // }
}
