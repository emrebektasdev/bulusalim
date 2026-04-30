import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:bulusalim_app_01/features/event/data/models/event.dart';
import 'package:bulusalim_app_01/features/event/data/models/event_attendee.dart';
import 'package:bulusalim_app_01/features/auth/presentation/providers/auth_providers.dart';
import 'event_providers.dart';

part 'event_detail_provider.g.dart';

@riverpod
Future<Event?> eventDetail(Ref ref, String eventId) async {
  final repo = ref.watch(eventRepositoryProvider);
  return repo.getEventById(eventId);
}

/// Analyzes the logged-in user's RSVP status for a specific event
@riverpod
Future<EventAttendee?> currentEventAttendee(Ref ref, String eventId) async {
  final user = ref.watch(currentUserProvider);
  if (user == null) return null;

  final repo = ref.watch(eventRepositoryProvider);
  return repo.getEventAttendee(eventId: eventId, uid: user.uid);
}
