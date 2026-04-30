// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_attendee.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EventAttendee _$EventAttendeeFromJson(Map<String, dynamic> json) =>
    _EventAttendee(
      uid: json['uid'] as String,
      status: $enumDecode(_$RsvpStatusEnumMap, json['status']),
      joinedAt: json['joinedAt'] == null
          ? null
          : DateTime.parse(json['joinedAt'] as String),
    );

Map<String, dynamic> _$EventAttendeeToJson(_EventAttendee instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'status': _$RsvpStatusEnumMap[instance.status]!,
      'joinedAt': instance.joinedAt?.toIso8601String(),
    };

const _$RsvpStatusEnumMap = {
  RsvpStatus.going: 'going',
  RsvpStatus.interested: 'interested',
  RsvpStatus.not_going: 'not_going',
};
