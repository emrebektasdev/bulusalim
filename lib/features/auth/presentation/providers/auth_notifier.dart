import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/errors/failure.dart';
import '../../../profile/data/repositories/user_repository_impl.dart';
import '../../data/repositories/auth_repository_impl.dart';

part 'auth_notifier.g.dart';

/// Holds the result of an auth action — UI reads this for loading/error state.
@riverpod
class AuthNotifier extends _$AuthNotifier {
  @override
  FutureOr<bool?> build() {
    // null = idle, true = profile exists, false = needs setup
    return null;
  }

  Future<bool> signInWithEmail({
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading();
    final result = await AsyncValue.guard(() async {
      final user = await ref
          .read(authRepositoryProvider)
          .signInWithEmailAndPassword(email: email, password: password);
      return await _checkProfileExists(user.uid);
    });
    state = result;
    return result.value ?? false;
  }

  Future<bool> registerWithEmail({
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading();
    final result = await AsyncValue.guard(() async {
      await ref
          .read(authRepositoryProvider)
          .createUserWithEmailAndPassword(email: email, password: password);
      return false; // New user — profile does not exist yet.
    });
    state = result;
    return result.value ?? false;
  }

  Future<bool> signInWithGoogle() async {
    state = const AsyncLoading();
    final result = await AsyncValue.guard(() async {
      final user =
          await ref.read(authRepositoryProvider).signInWithGoogle();
      return await _checkProfileExists(user.uid);
    });
    state = result;
    return result.value ?? false;
  }

  Future<void> sendPasswordReset(String email) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(authRepositoryProvider).sendPasswordResetEmail(email);
      return null;
    });
  }

  /// Returns true if a Firestore user document exists for [uid].
  Future<bool> _checkProfileExists(String uid) async {
    final user = await ref.read(userRepositoryProvider).getUser(uid);
    return user != null;
  }

  /// Extracts a user-facing error message from the current state.
  String? get errorMessage {
    final error = state.error;
    if (error is Failure) return error.message;
    if (error != null) return error.toString();
    return null;
  }
}
