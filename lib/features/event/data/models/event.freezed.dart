// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Event {

 String get id; String get title; String get description; String get organizerId; String? get communityId;// Null if standalone
 String? get coverImageUrl;@GeoPointConverter() GeoPoint? get location; String? get address; DateTime? get startDate; DateTime? get endDate; int? get capacity;// Null means unlimited
 int get attendeeCount;// Only counts those 'going'
 bool get isOnline; List<String> get tags; bool get isDeleted; DateTime? get createdAt;
/// Create a copy of Event
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventCopyWith<Event> get copyWith => _$EventCopyWithImpl<Event>(this as Event, _$identity);

  /// Serializes this Event to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Event&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.organizerId, organizerId) || other.organizerId == organizerId)&&(identical(other.communityId, communityId) || other.communityId == communityId)&&(identical(other.coverImageUrl, coverImageUrl) || other.coverImageUrl == coverImageUrl)&&(identical(other.location, location) || other.location == location)&&(identical(other.address, address) || other.address == address)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.capacity, capacity) || other.capacity == capacity)&&(identical(other.attendeeCount, attendeeCount) || other.attendeeCount == attendeeCount)&&(identical(other.isOnline, isOnline) || other.isOnline == isOnline)&&const DeepCollectionEquality().equals(other.tags, tags)&&(identical(other.isDeleted, isDeleted) || other.isDeleted == isDeleted)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,description,organizerId,communityId,coverImageUrl,location,address,startDate,endDate,capacity,attendeeCount,isOnline,const DeepCollectionEquality().hash(tags),isDeleted,createdAt);

@override
String toString() {
  return 'Event(id: $id, title: $title, description: $description, organizerId: $organizerId, communityId: $communityId, coverImageUrl: $coverImageUrl, location: $location, address: $address, startDate: $startDate, endDate: $endDate, capacity: $capacity, attendeeCount: $attendeeCount, isOnline: $isOnline, tags: $tags, isDeleted: $isDeleted, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $EventCopyWith<$Res>  {
  factory $EventCopyWith(Event value, $Res Function(Event) _then) = _$EventCopyWithImpl;
@useResult
$Res call({
 String id, String title, String description, String organizerId, String? communityId, String? coverImageUrl,@GeoPointConverter() GeoPoint? location, String? address, DateTime? startDate, DateTime? endDate, int? capacity, int attendeeCount, bool isOnline, List<String> tags, bool isDeleted, DateTime? createdAt
});




}
/// @nodoc
class _$EventCopyWithImpl<$Res>
    implements $EventCopyWith<$Res> {
  _$EventCopyWithImpl(this._self, this._then);

  final Event _self;
  final $Res Function(Event) _then;

/// Create a copy of Event
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? description = null,Object? organizerId = null,Object? communityId = freezed,Object? coverImageUrl = freezed,Object? location = freezed,Object? address = freezed,Object? startDate = freezed,Object? endDate = freezed,Object? capacity = freezed,Object? attendeeCount = null,Object? isOnline = null,Object? tags = null,Object? isDeleted = null,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,organizerId: null == organizerId ? _self.organizerId : organizerId // ignore: cast_nullable_to_non_nullable
as String,communityId: freezed == communityId ? _self.communityId : communityId // ignore: cast_nullable_to_non_nullable
as String?,coverImageUrl: freezed == coverImageUrl ? _self.coverImageUrl : coverImageUrl // ignore: cast_nullable_to_non_nullable
as String?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as GeoPoint?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime?,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime?,capacity: freezed == capacity ? _self.capacity : capacity // ignore: cast_nullable_to_non_nullable
as int?,attendeeCount: null == attendeeCount ? _self.attendeeCount : attendeeCount // ignore: cast_nullable_to_non_nullable
as int,isOnline: null == isOnline ? _self.isOnline : isOnline // ignore: cast_nullable_to_non_nullable
as bool,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,isDeleted: null == isDeleted ? _self.isDeleted : isDeleted // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [Event].
extension EventPatterns on Event {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Event value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Event() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Event value)  $default,){
final _that = this;
switch (_that) {
case _Event():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Event value)?  $default,){
final _that = this;
switch (_that) {
case _Event() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String description,  String organizerId,  String? communityId,  String? coverImageUrl, @GeoPointConverter()  GeoPoint? location,  String? address,  DateTime? startDate,  DateTime? endDate,  int? capacity,  int attendeeCount,  bool isOnline,  List<String> tags,  bool isDeleted,  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Event() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.organizerId,_that.communityId,_that.coverImageUrl,_that.location,_that.address,_that.startDate,_that.endDate,_that.capacity,_that.attendeeCount,_that.isOnline,_that.tags,_that.isDeleted,_that.createdAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String description,  String organizerId,  String? communityId,  String? coverImageUrl, @GeoPointConverter()  GeoPoint? location,  String? address,  DateTime? startDate,  DateTime? endDate,  int? capacity,  int attendeeCount,  bool isOnline,  List<String> tags,  bool isDeleted,  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _Event():
return $default(_that.id,_that.title,_that.description,_that.organizerId,_that.communityId,_that.coverImageUrl,_that.location,_that.address,_that.startDate,_that.endDate,_that.capacity,_that.attendeeCount,_that.isOnline,_that.tags,_that.isDeleted,_that.createdAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String description,  String organizerId,  String? communityId,  String? coverImageUrl, @GeoPointConverter()  GeoPoint? location,  String? address,  DateTime? startDate,  DateTime? endDate,  int? capacity,  int attendeeCount,  bool isOnline,  List<String> tags,  bool isDeleted,  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _Event() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.organizerId,_that.communityId,_that.coverImageUrl,_that.location,_that.address,_that.startDate,_that.endDate,_that.capacity,_that.attendeeCount,_that.isOnline,_that.tags,_that.isDeleted,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Event implements Event {
  const _Event({required this.id, required this.title, required this.description, required this.organizerId, this.communityId, this.coverImageUrl, @GeoPointConverter() this.location, this.address, this.startDate, this.endDate, this.capacity, this.attendeeCount = 0, this.isOnline = false, final  List<String> tags = const [], this.isDeleted = false, this.createdAt}): _tags = tags;
  factory _Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);

@override final  String id;
@override final  String title;
@override final  String description;
@override final  String organizerId;
@override final  String? communityId;
// Null if standalone
@override final  String? coverImageUrl;
@override@GeoPointConverter() final  GeoPoint? location;
@override final  String? address;
@override final  DateTime? startDate;
@override final  DateTime? endDate;
@override final  int? capacity;
// Null means unlimited
@override@JsonKey() final  int attendeeCount;
// Only counts those 'going'
@override@JsonKey() final  bool isOnline;
 final  List<String> _tags;
@override@JsonKey() List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}

@override@JsonKey() final  bool isDeleted;
@override final  DateTime? createdAt;

/// Create a copy of Event
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventCopyWith<_Event> get copyWith => __$EventCopyWithImpl<_Event>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EventToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Event&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.organizerId, organizerId) || other.organizerId == organizerId)&&(identical(other.communityId, communityId) || other.communityId == communityId)&&(identical(other.coverImageUrl, coverImageUrl) || other.coverImageUrl == coverImageUrl)&&(identical(other.location, location) || other.location == location)&&(identical(other.address, address) || other.address == address)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.capacity, capacity) || other.capacity == capacity)&&(identical(other.attendeeCount, attendeeCount) || other.attendeeCount == attendeeCount)&&(identical(other.isOnline, isOnline) || other.isOnline == isOnline)&&const DeepCollectionEquality().equals(other._tags, _tags)&&(identical(other.isDeleted, isDeleted) || other.isDeleted == isDeleted)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,description,organizerId,communityId,coverImageUrl,location,address,startDate,endDate,capacity,attendeeCount,isOnline,const DeepCollectionEquality().hash(_tags),isDeleted,createdAt);

