// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:typed_data';

abstract class ProfileEvent {}

// fetch user profile
class ProfileFetchUserPorfileRequested extends ProfileEvent {
  final String uid;
  ProfileFetchUserPorfileRequested({required this.uid});
}

// update profile image
class ProfileUpdateProfileImageRequested extends ProfileEvent {
  final String uid;
  final Uint8List imagePath;
  ProfileUpdateProfileImageRequested({
    required this.uid,
    required this.imagePath,
  });
}

// book being delete from profile
class ProfileBookRemoved extends ProfileEvent {
  final String bookId;
  ProfileBookRemoved({required this.bookId});
}
