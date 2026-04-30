// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'community_member.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CommunityMember {

 String get uid; CommunityRole get role; DateTime? get joinedAt;
/// Create a copy of CommunityMember
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommunityMemberCopyWith<CommunityMember> get copyWith => _$CommunityMemberCopyWithImpl<CommunityMember>(this as CommunityMember, _$identity);

  /// Serializes this CommunityMember to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommunityMember&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.role, role) || other.role == role)&&(identical(other.joinedAt, joinedAt) || other.joinedAt == joinedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,uid,role,joinedAt);

@override
String toString() {
  return 'CommunityMember(uid: $uid, role: $role, joinedAt: $joinedAt)';
}


}

/// @nodoc
abstract mixin class $CommunityMemberCopyWith<$Res>  {
  factory $CommunityMemberCopyWith(CommunityMember value, $Res Function(CommunityMember) _then) = _$CommunityMemberCopyWithImpl;
@useResult
$Res call({
 String uid, CommunityRole role, DateTime? joinedAt
});




}
/// @nodoc
class _$CommunityMemberCopyWithImpl<$Res>
    implements $CommunityMemberCopyWith<$Res> {
  _$CommunityMemberCopyWithImpl(this._self, this._then);

  final CommunityMember _self;
  final $Res Function(CommunityMember) _then;

/// Create a copy of CommunityMember
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? uid = null,Object? role = null,Object? joinedAt = freezed,}) {
  return _then(_self.copyWith(
uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as CommunityRole,joinedAt: freezed == joinedAt ? _self.joinedAt : joinedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [CommunityMember].
extension CommunityMemberPatterns on CommunityMember {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CommunityMember value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CommunityMember() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CommunityMember value)  $default,){
final _that = this;
switch (_that) {
case _CommunityMember():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CommunityMember value)?  $default,){
final _that = this;
switch (_that) {
case _CommunityMember() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String uid,  CommunityRole role,  DateTime? joinedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CommunityMember() when $default != null:
return $default(_that.uid,_that.role,_that.joinedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String uid,  CommunityRole role,  DateTime? joinedAt)  $default,) {final _that = this;
switch (_that) {
case _CommunityMember():
return $default(_that.uid,_that.role,_that.joinedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String uid,  CommunityRole role,  DateTime? joinedAt)?  $default,) {final _that = this;
switch (_that) {
case _CommunityMember() when $default != null:
return $default(_that.uid,_that.role,_that.joinedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CommunityMember implements CommunityMember {
  const _CommunityMember({required this.uid, required this.role, this.joinedAt});
  factory _CommunityMember.fromJson(Map<String, dynamic> json) => _$CommunityMemberFromJson(json);

@override final  String uid;
@override final  CommunityRole role;
@override final  DateTime? joinedAt;

/// Create a copy of CommunityMember
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CommunityMemberCopyWith<_CommunityMember> get copyWith => __$CommunityMemberCopyWithImpl<_CommunityMember>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CommunityMemberToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CommunityMember&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.role, role) || other.role == role)&&(identical(other.joinedAt, joinedAt) || other.joinedAt == joinedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,uid,role,joinedAt);

@override
String toString() {
  return 'CommunityMember(uid: $uid, role: $role, joinedAt: $joinedAt)';
}


}

/// @nodoc
abstract mixin class _$CommunityMemberCopyWith<$Res> implements $CommunityMemberCopyWith<$Res> {
  factory _$CommunityMemberCopyWith(_CommunityMember value, $Res Function(_CommunityMember) _then) = __$CommunityMemberCopyWithImpl;
@override @useResult
$Res call({
 String uid, CommunityRole role, DateTime? joinedAt
});




}
/// @nodoc
class __$CommunityMemberCopyWithImpl<$Res>
    implements _$CommunityMemberCopyWith<$Res> {
  __$CommunityMemberCopyWithImpl(this._self, this._then);

  final _CommunityMember _self;
  final $Res Function(_CommunityMember) _then;

/// Create a copy of CommunityMember
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? uid = null,Object? role = null,Object? joinedAt = freezed,}) {
  return _then(_CommunityMember(
uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as CommunityRole,joinedAt: freezed == joinedAt ? _self.joinedAt : joinedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
