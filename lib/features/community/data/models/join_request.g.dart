// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'join_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_JoinRequest _$JoinRequestFromJson(Map<String, dynamic> json) => _JoinRequest(
  uid: json['uid'] as String,
  status: $enumDecode(_$RequestStatusEnumMap, json['status']),
  requestedAt: json['requestedAt'] == null
      ? null
      : DateTime.parse(json['requestedAt'] as String),
);

Map<String, dynamic> _$JoinRequestToJson(_JoinRequest instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'status': _$RequestStatusEnumMap[instance.status]!,
      'requestedAt': instance.requestedAt?.toIso8601String(),
    };

const _$RequestStatusEnumMap = {
  RequestStatus.pending: 'pending',
  RequestStatus.approved: 'approved',
  RequestStatus.rejected: 'rejected',
};
