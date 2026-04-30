import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_attendee.freezed.dart';
part 'event_attendee.g.dart';

/// Enum representing the status of an RSVP to an event
enum RsvpStatus { going, interested, not_going }

/// Represents a user's attendee status in `events/{eventId}/attendees/{uid}`
@freezed
abstract class EventAttendee with _$EventAttendee {
  const factory EventAttendee({
    required String uid,
    required RsvpStatus status,
    DateTime? joinedAt,
  }) = _EventAttendee;

  factory EventAttendee.fromJson(Map<String, dynamic> json) =>
      _$EventAttendeeFromJson(json);
}
