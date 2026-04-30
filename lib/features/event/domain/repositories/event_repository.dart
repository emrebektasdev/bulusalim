import 'package:bulusalim_app_01/features/event/data/models/event.dart';
import 'package:bulusalim_app_01/features/event/data/models/event_attendee.dart';

abstract class EventRepository {
  /// Create a new event
  Future<Event> createEvent({
    required String title,
    required String description,
    required String organizerId,
    String? communityId,
    String? coverImageUrl,
    dynamic location, // GeoPoint
    String? address,
    DateTime? startDate,
    DateTime? endDate,
    int? capacity,
    bool isOnline = false,
    List<String> tags = const [],
  });

  /// Get paginated list of all upcoming events
  Future<List<Event>> getEvents({
    int limit = 20,
    Object? startAfterDocumentSnapshot,
  });

  /// Get events tied to a specific community
  Future<List<Event>> getCommunityEvents({
    required String communityId,
    int limit = 20,
    Object? startAfterDocumentSnapshot,
  });

  /// Fetch single event by ID
  Future<Event?> getEventById(String eventId);

  /// Update event cover image
  Future<void> updateCoverImage(String eventId, String url);

  /// Change RSVP status safely using a Transaction
  Future<void> updateRsvpStatus({
    required Event event,
    required String uid,
    required RsvpStatus newStatus,
  });

  /// Soft delete an event
  Future<void> deleteEvent(String eventId);

  /// Get current user's RSVP status for an event
  Future<EventAttendee?> getEventAttendee({
    required String eventId,
    required String uid,
  });
}
