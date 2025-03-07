import 'dart:typed_data';

import 'package:bookworm/features/profile/domain/entities/user_profile.dart';
import 'package:bookworm/features/storage/domain/storage_repo.dart';

abstract class ProfileRepo {
  final StorageRepo storageRepo;
  ProfileRepo({required this.storageRepo});

  // get user profile
  Future<UserProfile?> getUserProfile(String uid);

  // update profile image
  Future<void> updateProfileImage(String uid, Uint8List image);
}
