// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'community_detail_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(communityDetail)
final communityDetailProvider = CommunityDetailFamily._();

final class CommunityDetailProvider
    extends
        $FunctionalProvider<
          AsyncValue<Community?>,
          Community?,
          FutureOr<Community?>
        >
    with $FutureModifier<Community?>, $FutureProvider<Community?> {
  CommunityDetailProvider._({
    required CommunityDetailFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'communityDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$communityDetailHash();

  @override
  String toString() {
    return r'communityDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Community?> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Community?> create(Ref ref) {
    final argument = this.argument as String;
    return communityDetail(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is CommunityDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$communityDetailHash() => r'2894a9344dad2dea5fbc200f9a6682c9e8144c11';

final class CommunityDetailFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Community?>, String> {
  CommunityDetailFamily._()
    : super(
        retry: null,
        name: r'communityDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CommunityDetailProvider call(String communityId) =>
      CommunityDetailProvider._(argument: communityId, from: this);

  @override
  String toString() => r'communityDetailProvider';
}

/// Checks if the current user is a member of the given community

@ProviderFor(currentMembership)
final currentMembershipProvider = CurrentMembershipFamily._();

/// Checks if the current user is a member of the given community

final class CurrentMembershipProvider
    extends
        $FunctionalProvider<
          AsyncValue<CommunityMember?>,
          CommunityMember?,
          FutureOr<CommunityMember?>
        >
    with $FutureModifier<CommunityMember?>, $FutureProvider<CommunityMember?> {
  /// Checks if the current user is a member of the given community
  CurrentMembershipProvider._({
    required CurrentMembershipFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'currentMembershipProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$currentMembershipHash();

  @override
  String toString() {
    return r'currentMembershipProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<CommunityMember?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<CommunityMember?> create(Ref ref) {
    final argument = this.argument as String;
    return currentMembership(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is CurrentMembershipProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$currentMembershipHash() => r'808877c2125a0262b76a2e91acfe4270489557ec';

/// Checks if the current user is a member of the given community

final class CurrentMembershipFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<CommunityMember?>, String> {
  CurrentMembershipFamily._()
    : super(
        retry: null,
        name: r'currentMembershipProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Checks if the current user is a member of the given community

  CurrentMembershipProvider call(String communityId) =>
      CurrentMembershipProvider._(argument: communityId, from: this);

  @override
  String toString() => r'currentMembershipProvider';
}

/// Checks if the current user has a pending join request for the given private community

@ProviderFor(currentJoinRequest)
final currentJoinRequestProvider = CurrentJoinRequestFamily._();

/// Checks if the current user has a pending join request for the given private community

final class CurrentJoinRequestProvider
    extends
        $FunctionalProvider<
          AsyncValue<JoinRequest?>,
          JoinRequest?,
          FutureOr<JoinRequest?>
        >
    with $FutureModifier<JoinRequest?>, $FutureProvider<JoinRequest?> {
  /// Checks if the current user has a pending join request for the given private community
  CurrentJoinRequestProvider._({
    required CurrentJoinRequestFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'currentJoinRequestProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$currentJoinRequestHash();

  @override
  String toString() {
    return r'currentJoinRequestProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<JoinRequest?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<JoinRequest?> create(Ref ref) {
    final argument = this.argument as String;
    return currentJoinRequest(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is CurrentJoinRequestProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$currentJoinRequestHash() =>
    r'ee70b4e291f406b85bd4ed05387d4efe0123c240';

/// Checks if the current user has a pending join request for the given private community

final class CurrentJoinRequestFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<JoinRequest?>, String> {
  CurrentJoinRequestFamily._()
    : super(
        retry: null,
        name: r'currentJoinRequestProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Checks if the current user has a pending join request for the given private community

  CurrentJoinRequestProvider call(String communityId) =>
      CurrentJoinRequestProvider._(argument: communityId, from: this);

  @override
  String toString() => r'currentJoinRequestProvider';
}
