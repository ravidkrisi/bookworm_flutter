import 'package:bookworm/features/auth/domain/entities/app_user.dart';

abstract class AuthState {}

// initial state
class AuthInitial extends AuthState {}

// loading
class AuthLoading extends AuthState {}

// authenticated
class AuthAuthenticated extends AuthState {
  final AppUser user;
  AuthAuthenticated({required this.user});
}

// unauthenticated
class AuthUnauthenticated extends AuthState {}

// errors
class AuthErrors extends AuthState {
  final String message;
  AuthErrors({this.message = ''});
}
