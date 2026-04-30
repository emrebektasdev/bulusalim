import 'package:firebase_auth/firebase_auth.dart';

/// Contract for all auth operations.
/// Widgets and providers depend on this interface only — never on [FirebaseAuth].
abstract interface class AuthRepository {
  /// Stream of the current Firebase [User]. Emits null when signed out.
  Stream<User?> authStateChanges();

  /// Sign in with email and password.
  /// Throws [Failure] on error.
  Future<User> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  /// Register with email and password.
  Future<User> createUserWithEmailAndPassword({
    required String email,
    required String password,
  });

  /// Sign in with Google.
  Future<User> signInWithGoogle();

  /// Sign out and clear local session.
  Future<void> signOut();

  /// Send a password reset e-mail.
  Future<void> sendPasswordResetEmail(String email);

  /// The currently signed-in user, or null.
  User? get currentUser;
}
