// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_setup_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ProfileSetupNotifier)
final profileSetupProvider = ProfileSetupNotifierProvider._();

final class ProfileSetupNotifierProvider
    extends $AsyncNotifierProvider<ProfileSetupNotifier, void> {
  ProfileSetupNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'profileSetupProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$profileSetupNotifierHash();

  @$internal
  @override
  ProfileSetupNotifier create() => ProfileSetupNotifier();
}

String _$profileSetupNotifierHash() =>
    r'aed37b4262b18a37217db18553c7747bd415eb91';

abstract class _$ProfileSetupNotifier extends $AsyncNotifier<void> {
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
