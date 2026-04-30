import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:bulusalim_app_01/features/event/data/repositories/event_repository_impl.dart';
import 'package:bulusalim_app_01/features/event/domain/repositories/event_repository.dart';
import 'package:bulusalim_app_01/features/event/data/models/event.dart';
import 'package:bulusalim_app_01/features/event/data/models/event_attendee.dart';
import 'package:bulusalim_app_01/features/auth/presentation/providers/auth_providers.dart';
import 'event_detail_provider.dart';

part 'event_providers.g.dart';

@riverpod
EventRepository eventRepository(Ref ref) {
  return EventRepositoryImpl();
}

/// Generic feed provider for all upcoming public events
@riverpod
Future<List<Event>> homeEventsFeed(Ref ref) async {
  final repo = ref.watch(eventRepositoryProvider);
  return repo.getEvents(limit: 20);
}

/// Feed provider for events tied to a specific community
@riverpod
Future<List<Event>> communityEventsFeed(Ref ref, String communityId) async {
  final repo = ref.watch(eventRepositoryProvider);
  return repo.getCommunityEvents(communityId: communityId, limit: 20);
}

/// Controller to handle RSVP state, preventing double-clicks and managing loading states
@riverpod
class EventRsvpController extends _$EventRsvpController {
  @override
  FutureOr<void> build() {}

  Future<void> updateRsvp(Event event, RsvpStatus newStatus) async {
    final user = ref.read(currentUserProvider);
    if (user == null) {
      state = AsyncError('Oturum açmadınız', StackTrace.current);
      return;
    }

    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(eventRepositoryProvider).updateRsvpStatus(
            event: event,
            uid: user.uid,
            newStatus: newStatus,
          );
      
      // Invalidate to refresh views immediately
      ref.invalidate(eventDetailProvider(event.id));
      ref.invalidate(currentEventAttendeeProvider(event.id));
    });
  }
}
