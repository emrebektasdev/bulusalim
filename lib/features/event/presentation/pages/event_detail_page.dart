import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:bulusalim_app_01/features/event/data/models/event_attendee.dart';
import 'package:bulusalim_app_01/features/event/presentation/providers/event_detail_provider.dart';
import 'package:bulusalim_app_01/features/event/presentation/providers/event_providers.dart';

class EventDetailPage extends ConsumerWidget {
  final String eventId;
  const EventDetailPage({super.key, required this.eventId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventAsync = ref.watch(eventDetailProvider(eventId));
    final attendeeAsync = ref.watch(currentEventAttendeeProvider(eventId));
    final isUpdating = ref.watch(eventRsvpControllerProvider).isLoading;

    return Scaffold(
      appBar: AppBar(title: const Text('Etkinlik Detayı')),
      body: eventAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Hata: $e')),
        data: (event) {
          if (event == null) {
            return const Center(child: Text('Etkinlik bulunamadı veya silinmiş.'));
          }

          final attendeeStatus = attendeeAsync.value?.status;
          final dateFormat = DateFormat('dd MMM yyyy, HH:mm');
          final startDateStr = event.startDate != null ? dateFormat.format(event.startDate!) : 'Bilinmiyor';
          final endDateStr = event.endDate != null ? dateFormat.format(event.endDate!) : '';

          // Determine if "Going" is disabled due to capacity
          final isFull = event.capacity != null && event.attendeeCount >= event.capacity!;
          final canGo = !isFull || attendeeStatus == RsvpStatus.going;

          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(eventDetailProvider(eventId));
              ref.invalidate(currentEventAttendeeProvider(eventId));
            },
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // Header Image
                if (event.coverImageUrl != null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CachedNetworkImage(
                      imageUrl: event.coverImageUrl!,
                      height: 180,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        height: 180,
                        color: Colors.grey[200],
                        alignment: Alignment.center,
                        child: const CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, err) => Container(
                        height: 180,
                        color: Colors.deepPurple.shade100,
                        child: const Icon(Icons.event_available, size: 80, color: Colors.deepPurple),
                      ),
                    ),
                  )
                else
                  Container(
                    height: 180,
                    decoration: BoxDecoration(
                      color: Colors.deepPurple.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Icon(Icons.event_available, size: 80, color: Colors.deepPurple),
                    ),
                  ),
                const SizedBox(height: 16),
                
                Text(
                  event.title,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),

                Row(
                  children: [
                    const Icon(Icons.access_time, size: 20, color: Colors.grey),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        endDateStr.isEmpty ? startDateStr : '$startDateStr - $endDateStr',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      event.isOnline ? Icons.video_call : Icons.location_on, 
                      size: 20, 
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        event.address ?? (event.isOnline ? 'Online' : 'Konum Belirtilmemiş'),
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Capacity / Attendees info
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Katılımcılar: ${event.attendeeCount}${event.capacity != null ? ' / ${event.capacity}' : ''}',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    if (isFull)
                      const Chip(
                        label: Text('Dolu'),
                        backgroundColor: Colors.redAccent,
                        labelStyle: TextStyle(color: Colors.white),
                      )
                  ],
                ),
                const Divider(height: 32),

                const Text(
                  'Detaylar',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  event.description,
                  style: const TextStyle(fontSize: 16, height: 1.5),
                ),

                const SizedBox(height: 32),

                // RSVP Section
                const Text(
                  'Katılım Durumun',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                if (isUpdating)
                  const Center(child: CircularProgressIndicator())
                else
                  SegmentedButton<RsvpStatus>(
                    segments: [
                      ButtonSegment<RsvpStatus>(
                        value: RsvpStatus.going,
                        label: const Text('Gidiyorum'),
                        icon: const Icon(Icons.check_circle),
                        enabled: canGo,
                      ),
                      const ButtonSegment<RsvpStatus>(
                        value: RsvpStatus.interested,
                        label: Text('İlgileniyorum'),
                        icon: Icon(Icons.star),
                      ),
                      const ButtonSegment<RsvpStatus>(
                        value: RsvpStatus.not_going,
                        label: Text('Katılmıyorum'),
                        icon: Icon(Icons.cancel),
                      ),
                    ],
                    selected: {attendeeStatus ?? RsvpStatus.not_going}, // default to not_going if null
                    onSelectionChanged: (Set<RsvpStatus> newSelection) {
                      final status = newSelection.first;
                      ref.read(eventRsvpControllerProvider.notifier).updateRsvp(event, status);
                    },
                    multiSelectionEnabled: false,
                  ),

                const SizedBox(height: 48),
              ],
            ),
          );
        },
      ),
    );
  }
}

