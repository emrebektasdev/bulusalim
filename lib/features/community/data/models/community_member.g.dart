// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'community_member.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CommunityMember _$CommunityMemberFromJson(Map<String, dynamic> json) =>
    _CommunityMember(
      uid: json['uid'] as String,
      role: $enumDecode(_$CommunityRoleEnumMap, json['role']),
      joinedAt: json['joinedAt'] == null
          ? null
          : DateTime.parse(json['joinedAt'] as String),
    );

Map<String, dynamic> _$CommunityMemberToJson(_CommunityMember instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'role': _$CommunityRoleEnumMap[instance.role]!,
      'joinedAt': instance.joinedAt?.toIso8601String(),
    };

const _$CommunityRoleEnumMap = {
  CommunityRole.owner: 'owner',
  CommunityRole.moderator: 'moderator',
  CommunityRole.member: 'member',
};
