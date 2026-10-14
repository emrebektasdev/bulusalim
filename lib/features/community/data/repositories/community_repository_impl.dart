import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bulusalim_app_01/core/firebase/firestore_dates.dart';

import 'package:bulusalim_app_01/core/firebase/firebase_paths.dart';
import '../../data/models/community.dart';
import '../../data/models/community_member.dart';
import '../../data/models/join_request.dart';
import '../../domain/repositories/community_repository.dart';

class CommunityRepositoryImpl implements CommunityRepository {
  final FirebaseFirestore _firestore;

  CommunityRepositoryImpl({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  CollectionReference<Community> get _communitiesRef => _firestore
      .collection(FirestorePaths.communities)
      .withConverter<Community>(
        fromFirestore: (snapshot, _) => Community.fromJson({
          'id': snapshot.id,
          ...decodeFirestoreDates(snapshot.data() ?? {}),
        }),
        toFirestore: (community, _) {
          final json = community.toJson();
          json.remove('id'); // ID is the document key
          if (json['createdAt'] == null) {
            json['createdAt'] = FieldValue.serverTimestamp();
          }
          return encodeFirestoreDates(json);
        },
      );

  CollectionReference<CommunityMember> _membersRef(String communityId) =>
      _firestore
          .collection('${FirestorePaths.communities}/$communityId/members')
          .withConverter<CommunityMember>(
            fromFirestore: (snapshot, _) => CommunityMember.fromJson(
              decodeFirestoreDates(snapshot.data()!),
            ),
            toFirestore: (member, _) {
              final json = member.toJson();
              if (json['joinedAt'] == null) {
                json['joinedAt'] = FieldValue.serverTimestamp();
              }
              return encodeFirestoreDates(json);
            },
          );

  CollectionReference<JoinRequest> _requestsRef(String communityId) =>
      _firestore
          .collection('${FirestorePaths.communities}/$communityId/joinRequests')
          .withConverter<JoinRequest>(
            fromFirestore: (snapshot, _) =>
                JoinRequest.fromJson(decodeFirestoreDates(snapshot.data()!)),
            toFirestore: (request, _) {
              final json = request.toJson();
              if (json['requestedAt'] == null) {
                json['requestedAt'] = FieldValue.serverTimestamp();
              }
              return encodeFirestoreDates(json);
            },
          );

  @override
  Future<Community> createCommunity({
    required String name,
    required String description,
    required String category,
    required bool isPrivate,
    String? coverImageUrl,
    required String currentUserId,
  }) async {
    final newDoc = _communitiesRef.doc();
    final community = Community(
      id: newDoc.id,
      name: name,
      description: description,
      category: category,
      ownerId: currentUserId,
      isPrivate: isPrivate,
      coverImageUrl: coverImageUrl,
      memberCount: 1, // the creator is automatically a member
    );

    final member = CommunityMember(
      uid: currentUserId,
      role: CommunityRole.owner,
    );

    // Use a batch to write both community and owner member doc
    final batch = _firestore.batch();
    batch.set(newDoc, community);
    batch.set(_membersRef(newDoc.id).doc(currentUserId), member);
    await batch.commit();

    return community;
  }

  @override
  Future<List<Community>> getCommunities({
    int limit = 20,
    Object? startAfterDocumentSnapshot,
    String? category,
  }) async {
    var query = _communitiesRef.where('isDeleted', isEqualTo: false);

    if (category != null && category.isNotEmpty && category != 'Genel') {
      query = query.where('category', isEqualTo: category);
    }

    query = query.orderBy('createdAt', descending: true).limit(limit);

    if (startAfterDocumentSnapshot != null &&
        startAfterDocumentSnapshot is DocumentSnapshot) {
      query = query.startAfterDocument(startAfterDocumentSnapshot);
    }

    final snapshot = await query.get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  @override
  Future<Community?> getCommunityById(String communityId) async {
    final doc = await _communitiesRef.doc(communityId).get();
    if (doc.exists && doc.data()?.isDeleted == false) {
      return doc.data();
    }
    return null;
  }

  @override
  Future<void> updateCoverImage(String communityId, String url) async {
    await _communitiesRef.doc(communityId).update({'coverImageUrl': url});
  }

  @override
  Future<void> joinCommunity({
    required String communityId,
    required String uid,
    required bool isPrivate,
  }) async {
    final communityDocRef = _communitiesRef.doc(communityId);
    final memberDocRef = _membersRef(communityId).doc(uid);
    final requestDocRef = _requestsRef(communityId).doc(uid);

    await _firestore.runTransaction((transaction) async {
      final communityDoc = await transaction.get(communityDocRef);
      if (!communityDoc.exists) {
        throw Exception('Community not found');
      }

      if (communityDoc.data()!.isPrivate) {
        // Private: Create a join request
        final requestDoc = await transaction.get(requestDocRef);
        if (requestDoc.data()?.status == RequestStatus.approved) {
          final memberDoc = await transaction.get(memberDocRef);
          if (!memberDoc.exists) {
            transaction.set(
              memberDocRef,
              CommunityMember(uid: uid, role: CommunityRole.member),
            );
            transaction.update(communityDocRef, {
              'memberCount': FieldValue.increment(1),
            });
          }
        } else if (!requestDoc.exists) {
          final newRequest = JoinRequest(
            uid: uid,
            status: RequestStatus.pending,
          );
          transaction.set(requestDocRef, newRequest);
        }
      } else {
        // Public: Add to members and increment
        final memberDoc = await transaction.get(memberDocRef);
        if (!memberDoc.exists) {
          final newMember = CommunityMember(
            uid: uid,
            role: CommunityRole.member,
          );
          transaction.set(memberDocRef, newMember);
          // Increment member count on the community safely
          // Cannot use standard increment with withConverter easily in transaction if we only want to update one field without overwriting.
          // Using standard update instead.
          transaction.update(communityDocRef, {
            'memberCount': FieldValue.increment(1),
          });
        }
      }
    });
  }

  @override
  Future<void> leaveCommunity({
    required String communityId,
    required String uid,
  }) async {
    final communityDocRef = _communitiesRef.doc(communityId);
    final memberDocRef = _membersRef(communityId).doc(uid);

    await _firestore.runTransaction((transaction) async {
      final memberDoc = await transaction.get(memberDocRef);
      if (memberDoc.exists) {
        final data = memberDoc.data();
        if (data?.role == CommunityRole.owner) {
          throw Exception(
            'Owner cannot leave the community. Transfer ownership or delete first.',
          );
        }

        transaction.delete(memberDocRef);
        transaction.update(communityDocRef, {
          'memberCount': FieldValue.increment(-1),
        });
      }
    });
  }

  @override
  Future<CommunityMember?> getMembership({
    required String communityId,
    required String uid,
  }) async {
    final doc = await _membersRef(communityId).doc(uid).get();
    return doc.data();
  }

  @override
  Future<JoinRequest?> getJoinRequest({
    required String communityId,
    required String uid,
  }) async {
    final doc = await _requestsRef(communityId).doc(uid).get();
    return doc.data();
  }
}
