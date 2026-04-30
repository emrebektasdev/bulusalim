import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/models/community.dart';
import '../../data/models/community_member.dart';
import '../../data/models/join_request.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import 'community_providers.dart';

part 'community_detail_provider.g.dart';

@riverpod
Future<Community?> communityDetail(Ref ref, String communityId) async {
  final repo = ref.watch(communityRepositoryProvider);
  return repo.getCommunityById(communityId);
}

/// Checks if the current user is a member of the given community
@riverpod
Future<CommunityMember?> currentMembership(Ref ref, String communityId) async {
  final user = ref.watch(currentUserProvider);
  if (user == null) return null;

  final repo = ref.watch(communityRepositoryProvider);
  return repo.getMembership(communityId: communityId, uid: user.uid);
}

/// Checks if the current user has a pending join request for the given private community
@riverpod
Future<JoinRequest?> currentJoinRequest(Ref ref, String communityId) async {
  final user = ref.watch(currentUserProvider);
  if (user == null) return null;

  final repo = ref.watch(communityRepositoryProvider);
  return repo.getJoinRequest(communityId: communityId, uid: user.uid);
}
