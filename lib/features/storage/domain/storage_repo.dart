import 'dart:typed_data';

abstract class StorageRepo {
  // upload a file to storage return download URL
  Future<String> uploadFileToStorage(String filePath, Uint8List file);
}
