import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../profile/data/repositories/user_repository_impl.dart';
import '../../data/repositories/auth_repository_impl.dart';

part 'auth_providers.g.dart';

/// Global auth-state stream. Router watches this for redirect triggers.
@riverpod
Stream<User?> authStateChanges(Ref ref) {
  return ref.watch(authRepositoryProvider).authStateChanges();
}

/// Checks whether the currently signed-in user has a Firestore profile.
@riverpod
Future<bool> isProfileComplete(Ref ref) async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) return false;

  final appUser = await ref.watch(userRepositoryProvider).getUser(user.uid);
  return appUser != null;
}

/// Provides the current Firebase User directly
@riverpod
User? currentUser(Ref ref) {
  return FirebaseAuth.instance.currentUser;
}
