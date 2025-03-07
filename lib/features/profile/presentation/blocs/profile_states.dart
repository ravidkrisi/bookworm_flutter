import 'package:bookworm/features/profile/domain/entities/user_profile.dart';

abstract class ProfileState {}

// initial
class ProfileInitial extends ProfileState {}

// loaded
class ProfileLoaded extends ProfileState {
  final UserProfile user;
  ProfileLoaded({required this.user});
}

// loading..
class ProfileLoading extends ProfileState {}

// error
class ProfileErrors extends ProfileState {
  final String message;
  ProfileErrors({required this.message});
}
