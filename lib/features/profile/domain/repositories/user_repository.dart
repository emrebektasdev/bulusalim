import '../../data/models/app_user.dart';

abstract interface class UserRepository {
  Future<void> createUser(AppUser user);
  Future<AppUser?> getUser(String uid);
  Stream<AppUser?> watchUser(String uid);
  Future<void> updateUser(String uid, Map<String, dynamic> data);
}
