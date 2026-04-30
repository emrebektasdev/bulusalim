import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/errors/failure.dart';
import '../../data/models/app_user.dart';
import '../../data/repositories/user_repository_impl.dart';

part 'profile_setup_notifier.g.dart';

@riverpod
class ProfileSetupNotifier extends _$ProfileSetupNotifier {
  @override
  FutureOr<void> build() {
    // No-op initial state.
  }

  /// Saves the initial profile to Firestore and returns true on success.
  Future<bool> saveProfile({
    required String displayName,
    required String bio,
    required List<String> hobbies,
  }) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      state = AsyncError(
        const UnauthenticatedFailure(),
        StackTrace.current,
      );
      return false;
    }

    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final appUser = AppUser(
        uid: user.uid,
        displayName: displayName.trim(),
        photoUrl: user.photoURL,
        bio: bio.trim(),
        hobbies: hobbies,
        createdAt: DateTime.now(),
      );
      await ref.read(userRepositoryProvider).createUser(appUser);
    });

    return !state.hasError;
  }

  String? get errorMessage {
    final error = state.error;
    if (error is Failure) return error.message;
    if (error != null) return error.toString();
    return null;
  }
}
