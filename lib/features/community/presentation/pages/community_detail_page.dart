import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../providers/community_providers.dart';
import '../providers/community_detail_provider.dart';
import '../../data/models/community_member.dart';
import '../../data/models/join_request.dart';
import 'package:bulusalim_app_01/features/event/presentation/providers/event_providers.dart';

class CommunityDetailPage extends ConsumerWidget {
  final String communityId;
  const CommunityDetailPage({super.key, required this.communityId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailAsync = ref.watch(communityDetailProvider(communityId));
    final memberAsync = ref.watch(currentMembershipProvider(communityId));
    final requestAsync = ref.watch(currentJoinRequestProvider(communityId));

    return Scaffold(
      appBar: AppBar(title: const Text('Topluluk Detayları')),
      body: detailAsync.when(
        data: (community) {
          if (community == null) {
            return const Center(child: Text('Topluluk bulunamadı.'));
          }

          final membership = memberAsync.value;
          final joinRequest = requestAsync.value;
          final isJoining = ref.watch(communityJoinControllerProvider).isLoading;

          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(communityDetailProvider(communityId));
              ref.invalidate(currentMembershipProvider(communityId));
              ref.invalidate(currentJoinRequestProvider(communityId));
            },
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                if (community.coverImageUrl != null)
                  CachedNetworkImage(
                    imageUrl: community.coverImageUrl!,
                    height: 200,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      height: 200,
                      color: Colors.grey[200],
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) => Container(
                      height: 200,
                      color: Colors.grey[300],
                      child: const Icon(Icons.error),
                    ),
                  ),
                const SizedBox(height: 16),
                Text(
                  community.name,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Text(
                  '${community.memberCount} Üye • ${community.category}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
                if (community.isPrivate)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      children: [
                        Icon(Icons.lock, size: 16, color: Colors.grey),
                        SizedBox(width: 4),
                        Text('Gizli Topluluk', style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ),
                const SizedBox(height: 24),
                Text(
                  'Hakkında',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(community.description),
                const SizedBox(height: 32),
                
                // Action Button Logic
                if (membership != null) ...[
                  if (membership.role == CommunityRole.owner) ...[
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
                      onPressed: () {},
                      child: const Text('Topluluğu Yönet (Yakında)'),
                    ),
                    const SizedBox(height: 8),
                    OutlinedButton.icon(
                      icon: const Icon(Icons.add),
                      onPressed: () => context.push('/create-event?communityId=$communityId'),
                      label: const Text('Topluluk Etkinliği Oluştur'),
                    ),
                  ] else
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red[50],
                        foregroundColor: Colors.red,
                      ),
                      onPressed: isJoining ? null : () {
                        ref.read(communityJoinControllerProvider.notifier).leaveCommunity(communityId).then((_) {
                           ref.invalidate(currentMembershipProvider(communityId));
                           ref.invalidate(communityDetailProvider(communityId));
                        });
                      },
                      child: isJoining ? const CircularProgressIndicator() : const Text('Topluluktan Çık'),
                    ),

                  const SizedBox(height: 32),
                  const Text('Yaklaşan Etkinlikler', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  
                  ref.watch(communityEventsFeedProvider(communityId)).when(
                    loading: () => const Center(child: CircularProgressIndicator()),
                    error: (e, st) => Center(child: Text('Hata: $e')),
                    data: (events) {
                      if (events.isEmpty) {
                        return const Center(child: Text('Bu toplulukta henüz etkinlik yok.'));
                      }
                      return Column(
                        children: events.map((e) {
                          // TODO: import DateFormat from intl, but for now just show title
                          return Card(
                            margin: const EdgeInsets.only(bottom: 8),
                            child: ListTile(
                              leading: const Icon(Icons.event, color: Colors.deepPurple),
                              title: Text(e.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                              subtitle: Text('${e.attendeeCount} Kişi Katılıyor'),
                              trailing: const Icon(Icons.chevron_right),
                              onTap: () => context.push('/event/${e.id}'),
                            ),
                          );
                        }).toList(),
                      );
                    },
                  ),
                  const SizedBox(height: 32),
                  
                ] else if (community.isPrivate && joinRequest != null) ...[
                  ElevatedButton(
                    onPressed: null, // Disabled when pending
                    child: Text(joinRequest.status == RequestStatus.pending ? 'İstek Gönderildi' : 'İstek Bekliyor'),
                  ),
                ] else ...[
                  ElevatedButton(
                    onPressed: isJoining ? null : () {
                      ref.read(communityJoinControllerProvider.notifier).joinCommunity(community).then((_) {
                         ref.invalidate(currentMembershipProvider(communityId));
                         ref.invalidate(currentJoinRequestProvider(communityId));
                         ref.invalidate(communityDetailProvider(communityId));
                      });
                    },
                    child: isJoining ? const CircularProgressIndicator() : Text(community.isPrivate ? 'Katılma İsteği Gönder' : 'Katıl'),
                  ),
                ],
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Hata: $err')),
      ),
    );
  }
}
