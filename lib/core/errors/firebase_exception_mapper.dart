import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';

import 'failure.dart';

/// Maps any Firebase exception to a [Failure].
/// Call this in every repository `catch` block.
Failure mapFirebaseException(Object e) {
  if (e is FirebaseAuthException) {
    return _mapAuthException(e);
  }
  if (e is FirebaseException) {
    return _mapFirestoreException(e);
  }
  if (e is SocketException) {
    return const NetworkFailure();
  }
  return UnknownFailure(e.toString());
}

Failure _mapAuthException(FirebaseAuthException e) {
  switch (e.code) {
    case 'network-request-failed':
      return const NetworkFailure();
    case 'user-not-found':
    case 'wrong-password':
    case 'invalid-credential':
      return const UnauthenticatedFailure('E-posta veya şifre hatalı.');
    case 'email-already-in-use':
      return const ValidationFailure('Bu e-posta adresi zaten kayıtlı.');
    case 'invalid-email':
      return const ValidationFailure('Geçersiz e-posta adresi.');
    case 'weak-password':
      return const ValidationFailure('Şifre çok zayıf. En az 6 karakter olmalı.');
    case 'user-disabled':
      return const PermissionDeniedFailure('Bu hesap devre dışı bırakılmış.');
    case 'too-many-requests':
      return const ServerFailure('Çok fazla istek gönderildi. Biraz bekleyin.');
    default:
      return ServerFailure(e.message ?? 'Kimlik doğrulama hatası.');
  }
}

Failure _mapFirestoreException(FirebaseException e) {
  switch (e.code) {
    case 'unavailable':
    case 'deadline-exceeded':
      return const NetworkFailure();
    case 'unauthenticated':
      return const UnauthenticatedFailure();
    case 'permission-denied':
      return const PermissionDeniedFailure();
    case 'not-found':
      return const NotFoundFailure();
    case 'already-exists':
      return const ValidationFailure('Bu kayıt zaten mevcut.');
    case 'resource-exhausted':
      return const ServerFailure('Kota aşıldı. Lütfen daha sonra tekrar deneyin.');
    default:
      return ServerFailure(e.message ?? 'Firebase hatası.');
  }
}
