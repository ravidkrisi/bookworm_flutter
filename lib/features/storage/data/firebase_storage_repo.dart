import 'dart:typed_data';

import 'package:bookworm/features/storage/domain/storage_repo.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageRepo implements StorageRepo {
  final storage = FirebaseStorage.instance.ref();

  @override
  Future<String> uploadFileToStorage(String filePath, Uint8List data) async {
    try {
      // get file ref
      final fileRef = storage.child(filePath);

      // write data to ref
      await fileRef.putData(data);

      // get download url
      final url = await fileRef.getDownloadURL();

      return url;
    } catch (e) {
      throw Exception('failed to upload file $filePath: $e');
    }
  }
}
