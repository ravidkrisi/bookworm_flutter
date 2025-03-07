import 'package:bookworm/features/auth/domain/entities/app_user.dart';
import 'package:bookworm/features/auth/domain/repo/auth_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthRepo extends AuthRepo {
  final auth = FirebaseAuth.instance;
  final usersCollection = FirebaseFirestore.instance.collection('users');

  @override
  Future<void> signUpWithEmailAndPwd(
    String email,
    String pwd,
    String name,
  ) async {
    try {
      print('$email');

      // create the user with auth
      final userCred = await auth.createUserWithEmailAndPassword(
        email: email,
        password: pwd,
      );

      // add user to firestore
      final uid = userCred.user?.uid;

      if (uid != null) {
        final user = AppUser(uid: uid, email: email, name: name);
        await usersCollection.doc(user.uid).set(user.toJson());
      } else {
        throw Exception('something went wrong getting user id');
      }
    } catch (e) {
      throw Exception('error sign up: $e');
    }
  }

  @override
  Future<AppUser?> getCurrentUser() async {
    final user = auth.currentUser;

    if (user != null) {
      return AppUser(uid: user.uid, email: user.email ?? '');
    } else {
      return null;
    }
  }

  @override
  Future<void> logout() async {
    await auth.signOut();
  }

  @override
  Future<void> signInWithEmailAndPwd(String email, String pwd) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: pwd);
    } catch (e) {
      throw Exception('error sign in: $e');
    }
  }
}
