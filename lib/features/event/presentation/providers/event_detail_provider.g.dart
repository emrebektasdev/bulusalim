// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_detail_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(eventDetail)
final eventDetailProvider = EventDetailFamily._();

final class EventDetailProvider
    extends $FunctionalProvider<AsyncValue<Event?>, Event?, FutureOr<Event?>>
    with $FutureModifier<Event?>, $FutureProvider<Event?> {
  EventDetailProvider._({
    required EventDetailFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'eventDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$eventDetailHash();

  @override
  String toString() {
    return r'eventDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Event?> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Event?> create(Ref ref) {
    final argument = this.argument as String;
    return eventDetail(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is EventDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$eventDetailHash() => r'2d1169d4623205fb729169ff8a85320e292a31c9';

final class EventDetailFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Event?>, String> {
  EventDetailFamily._()
    : super(
        retry: null,
        name: r'eventDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  EventDetailProvider call(String eventId) =>
      EventDetailProvider._(argument: eventId, from: this);

  @override
  String toString() => r'eventDetailProvider';
}

/// Analyzes the logged-in user's RSVP status for a specific event

@ProviderFor(currentEventAttendee)
final currentEventAttendeeProvider = CurrentEventAttendeeFamily._();

/// Analyzes the logged-in user's RSVP status for a specific event

final class CurrentEventAttendeeProvider
    extends
        $FunctionalProvider<
          AsyncValue<EventAttendee?>,
          EventAttendee?,
          FutureOr<EventAttendee?>
        >
    with $FutureModifier<EventAttendee?>, $FutureProvider<EventAttendee?> {
  /// Analyzes the logged-in user's RSVP status for a specific event
  CurrentEventAttendeeProvider._({
    required CurrentEventAttendeeFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'currentEventAttendeeProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$currentEventAttendeeHash();

  @override
  String toString() {
    return r'currentEventAttendeeProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<EventAttendee?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<EventAttendee?> create(Ref ref) {
    final argument = this.argument as String;
    return currentEventAttendee(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is CurrentEventAttendeeProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$currentEventAttendeeHash() =>
    r'8c4cebd5b3867ef152cb331257fcb80a2ff7d8f9';

/// Analyzes the logged-in user's RSVP status for a specific event

final class CurrentEventAttendeeFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<EventAttendee?>, String> {
  CurrentEventAttendeeFamily._()
    : super(
        retry: null,
        name: r'currentEventAttendeeProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Analyzes the logged-in user's RSVP status for a specific event

  CurrentEventAttendeeProvider call(String eventId) =>
      CurrentEventAttendeeProvider._(argument: eventId, from: this);

  @override
  String toString() => r'currentEventAttendeeProvider';
}