@override
String toString() {
  return 'Event(id: $id, title: $title, description: $description, organizerId: $organizerId, communityId: $communityId, coverImageUrl: $coverImageUrl, location: $location, address: $address, startDate: $startDate, endDate: $endDate, capacity: $capacity, attendeeCount: $attendeeCount, isOnline: $isOnline, tags: $tags, isDeleted: $isDeleted, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$EventCopyWith<$Res> implements $EventCopyWith<$Res> {
  factory _$EventCopyWith(_Event value, $Res Function(_Event) _then) = __$EventCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String description, String organizerId, String? communityId, String? coverImageUrl,@GeoPointConverter() GeoPoint? location, String? address, DateTime? startDate, DateTime? endDate, int? capacity, int attendeeCount, bool isOnline, List<String> tags, bool isDeleted, DateTime? createdAt
});




}
/// @nodoc
class __$EventCopyWithImpl<$Res>
    implements _$EventCopyWith<$Res> {
  __$EventCopyWithImpl(this._self, this._then);

  final _Event _self;
  final $Res Function(_Event) _then;

/// Create a copy of Event
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? description = null,Object? organizerId = null,Object? communityId = freezed,Object? coverImageUrl = freezed,Object? location = freezed,Object? address = freezed,Object? startDate = freezed,Object? endDate = freezed,Object? capacity = freezed,Object? attendeeCount = null,Object? isOnline = null,Object? tags = null,Object? isDeleted = null,Object? createdAt = freezed,}) {
  return _then(_Event(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,organizerId: null == organizerId ? _self.organizerId : organizerId // ignore: cast_nullable_to_non_nullable
as String,communityId: freezed == communityId ? _self.communityId : communityId // ignore: cast_nullable_to_non_nullable
as String?,coverImageUrl: freezed == coverImageUrl ? _self.coverImageUrl : coverImageUrl // ignore: cast_nullable_to_non_nullable
as String?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as GeoPoint?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime?,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime?,capacity: freezed == capacity ? _self.capacity : capacity // ignore: cast_nullable_to_non_nullable
as int?,attendeeCount: null == attendeeCount ? _self.attendeeCount : attendeeCount // ignore: cast_nullable_to_non_nullable
as int,isOnline: null == isOnline ? _self.isOnline : isOnline // ignore: cast_nullable_to_non_nullable
as bool,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,isDeleted: null == isDeleted ? _self.isDeleted : isDeleted // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
