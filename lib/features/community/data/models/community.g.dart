// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'community.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Community _$CommunityFromJson(Map<String, dynamic> json) => _Community(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String,
  category: json['category'] as String,
  ownerId: json['ownerId'] as String,
  memberCount: (json['memberCount'] as num?)?.toInt() ?? 1,
  isPrivate: json['isPrivate'] as bool? ?? false,
  isDeleted: json['isDeleted'] as bool? ?? false,
  coverImageUrl: json['coverImageUrl'] as String?,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$CommunityToJson(_Community instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'category': instance.category,
      'ownerId': instance.ownerId,
      'memberCount': instance.memberCount,
      'isPrivate': instance.isPrivate,
      'isDeleted': instance.isDeleted,
      'coverImageUrl': instance.coverImageUrl,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
