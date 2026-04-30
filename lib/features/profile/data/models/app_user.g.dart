// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppUser _$AppUserFromJson(Map<String, dynamic> json) => _AppUser(
  uid: json['uid'] as String,
  displayName: json['displayName'] as String,
  photoUrl: json['photoUrl'] as String?,
  bio: json['bio'] as String? ?? '',
  hobbies:
      (json['hobbies'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$AppUserToJson(_AppUser instance) => <String, dynamic>{
  'uid': instance.uid,
  'displayName': instance.displayName,
  'photoUrl': instance.photoUrl,
  'bio': instance.bio,
  'hobbies': instance.hobbies,
  'createdAt': instance.createdAt?.toIso8601String(),
};
