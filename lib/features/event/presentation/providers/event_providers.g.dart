// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(eventRepository)
final eventRepositoryProvider = EventRepositoryProvider._();

final class EventRepositoryProvider
    extends
        $FunctionalProvider<EventRepository, EventRepository, EventRepository>
    with $Provider<EventRepository> {
  EventRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'eventRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$eventRepositoryHash();

  @$internal
  @override
  $ProviderElement<EventRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  EventRepository create(Ref ref) {
    return eventRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EventRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EventRepository>(value),
    );
  }
}

String _$eventRepositoryHash() => r'ee84eaf53350c7d84daeefcd2639bf63376152b3';

/// Generic feed provider for all upcoming public events

@ProviderFor(homeEventsFeed)
final homeEventsFeedProvider = HomeEventsFeedProvider._();

/// Generic feed provider for all upcoming public events

final class HomeEventsFeedProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Event>>,
          List<Event>,
          FutureOr<List<Event>>
        >
    with $FutureModifier<List<Event>>, $FutureProvider<List<Event>> {
  /// Generic feed provider for all upcoming public events
  HomeEventsFeedProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homeEventsFeedProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$homeEventsFeedHash();

  @$internal
  @override
  $FutureProviderElement<List<Event>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Event>> create(Ref ref) {
    return homeEventsFeed(ref);
  }
}

String _$homeEventsFeedHash() => r'81cd5b8171a44f370156215ac78807c548c60ca0';

/// Feed provider for events tied to a specific community

@ProviderFor(communityEventsFeed)
final communityEventsFeedProvider = CommunityEventsFeedFamily._();

/// Feed provider for events tied to a specific community

final class CommunityEventsFeedProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Event>>,
          List<Event>,
          FutureOr<List<Event>>
        >
    with $FutureModifier<List<Event>>, $FutureProvider<List<Event>> {
  /// Feed provider for events tied to a specific community
  CommunityEventsFeedProvider._({
    required CommunityEventsFeedFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'communityEventsFeedProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$communityEventsFeedHash();

  @override
  String toString() {
    return r'communityEventsFeedProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<Event>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Event>> create(Ref ref) {
    final argument = this.argument as String;
    return communityEventsFeed(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is CommunityEventsFeedProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$communityEventsFeedHash() =>
    r'8f68b34a8c2152308d0917ff978ce45b537d7e8a';

/// Feed provider for events tied to a specific community

final class CommunityEventsFeedFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<Event>>, String> {
  CommunityEventsFeedFamily._()
    : super(
        retry: null,
        name: r'communityEventsFeedProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Feed provider for events tied to a specific community

  CommunityEventsFeedProvider call(String communityId) =>
      CommunityEventsFeedProvider._(argument: communityId, from: this);

  @override
  String toString() => r'communityEventsFeedProvider';
}

/// Controller to handle RSVP state, preventing double-clicks and managing loading states

@ProviderFor(EventRsvpController)
final eventRsvpControllerProvider = EventRsvpControllerProvider._();

/// Controller to handle RSVP state, preventing double-clicks and managing loading states
final class EventRsvpControllerProvider
    extends $AsyncNotifierProvider<EventRsvpController, void> {
  /// Controller to handle RSVP state, preventing double-clicks and managing loading states
  EventRsvpControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'eventRsvpControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$eventRsvpControllerHash();

  @$internal
  @override
  EventRsvpController create() => EventRsvpController();
}

String _$eventRsvpControllerHash() =>
    r'4efd5e43160716d043fc6a48b7ca72ba042bd2ce';

/// Controller to handle RSVP state, preventing double-clicks and managing loading states

abstract class _$EventRsvpController extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
