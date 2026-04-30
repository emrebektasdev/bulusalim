/// Single source of truth for all Firestore collection and document paths.
/// Widgets, providers, and repositories must import this — never hard-code paths.
abstract final class FirestorePaths {
  // ── Top-level collections ──────────────────────────────────────────────────
  static const String users = 'users';
  static const String communities = 'communities';
  static const String events = 'events';

  // ── User document ──────────────────────────────────────────────────────────
  static String userDoc(String uid) => '$users/$uid';

  // ── Community sub-collections ──────────────────────────────────────────────
  static String communityDoc(String communityId) => '$communities/$communityId';
  static String communityMembers(String communityId) => '$communities/$communityId/members';
  static String communityMemberDoc(String communityId, String uid) =>
      '$communities/$communityId/members/$uid';
  static String communityJoinRequests(String communityId) =>
      '$communities/$communityId/joinRequests';
  static String communityJoinRequestDoc(String communityId, String uid) =>
      '$communities/$communityId/joinRequests/$uid';

  // ── Event sub-collections ──────────────────────────────────────────────────
  static String eventDoc(String eventId) => '$events/$eventId';
  static String eventAttendees(String eventId) => '$events/$eventId/attendees';
  static String eventAttendeeDoc(String eventId, String uid) =>
      '$events/$eventId/attendees/$uid';
}

/// Single source of truth for all Firebase Storage paths.
abstract final class StoragePaths {
  static String userAvatar(String uid) => 'users/$uid/avatar.jpg';
  static String communityBanner(String communityId) =>
      'communities/$communityId/banner.jpg';
  static String eventCover(String eventId) => 'events/$eventId/cover.jpg';
}
