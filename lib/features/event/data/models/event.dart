import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:bulusalim_app_01/core/firebase/geo_point_converter.dart';

part 'event.freezed.dart';
part 'event.g.dart';

/// Represents a standalone or community-linked Event in Firestore `events/{eventId}`
@freezed
abstract class Event with _$Event {
  const factory Event({
    required String id,
    required String title,
    required String description,
    required String organizerId,
    String? communityId, // Null if standalone
    String? coverImageUrl,
    
    @GeoPointConverter() GeoPoint? location,
    String? address,
    
    DateTime? startDate,
    DateTime? endDate,

    int? capacity, // Null means unlimited
    @Default(0) int attendeeCount, // Only counts those 'going'
    
    @Default(false) bool isOnline,
    @Default([]) List<String> tags,
    @Default(false) bool isDeleted,
    DateTime? createdAt,
  }) = _Event;

  factory Event.fromJson(Map<String, dynamic> json) =>
      _$EventFromJson(json);
}
