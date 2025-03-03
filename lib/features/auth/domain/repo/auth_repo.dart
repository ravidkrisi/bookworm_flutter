import 'package:bookworm/features/auth/domain/entities/app_user.dart';

abstract class AuthRepo {
  // sign in with email and password
  Future<void> signInWithEmailAndPwd(String email, String pwd);
  // sign up with email and password
  Future<void> signUpWithEmailAndPwd(String email, String pwd, String name);
  // get current user
  Future<AppUser?> getCurrentUser();
  // logout
  Future<void> logout();
}
