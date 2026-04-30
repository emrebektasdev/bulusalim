import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_user.freezed.dart';
part 'app_user.g.dart';

/// Mirrors the Firestore `users/{uid}` document schema.
@freezed
abstract class AppUser with _$AppUser {
  const factory AppUser({
    required String uid,
    required String displayName,
    String? photoUrl,
    @Default('') String bio,
    @Default([]) List<String> hobbies,
    DateTime? createdAt,
  }) = _AppUser;

  factory AppUser.fromJson(Map<String, dynamic> json) =>
      _$AppUserFromJson(json);
}
