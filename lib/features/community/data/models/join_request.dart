import 'package:freezed_annotation/freezed_annotation.dart';

part 'join_request.freezed.dart';
part 'join_request.g.dart';

/// Enum representing the status of a join request
enum RequestStatus { pending, approved, rejected }

/// Represents a join request for private communities `communities/{communityId}/joinRequests/{uid}`
@freezed
abstract class JoinRequest with _$JoinRequest {
  const factory JoinRequest({
    required String uid,
    required RequestStatus status,
    DateTime? requestedAt,
  }) = _JoinRequest;

  factory JoinRequest.fromJson(Map<String, dynamic> json) =>
      _$JoinRequestFromJson(json);
}
