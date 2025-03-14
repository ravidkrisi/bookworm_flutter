import 'package:bookworm/features/profile/domain/repos/profile_repo.dart';
import 'package:bookworm/features/profile/presentation/blocs/profile_event.dart';
import 'package:bookworm/features/profile/presentation/blocs/profile_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepo repo;

  ProfileBloc({required this.repo}) : super(ProfileInitial()) {
    // register events handlers
    on<ProfileFetchUserPorfileRequested>(_onFetchProfileUser);
    on<ProfileUpdateProfileImageRequested>(_onUpdateProfileUser);
    on<ProfileBookRemoved>(_onRemoveProfileBook);
  }

  Future<void> _onFetchProfileUser(
    ProfileFetchUserPorfileRequested event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());

    try {
      final user = await repo.getUserProfile(event.uid);
      if (user != null) {
        emit(ProfileLoaded(user: user));
      } else {
        emit(ProfileErrors(message: 'user was not found'));
      }
    } catch (e) {
      emit(ProfileErrors(message: 'error fetching the user: $e'));
    }
  }

  void _onUpdateProfileUser(
    ProfileUpdateProfileImageRequested event,
    Emitter<ProfileState> emit,
  ) async {
    try {
      await repo.updateProfileImage(event.uid, event.imagePath);
      // await _onFetchProfileUser(
      //   ProfileFetchUserPorfileRequested(uid: event.uid),
      //   emit,
      // );
    } catch (e) {
      emit(ProfileErrors(message: 'failed to update profile image: $e'));
    }
  }

  void _onRemoveProfileBook(
    ProfileBookRemoved event,
    Emitter<ProfileState> emit,
  ) async {
    try {
      if (state is ProfileLoaded) {
        final updatedUser = (state as ProfileLoaded).user.copyWith(
          books:
              (state as ProfileLoaded).user.books
                  ?.where((book) => book.id != event.bookId)
                  .toList(),
        );
        emit(ProfileLoaded(user: updatedUser));
      }
    } catch (e) {
      emit(ProfileErrors(message: 'failed to remove book: $e'));
    }
  }
}
