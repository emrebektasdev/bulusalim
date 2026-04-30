import '../../data/models/community.dart';
import '../../data/models/community_member.dart';
import '../../data/models/join_request.dart';

abstract class CommunityRepository {
  /// Create a new community
  Future<Community> createCommunity({
    required String name,
    required String description,
    required String category,
    required bool isPrivate,
    String? coverImageUrl,
    required String currentUserId,
  });

  /// Get communities, optionally paginated. Using Future returning a List for now.
  Future<List<Community>> getCommunities({
    int limit = 20,
    Object? startAfterDocumentSnapshot,
    String? category, // New filter
  });

  /// Get a single community by ID
  Future<Community?> getCommunityById(String communityId);

  /// Update cover image URL
  Future<void> updateCoverImage(String communityId, String url);

  /// Join a community
  Future<void> joinCommunity({
    required String communityId,
    required String uid,
    required bool isPrivate,
  });

  /// Leave a community
  Future<void> leaveCommunity({
    required String communityId,
    required String uid,
  });

  /// Check current user's membership
  Future<CommunityMember?> getMembership({
    required String communityId,
    required String uid,
  });

  /// Check if there's a pending join request
  Future<JoinRequest?> getJoinRequest({
    required String communityId,
    required String uid,
  });
}
