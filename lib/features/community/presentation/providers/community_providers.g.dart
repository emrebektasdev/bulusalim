// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'community_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(communityRepository)
final communityRepositoryProvider = CommunityRepositoryProvider._();

final class CommunityRepositoryProvider
    extends
        $FunctionalProvider<
          CommunityRepository,
          CommunityRepository,
          CommunityRepository
        >
    with $Provider<CommunityRepository> {
  CommunityRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'communityRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$communityRepositoryHash();

  @$internal
  @override
  $ProviderElement<CommunityRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CommunityRepository create(Ref ref) {
    return communityRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CommunityRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CommunityRepository>(value),
    );
  }
}

String _$communityRepositoryHash() =>
    r'020966b9709972107513db0dfeff92f1e6e2b6a3';

@ProviderFor(CommunitySearchQuery)
final communitySearchQueryProvider = CommunitySearchQueryProvider._();

final class CommunitySearchQueryProvider
    extends $NotifierProvider<CommunitySearchQuery, String> {
  CommunitySearchQueryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'communitySearchQueryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$communitySearchQueryHash();

  @$internal
  @override
  CommunitySearchQuery create() => CommunitySearchQuery();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$communitySearchQueryHash() =>
    r'f698b52fc6d980d5c7ed21be3b46dc084699d9f9';

abstract class _$CommunitySearchQuery extends $Notifier<String> {
  String build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<String, String>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String, String>,
              String,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(CommunityCategoryFilter)
final communityCategoryFilterProvider = CommunityCategoryFilterProvider._();

final class CommunityCategoryFilterProvider
    extends $NotifierProvider<CommunityCategoryFilter, String> {
  CommunityCategoryFilterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'communityCategoryFilterProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$communityCategoryFilterHash();

  @$internal
  @override
  CommunityCategoryFilter create() => CommunityCategoryFilter();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$communityCategoryFilterHash() =>
    r'422767232ef3a1420bb27eb4327c6baee53cb61d';

abstract class _$CommunityCategoryFilter extends $Notifier<String> {
  String build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<String, String>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String, String>,
              String,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// A dynamic feed provider that responds to search and category filters

@ProviderFor(communitiesFeed)
final communitiesFeedProvider = CommunitiesFeedProvider._();

/// A dynamic feed provider that responds to search and category filters

final class CommunitiesFeedProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Community>>,
          List<Community>,
          FutureOr<List<Community>>
        >
    with $FutureModifier<List<Community>>, $FutureProvider<List<Community>> {
  /// A dynamic feed provider that responds to search and category filters
  CommunitiesFeedProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'communitiesFeedProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$communitiesFeedHash();

  @$internal
  @override
  $FutureProviderElement<List<Community>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Community>> create(Ref ref) {
    return communitiesFeed(ref);
  }
}

String _$communitiesFeedHash() => r'9e6eb080c431e14b03b6943209d1640658429dc9';

/// A controller to handle join/leave actions from the UI

@ProviderFor(CommunityJoinController)
final communityJoinControllerProvider = CommunityJoinControllerProvider._();

/// A controller to handle join/leave actions from the UI
final class CommunityJoinControllerProvider
    extends $AsyncNotifierProvider<CommunityJoinController, void> {
  /// A controller to handle join/leave actions from the UI
  CommunityJoinControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'communityJoinControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$communityJoinControllerHash();

  @$internal
  @override
  CommunityJoinController create() => CommunityJoinController();
}

String _$communityJoinControllerHash() =>
    r'51b8e3bbabe0d8bff3ad254127e96d12e9c0fafc';

/// A controller to handle join/leave actions from the UI

abstract class _$CommunityJoinController extends $AsyncNotifier<void> {
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
