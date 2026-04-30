import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:bulusalim_app_01/features/community/presentation/providers/community_providers.dart';
import 'package:bulusalim_app_01/features/event/presentation/providers/event_providers.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventsAsync = ref.watch(homeEventsFeedProvider);
    final communitiesAsync = ref.watch(communitiesFeedProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Buluşalım'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => context.go('/explore'),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(homeEventsFeedProvider);
          ref.invalidate(communitiesFeedProvider);
        },
        child: CustomScrollView(
          slivers: [
            // Welcome Section
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Merhaba 👋',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.grey),
                    ),
                    const Text(
                      'Bugün ne yapmak istersin?',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),

            // Events Section
            const SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              sliver: SliverToBoxAdapter(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Yaklaşan Etkinlikler',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Icon(Icons.event_note, color: Colors.deepPurple),
                  ],
                ),
              ),
            ),
            
            eventsAsync.when(
              loading: () => const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(32.0),
                  child: Center(child: CircularProgressIndicator()),
                ),
              ),
              error: (err, _) => SliverToBoxAdapter(
                child: Center(child: Text('Hata: $err')),
              ),
              data: (events) {
                if (events.isEmpty) {
                  return SliverToBoxAdapter(
                    child: Container(
                      margin: const EdgeInsets.all(16),
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Column(
                        children: [
                          Icon(Icons.event_outlined, size: 48, color: Colors.grey),
                          SizedBox(height: 12),
                          Text(
                            'Henüz planlanmış bir etkinlik yok.',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final e = events[index];
                      final dateStr = e.startDate != null 
                          ? DateFormat('dd MMM, HH:mm').format(e.startDate!)
                          : 'Tarih Belirtilmemiş';

                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        elevation: 2,
                        shadowColor: Colors.black12,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        child: InkWell(
                          onTap: () => context.push('/event/${e.id}'),
                          borderRadius: BorderRadius.circular(16),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              children: [
                                if (e.coverImageUrl != null)
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: CachedNetworkImage(
                                      imageUrl: e.coverImageUrl!,
                                      width: 64,
                                      height: 64,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) => Container(
                                        width: 64, height: 64, color: Colors.grey[200],
                                      ),
                                      errorWidget: (context, url, err) => Container(
                                        width: 64, height: 64, color: Colors.deepPurple.shade50,
                                        child: const Icon(Icons.event, color: Colors.deepPurple),
                                      ),
                                    ),
                                  )
                                else
                                  Container(
                                    width: 64,
                                    height: 64,
                                    decoration: BoxDecoration(
                                      color: Colors.deepPurple.shade50,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: const Icon(Icons.calendar_today, color: Colors.deepPurple),
                                  ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        e.title,
                                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        dateStr,
                                        style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.w500),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        '${e.attendeeCount} katılımcı',
                                        style: const TextStyle(color: Colors.grey, fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                                const Icon(Icons.chevron_right, color: Colors.grey),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    childCount: events.length,
                  ),
                );
              },
            ),

            // Communities Section
            const SliverPadding(
              padding: EdgeInsets.fromLTRB(16, 24, 16, 8),
              sliver: SliverToBoxAdapter(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Popüler Topluluklar',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Icon(Icons.groups, color: Colors.blueGrey),
                  ],
                ),
              ),
            ),

            communitiesAsync.when(
              loading: () => const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(32.0),
                  child: Center(child: CircularProgressIndicator()),
                ),
              ),
              error: (err, _) => SliverToBoxAdapter(
                child: Center(child: Text('Hata: $err')),
              ),
              data: (communities) {
                if (communities.isEmpty) {
                  return const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.all(32.0),
                      child: Center(child: Text('Topluluk bulunamadı.')),
                    ),
                  );
                }
                final preview = communities.take(5).toList();
                return SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  sliver: SliverGrid(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 1.5,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final c = preview[index];
                        return Card(
                          margin: EdgeInsets.zero,
                          elevation: 0,
                          clipBehavior: Clip.antiAlias,
                          color: Theme.of(context).colorScheme.secondaryContainer.withOpacity(0.3),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          child: InkWell(
                            onTap: () => context.push('/community/${c.id}'),
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                if (c.coverImageUrl != null)
                                  CachedNetworkImage(
                                    imageUrl: c.coverImageUrl!,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => Container(color: Colors.grey[200]),
                                    errorWidget: (context, url, err) => Container(color: Colors.grey[300]),
                                  ),
                                if (c.coverImageUrl != null)
                                  Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [Colors.black54, Colors.transparent],
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.topCenter,
                                      ),
                                    ),
                                  ),
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        c.name,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: c.coverImageUrl != null ? Colors.white : null,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        '${c.memberCount} Üye',
                                        style: TextStyle(
                                          fontSize: 12, 
                                          color: c.coverImageUrl != null ? Colors.white70 : Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      childCount: preview.length,
                    ),
                  ),
                );
              },
            ),
            
            const SliverPadding(padding: EdgeInsets.only(bottom: 40)),
          ],
        ),
      ),
    );
  }
}

