// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event_attendee.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EventAttendee {

 String get uid; RsvpStatus get status; DateTime? get joinedAt;
/// Create a copy of EventAttendee
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventAttendeeCopyWith<EventAttendee> get copyWith => _$EventAttendeeCopyWithImpl<EventAttendee>(this as EventAttendee, _$identity);

  /// Serializes this EventAttendee to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventAttendee&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.status, status) || other.status == status)&&(identical(other.joinedAt, joinedAt) || other.joinedAt == joinedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,uid,status,joinedAt);

@override
String toString() {
  return 'EventAttendee(uid: $uid, status: $status, joinedAt: $joinedAt)';
}


}

/// @nodoc
abstract mixin class $EventAttendeeCopyWith<$Res>  {
  factory $EventAttendeeCopyWith(EventAttendee value, $Res Function(EventAttendee) _then) = _$EventAttendeeCopyWithImpl;
@useResult
$Res call({
 String uid, RsvpStatus status, DateTime? joinedAt
});




}
/// @nodoc
class _$EventAttendeeCopyWithImpl<$Res>
    implements $EventAttendeeCopyWith<$Res> {
  _$EventAttendeeCopyWithImpl(this._self, this._then);

  final EventAttendee _self;
  final $Res Function(EventAttendee) _then;

/// Create a copy of EventAttendee
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? uid = null,Object? status = null,Object? joinedAt = freezed,}) {
  return _then(_self.copyWith(
uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RsvpStatus,joinedAt: freezed == joinedAt ? _self.joinedAt : joinedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [EventAttendee].
extension EventAttendeePatterns on EventAttendee {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EventAttendee value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EventAttendee() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EventAttendee value)  $default,){
final _that = this;
switch (_that) {
case _EventAttendee():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EventAttendee value)?  $default,){
final _that = this;
switch (_that) {
case _EventAttendee() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String uid,  RsvpStatus status,  DateTime? joinedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EventAttendee() when $default != null:
return $default(_that.uid,_that.status,_that.joinedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String uid,  RsvpStatus status,  DateTime? joinedAt)  $default,) {final _that = this;
switch (_that) {
case _EventAttendee():
return $default(_that.uid,_that.status,_that.joinedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String uid,  RsvpStatus status,  DateTime? joinedAt)?  $default,) {final _that = this;
switch (_that) {
case _EventAttendee() when $default != null:
return $default(_that.uid,_that.status,_that.joinedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EventAttendee implements EventAttendee {
  const _EventAttendee({required this.uid, required this.status, this.joinedAt});
  factory _EventAttendee.fromJson(Map<String, dynamic> json) => _$EventAttendeeFromJson(json);

@override final  String uid;
@override final  RsvpStatus status;
@override final  DateTime? joinedAt;

/// Create a copy of EventAttendee
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventAttendeeCopyWith<_EventAttendee> get copyWith => __$EventAttendeeCopyWithImpl<_EventAttendee>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EventAttendeeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventAttendee&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.status, status) || other.status == status)&&(identical(other.joinedAt, joinedAt) || other.joinedAt == joinedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,uid,status,joinedAt);

@override
String toString() {
  return 'EventAttendee(uid: $uid, status: $status, joinedAt: $joinedAt)';
}


}

/// @nodoc
abstract mixin class _$EventAttendeeCopyWith<$Res> implements $EventAttendeeCopyWith<$Res> {
  factory _$EventAttendeeCopyWith(_EventAttendee value, $Res Function(_EventAttendee) _then) = __$EventAttendeeCopyWithImpl;
@override @useResult
$Res call({
 String uid, RsvpStatus status, DateTime? joinedAt
});




}
/// @nodoc
class __$EventAttendeeCopyWithImpl<$Res>
    implements _$EventAttendeeCopyWith<$Res> {
  __$EventAttendeeCopyWithImpl(this._self, this._then);

  final _EventAttendee _self;
  final $Res Function(_EventAttendee) _then;

/// Create a copy of EventAttendee
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? uid = null,Object? status = null,Object? joinedAt = freezed,}) {
  return _then(_EventAttendee(
uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RsvpStatus,joinedAt: freezed == joinedAt ? _self.joinedAt : joinedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
