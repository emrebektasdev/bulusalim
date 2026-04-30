import 'dart:io';

abstract class StorageRepository {
  /// Uploads a cover image for a community and returns the download URL
  Future<String> uploadCommunityCover({
    required File file,
    required String communityId,
  });

  /// Uploads a cover image for an event and returns the download URL
  Future<String> uploadEventCover({
    required File file,
    required String eventId,
  });

  /// Deletes an image given its URL or path
  Future<void> deleteImage(String url);
}
