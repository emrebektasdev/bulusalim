import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:bulusalim_app_01/core/firebase/storage_repository.dart';

class StorageRepositoryImpl implements StorageRepository {
  final FirebaseStorage _storage;

  StorageRepositoryImpl({FirebaseStorage? storage})
      : _storage = storage ?? FirebaseStorage.instance;

  @override
  Future<String> uploadCommunityCover({
    required File file,
    required String communityId,
  }) async {
    final ref = _storage.ref().child('communities/$communityId/cover.jpg');
    final uploadTask = ref.putFile(
      file,
      SettableMetadata(contentType: 'image/jpeg'),
    );
    final snapshot = await uploadTask;
    return await snapshot.ref.getDownloadURL();
  }

  @override
  Future<String> uploadEventCover({
    required File file,
    required String eventId,
  }) async {
    final ref = _storage.ref().child('events/$eventId/cover.jpg');
    final uploadTask = ref.putFile(
      file,
      SettableMetadata(contentType: 'image/jpeg'),
    );
    final snapshot = await uploadTask;
    return await snapshot.ref.getDownloadURL();
  }

  @override
  Future<void> deleteImage(String url) async {
    try {
      final ref = _storage.refFromURL(url);
      await ref.delete();
    } catch (e) {
      // Ignore if image doesn't exist or deletion fails
      print('Warning: Failed to delete image at $url: $e');
    }
  }
}
