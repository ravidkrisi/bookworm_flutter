abstract class AuthEvent {}

// login with email and pwd
class AuthLoginWithEmailPwdRequested extends AuthEvent {
  final String email;
  final String pwd;
  AuthLoginWithEmailPwdRequested({required this.email, required this.pwd});
}

// sign up with email and pwd
class AuthSignUpWithEmailAndPwdRequested extends AuthEvent {
  final String email;
  final String pwd;
  final String name;
  AuthSignUpWithEmailAndPwdRequested({
    required this.email,
    required this.pwd,
    required this.name,
  });
}

// logout
class AuthLogoutRequested extends AuthEvent {}

// check auth

class AuthCheckAuthRequested extends AuthEvent {}
