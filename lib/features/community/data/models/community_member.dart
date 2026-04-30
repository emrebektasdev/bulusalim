import 'package:freezed_annotation/freezed_annotation.dart';

part 'community_member.freezed.dart';
part 'community_member.g.dart';

/// Enum representing the possible roles in a community
enum CommunityRole { owner, moderator, member }

/// Represents a user's membership in `communities/{communityId}/members/{uid}`
@freezed
abstract class CommunityMember with _$CommunityMember {
  const factory CommunityMember({
    required String uid,
    required CommunityRole role,
    DateTime? joinedAt,
  }) = _CommunityMember;

  factory CommunityMember.fromJson(Map<String, dynamic> json) =>
      _$CommunityMemberFromJson(json);
}
