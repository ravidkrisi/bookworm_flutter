import 'dart:typed_data';

import 'package:bookworm/features/books/domain/entities/book.dart';
import 'package:bookworm/features/profile/domain/entities/user_profile.dart';
import 'package:bookworm/features/profile/domain/repos/profile_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseProfileRepo extends ProfileRepo {
  final userCollection = FirebaseFirestore.instance.collection('users');
  final sotorage = FirebaseStorage.instance;

  FirebaseProfileRepo({required super.storageRepo});

  @override
  Future<UserProfile?> getUserProfile(String uid) async {
    try {
      // fetch user doc
      final userRef = userCollection.doc(uid);
      final userDoc = await userRef.get();

      // user doc exist -> user object
      if (userDoc.exists) {
        final user = UserProfile.fromJson(
          userDoc.data() as Map<String, dynamic>,
        );

        // check if the user has books collection
        final booksRef = userRef.collection('books');
        final booksDocs = await booksRef.get();

        // if books exist -> add to user object
        if (booksDocs.docs.isNotEmpty) {
          List<Book> books =
              booksDocs.docs.map((doc) => Book.fromJson(doc.data())).toList();
          user.books = books;
        }

        return user;
      }
      return null;
    } catch (e) {
      throw Exception('error fetch user profile: $e');
    }
  }

  @override
  Future<void> updateProfileImage(String uid, Uint8List image) async {
    try {
      // create file path
      final filePath = 'users/$uid/images/profile_image.jpg';

      // upload profile image to storage
      final downloadUrl = await storageRepo.uploadFileToStorage(
        filePath,
        image,
      );

      // update download url to firestore
      await _updateProfileImageUrl(uid, downloadUrl);
    } catch (e) {
      throw Exception('failed to update profile image: $e');
    }
  }

  Future<void> _updateProfileImageUrl(String uid, String url) async {
    try {
      await userCollection.doc(uid).update({'profile_image_url': url});
    } catch (e) {
      throw Exception('failed to update profile image url: $e');
    }
  }
}
