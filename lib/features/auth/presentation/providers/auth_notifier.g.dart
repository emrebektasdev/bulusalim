// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Holds the result of an auth action — UI reads this for loading/error state.

@ProviderFor(AuthNotifier)
final authProvider = AuthNotifierProvider._();

/// Holds the result of an auth action — UI reads this for loading/error state.
final class AuthNotifierProvider
    extends $AsyncNotifierProvider<AuthNotifier, bool?> {
  /// Holds the result of an auth action — UI reads this for loading/error state.
  AuthNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authNotifierHash();

  @$internal
  @override
  AuthNotifier create() => AuthNotifier();
}

String _$authNotifierHash() => r'74f94e54d6d381add212246277a0e1c1bcd1fa2f';

/// Holds the result of an auth action — UI reads this for loading/error state.

abstract class _$AuthNotifier extends $AsyncNotifier<bool?> {
  FutureOr<bool?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<bool?>, bool?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<bool?>, bool?>,
              AsyncValue<bool?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
