/// Sealed failure hierarchy — all Firebase errors are mapped here at the
/// repository layer. Widgets and providers only ever see [Failure] subtypes.
sealed class Failure {
  const Failure(this.message);
  final String message;

  @override
  String toString() => '$runtimeType: $message';
}

/// Device is offline or the request timed out.
final class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'İnternet bağlantısı yok veya istek zaman aşımına uğradı.']);
}

/// No valid Firebase Auth session.
final class UnauthenticatedFailure extends Failure {
  const UnauthenticatedFailure([super.message = 'Oturum açmanız gerekiyor.']);
}

/// Firestore Security Rules blocked the request.
final class PermissionDeniedFailure extends Failure {
  const PermissionDeniedFailure([super.message = 'Bu işlem için yetkiniz yok.']);
}

/// Document or resource does not exist.
final class NotFoundFailure extends Failure {
  const NotFoundFailure([super.message = 'İstenen kayıt bulunamadı.']);
}

/// Invalid user input that was caught before or during a write.
final class ValidationFailure extends Failure {
  const ValidationFailure(super.message);
}

/// Unexpected Firebase / backend error.
final class ServerFailure extends Failure {
  const ServerFailure([super.message = 'Sunucu hatası oluştu. Lütfen tekrar deneyin.']);
}

/// Any other unclassified error.
final class UnknownFailure extends Failure {
  const UnknownFailure([super.message = 'Bilinmeyen bir hata oluştu.']);
}
