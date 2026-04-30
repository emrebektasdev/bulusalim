import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/errors/firebase_exception_mapper.dart';
import '../../../../core/firebase/app_logger.dart';
import '../../domain/repositories/auth_repository.dart';

part 'auth_repository_impl.g.dart';

@riverpod
AuthRepository authRepository(Ref ref) => AuthRepositoryImpl();

/// Concrete Firebase implementation of [AuthRepository].
class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl() : _auth = FirebaseAuth.instance;

  final FirebaseAuth _auth;
  static final _log = AppLogger.getLogger('AuthRepository');

  @override
  Stream<User?> authStateChanges() => _auth.authStateChanges();

  @override
  User? get currentUser => _auth.currentUser;

  @override
  Future<User> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final cred = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      _log.info('Sign in success: ${cred.user?.uid}');
      return cred.user!;
    } catch (e) {
      _log.warning('Sign in failed', e);
      throw mapFirebaseException(e);
    }
  }

  @override
  Future<User> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final cred = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      _log.info('Register success: ${cred.user?.uid}');
      return cred.user!;
    } catch (e) {
      _log.warning('Register failed', e);
      throw mapFirebaseException(e);
    }
  }

  @override
  Future<User> signInWithGoogle() async {
    try {
      final googleAccount = await GoogleSignIn.instance.authenticate();
      final idToken = googleAccount.authentication.idToken;

      final credential = GoogleAuthProvider.credential(idToken: idToken);
      final cred = await _auth.signInWithCredential(credential);
      _log.info('Google sign in success: ${cred.user?.uid}');
      return cred.user!;
    } on GoogleSignInException catch (e) {
      if (e.code == GoogleSignInExceptionCode.canceled ||
          e.code == GoogleSignInExceptionCode.interrupted) {
        throw const ValidationFailure('Google ile giriş iptal edildi.');
      }
      _log.warning('Google sign in failed', e);
      throw mapFirebaseException(e);
    } on Failure {
      rethrow;
    } catch (e) {
      _log.warning('Google sign in failed', e);
      throw mapFirebaseException(e);
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await GoogleSignIn.instance.signOut();
      await _auth.signOut();
      _log.info('Signed out');
    } catch (e) {
      _log.warning('Sign out error', e);
      throw mapFirebaseException(e);
    }
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email.trim());
    } catch (e) {
      throw mapFirebaseException(e);
    }
  }
}
