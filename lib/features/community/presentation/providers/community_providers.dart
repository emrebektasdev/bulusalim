import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/repositories/community_repository_impl.dart';
import '../../domain/repositories/community_repository.dart';
import '../../data/models/community.dart';
import '../../../auth/presentation/providers/auth_providers.dart';

part 'community_providers.g.dart';

@riverpod
CommunityRepository communityRepository(Ref ref) {
  return CommunityRepositoryImpl(); // Could pass firestore instance here if we wanted to mock
}

@riverpod
class CommunitySearchQuery extends _$CommunitySearchQuery {
  @override
  String build() => '';
  void setQuery(String query) => state = query;
}

@riverpod
class CommunityCategoryFilter extends _$CommunityCategoryFilter {
  @override
  String build() => 'Genel';
  void setCategory(String category) => state = category;
}

/// A dynamic feed provider that responds to search and category filters
@riverpod
Future<List<Community>> communitiesFeed(Ref ref) async {
  final repo = ref.watch(communityRepositoryProvider);
  final category = ref.watch(communityCategoryFilterProvider);
  final searchQuery = ref.watch(communitySearchQueryProvider).toLowerCase();

  final communities = await repo.getCommunities(category: category, limit: 100);

  if (searchQuery.isEmpty) return communities;

  // Simple in-memory filter for the search placeholder
  return communities.where((c) {
    return c.name.toLowerCase().contains(searchQuery) ||
           c.description.toLowerCase().contains(searchQuery);
  }).toList();
}

/// A controller to handle join/leave actions from the UI
@riverpod
class CommunityJoinController extends _$CommunityJoinController {
  @override
  FutureOr<void> build() {}

  Future<void> joinCommunity(Community community) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final user = ref.read(currentUserProvider);
      if (user == null) throw Exception('User not logged in');

      final repo = ref.read(communityRepositoryProvider);
      await repo.joinCommunity(
        communityId: community.id,
        uid: user.uid,
        isPrivate: community.isPrivate,
      );
      
      // Invalidate the specific community detail provider if it exists
      // so the UI refreshes immediately
    });
  }

  Future<void> leaveCommunity(String communityId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final user = ref.read(currentUserProvider);
      if (user == null) throw Exception('User not logged in');

      final repo = ref.read(communityRepositoryProvider);
      await repo.leaveCommunity(
        communityId: communityId,
        uid: user.uid,
      );
    });
  }
}
