import 'package:freezed_annotation/freezed_annotation.dart';

part 'community.freezed.dart';
part 'community.g.dart';

/// Represents a Community in Firestore `communities/{communityId}`
@freezed
abstract class Community with _$Community {
  const factory Community({
    required String id,
    required String name,
    required String description,
    required String category,
    required String ownerId,
    @Default(1) int memberCount,
    @Default(false) bool isPrivate,
    @Default(false) bool isDeleted,
    String? coverImageUrl,
    DateTime? createdAt,
  }) = _Community;

  factory Community.fromJson(Map<String, dynamic> json) =>
      _$CommunityFromJson(json);
}
