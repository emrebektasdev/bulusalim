import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:bulusalim_app_01/core/firebase/firebase_paths.dart';
import 'package:bulusalim_app_01/features/event/data/models/event.dart';
import 'package:bulusalim_app_01/features/event/data/models/event_attendee.dart';
import 'package:bulusalim_app_01/features/event/domain/repositories/event_repository.dart';

class EventRepositoryImpl implements EventRepository {
  final FirebaseFirestore _firestore;

  EventRepositoryImpl({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  CollectionReference<Event> get _eventsRef =>
      _firestore.collection(FirestorePaths.events).withConverter<Event>(
            fromFirestore: (snapshot, _) => Event.fromJson(
              {'id': snapshot.id, ...?snapshot.data()},
            ),
            toFirestore: (event, _) {
              final json = event.toJson();
              json.remove('id'); // ID is the document key
              if (json['createdAt'] == null) {
                json['createdAt'] = FieldValue.serverTimestamp();
              }
              return json;
            },
          );

  CollectionReference<EventAttendee> _attendeesRef(String eventId) =>
      _firestore.collection(FirestorePaths.eventAttendees(eventId)).withConverter<EventAttendee>(
            fromFirestore: (snapshot, _) => EventAttendee.fromJson(snapshot.data()!),
            toFirestore: (attendee, _) {
              final json = attendee.toJson();
              if (json['joinedAt'] == null) {
                json['joinedAt'] = FieldValue.serverTimestamp();
              }
              return json;
            },
          );

  @override
  Future<Event> createEvent({
    required String title,
    required String description,
    required String organizerId,
    String? communityId,
    String? coverImageUrl,
    dynamic location,
    String? address,
    DateTime? startDate,
    DateTime? endDate,
    int? capacity,
    bool isOnline = false,
    List<String> tags = const [],
  }) async {
    final newDoc = _eventsRef.doc();
    final event = Event(
      id: newDoc.id,
      title: title,
      description: description,
      organizerId: organizerId,
      communityId: communityId,
      coverImageUrl: coverImageUrl,
      location: location as GeoPoint?,
      address: address,
      startDate: startDate,
      endDate: endDate,
      capacity: capacity,
      isOnline: isOnline,
      tags: tags,
      attendeeCount: 1, // Organizer automatically 'going'
    );

    final attendee = EventAttendee(
      uid: organizerId,
      status: RsvpStatus.going,
    );

    final batch = _firestore.batch();
    batch.set(newDoc, event);
    batch.set(_attendeesRef(newDoc.id).doc(organizerId), attendee);
    await batch.commit();

    return event;
  }

  @override
  Future<List<Event>> getEvents({
    int limit = 20,
    Object? startAfterDocumentSnapshot,
  }) async {
    var query = _eventsRef
        .where('isDeleted', isEqualTo: false)
        .where('startDate', isGreaterThanOrEqualTo: DateTime.now()) // Only upcoming
        .orderBy('startDate', descending: false)
        .limit(limit);

    if (startAfterDocumentSnapshot != null && startAfterDocumentSnapshot is DocumentSnapshot) {
      query = query.startAfterDocument(startAfterDocumentSnapshot);
    }

    final snapshot = await query.get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  @override
  Future<List<Event>> getCommunityEvents({
    required String communityId,
    int limit = 20,
    Object? startAfterDocumentSnapshot,
  }) async {
    var query = _eventsRef
        .where('communityId', isEqualTo: communityId)
        .where('isDeleted', isEqualTo: false)
        .orderBy('createdAt', descending: true) // For community, maybe show all including past
        .limit(limit);

    if (startAfterDocumentSnapshot != null && startAfterDocumentSnapshot is DocumentSnapshot) {
      query = query.startAfterDocument(startAfterDocumentSnapshot);
    }

    final snapshot = await query.get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  @override
  Future<Event?> getEventById(String eventId) async {
    final doc = await _eventsRef.doc(eventId).get();
    if (doc.exists && doc.data()?.isDeleted == false) {
      return doc.data();
    }
    return null;
  }

  @override
  Future<void> updateCoverImage(String eventId, String url) async {
    await _eventsRef.doc(eventId).update({
      'coverImageUrl': url,
    });
  }

  @override
  Future<void> updateRsvpStatus({
    required Event event,
    required String uid,
    required RsvpStatus newStatus,
  }) async {
    final eventDocRef = _eventsRef.doc(event.id);
    final attendeeDocRef = _attendeesRef(event.id).doc(uid);

    await _firestore.runTransaction((transaction) async {
      final eventDoc = await transaction.get(eventDocRef);
      if (!eventDoc.exists) {
        throw Exception('Etkinlik bulunamadı.');
      }
      final currentEventData = eventDoc.data()!;

      final attendeeDoc = await transaction.get(attendeeDocRef);
      final currentStatus = attendeeDoc.exists ? attendeeDoc.data()!.status : null;

      // Determine changes to attendee count
      int countChange = 0;
      if (newStatus == RsvpStatus.going && currentStatus != RsvpStatus.going) {
        countChange = 1;
      } else if (newStatus != RsvpStatus.going && currentStatus == RsvpStatus.going) {
        countChange = -1;
      }

      // Check capacity
      if (countChange > 0 && currentEventData.capacity != null) {
        if (currentEventData.attendeeCount >= currentEventData.capacity!) {
          throw Exception('Kapasite dolu, artık "Gidiyorum" olarak işaretleyemezsiniz.');
        }
      }

      // Write changes
      final newAttendee = EventAttendee(
        uid: uid,
        status: newStatus,
      );
      transaction.set(attendeeDocRef, newAttendee);

      if (countChange != 0) {
        transaction.update(eventDocRef, {
          'attendeeCount': FieldValue.increment(countChange),
        });
      }
    });
  }

  @override
  Future<void> deleteEvent(String eventId) async {
    await _eventsRef.doc(eventId).update({'isDeleted': true});
  }

  @override
  Future<EventAttendee?> getEventAttendee({
    required String eventId,
    required String uid,
  }) async {
    final doc = await _attendeesRef(eventId).doc(uid).get();
    return doc.data();
  }
}
