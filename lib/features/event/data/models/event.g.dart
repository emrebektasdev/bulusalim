// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Event _$EventFromJson(Map<String, dynamic> json) => _Event(
  id: json['id'] as String,
  title: json['title'] as String,
  description: json['description'] as String,
  organizerId: json['organizerId'] as String,
  communityId: json['communityId'] as String?,
  coverImageUrl: json['coverImageUrl'] as String?,
  location: const GeoPointConverter().fromJson(json['location'] as GeoPoint?),
  address: json['address'] as String?,
  startDate: json['startDate'] == null
      ? null
      : DateTime.parse(json['startDate'] as String),
  endDate: json['endDate'] == null
      ? null
      : DateTime.parse(json['endDate'] as String),
  capacity: (json['capacity'] as num?)?.toInt(),
  attendeeCount: (json['attendeeCount'] as num?)?.toInt() ?? 0,
  isOnline: json['isOnline'] as bool? ?? false,
  tags:
      (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  isDeleted: json['isDeleted'] as bool? ?? false,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$EventToJson(_Event instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'organizerId': instance.organizerId,
  'communityId': instance.communityId,
  'coverImageUrl': instance.coverImageUrl,
  'location': const GeoPointConverter().toJson(instance.location),
  'address': instance.address,
  'startDate': instance.startDate?.toIso8601String(),
  'endDate': instance.endDate?.toIso8601String(),
  'capacity': instance.capacity,
  'attendeeCount': instance.attendeeCount,
  'isOnline': instance.isOnline,
  'tags': instance.tags,
  'isDeleted': instance.isDeleted,
  'createdAt': instance.createdAt?.toIso8601String(),
};
