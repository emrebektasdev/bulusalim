import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/errors/firebase_exception_mapper.dart';
import '../../../../core/firebase/app_logger.dart';
import '../../../../core/firebase/firebase_paths.dart';
import '../../domain/repositories/user_repository.dart';
import '../models/app_user.dart';

part 'user_repository_impl.g.dart';

@riverpod
UserRepository userRepository(Ref ref) => UserRepositoryImpl();

/// Firebase Firestore implementation of [UserRepository].
class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl() : _db = FirebaseFirestore.instance;

  final FirebaseFirestore _db;
  static final _log = AppLogger.getLogger('UserRepository');

  CollectionReference<AppUser> get _users => _db
      .collection(FirestorePaths.users)
      .withConverter<AppUser>(
        fromFirestore: (snap, _) => AppUser.fromJson(snap.data()!..['uid'] = snap.id),
        toFirestore: (user, _) => user.toJson(),
      );

  @override
  Future<void> createUser(AppUser user) async {
    try {
      await _users.doc(user.uid).set(user);
    } catch (e) {
      _log.warning('createUser failed', e);
      throw mapFirebaseException(e);
    }
  }

  @override
  Future<AppUser?> getUser(String uid) async {
    try {
      final snap = await _users.doc(uid).get();
      return snap.data();
    } catch (e) {
      _log.warning('getUser failed: $uid', e);
      throw mapFirebaseException(e);
    }
  }

  @override
  Stream<AppUser?> watchUser(String uid) {
    return _users.doc(uid).snapshots().map((snap) => snap.data());
  }

  @override
  Future<void> updateUser(String uid, Map<String, dynamic> data) async {
    try {
      await _db.doc(FirestorePaths.userDoc(uid)).update(data);
    } catch (e) {
      _log.warning('updateUser failed: $uid', e);
      throw mapFirebaseException(e);
    }
  }
}
