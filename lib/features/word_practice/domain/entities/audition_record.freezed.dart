// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'audition_record.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AuditionRecord {

 int? get id; int get correctWordId; int? get selectedWordId; String? get userId; bool get isCorrect; DateTime? get createdAt;
/// Create a copy of AuditionRecord
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuditionRecordCopyWith<AuditionRecord> get copyWith => _$AuditionRecordCopyWithImpl<AuditionRecord>(this as AuditionRecord, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuditionRecord&&(identical(other.id, id) || other.id == id)&&(identical(other.correctWordId, correctWordId) || other.correctWordId == correctWordId)&&(identical(other.selectedWordId, selectedWordId) || other.selectedWordId == selectedWordId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.isCorrect, isCorrect) || other.isCorrect == isCorrect)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,correctWordId,selectedWordId,userId,isCorrect,createdAt);

@override
String toString() {
  return 'AuditionRecord(id: $id, correctWordId: $correctWordId, selectedWordId: $selectedWordId, userId: $userId, isCorrect: $isCorrect, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $AuditionRecordCopyWith<$Res>  {
  factory $AuditionRecordCopyWith(AuditionRecord value, $Res Function(AuditionRecord) _then) = _$AuditionRecordCopyWithImpl;
@useResult
$Res call({
 int? id, int correctWordId, int? selectedWordId, String? userId, bool isCorrect, DateTime? createdAt
});




}
/// @nodoc
class _$AuditionRecordCopyWithImpl<$Res>
    implements $AuditionRecordCopyWith<$Res> {
  _$AuditionRecordCopyWithImpl(this._self, this._then);

  final AuditionRecord _self;
  final $Res Function(AuditionRecord) _then;

/// Create a copy of AuditionRecord
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? correctWordId = null,Object? selectedWordId = freezed,Object? userId = freezed,Object? isCorrect = null,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,correctWordId: null == correctWordId ? _self.correctWordId : correctWordId // ignore: cast_nullable_to_non_nullable
as int,selectedWordId: freezed == selectedWordId ? _self.selectedWordId : selectedWordId // ignore: cast_nullable_to_non_nullable
as int?,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,isCorrect: null == isCorrect ? _self.isCorrect : isCorrect // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [AuditionRecord].
extension AuditionRecordPatterns on AuditionRecord {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AuditionRecord value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AuditionRecord() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AuditionRecord value)  $default,){
final _that = this;
switch (_that) {
case _AuditionRecord():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AuditionRecord value)?  $default,){
final _that = this;
switch (_that) {
case _AuditionRecord() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  int correctWordId,  int? selectedWordId,  String? userId,  bool isCorrect,  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AuditionRecord() when $default != null:
return $default(_that.id,_that.correctWordId,_that.selectedWordId,_that.userId,_that.isCorrect,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  int correctWordId,  int? selectedWordId,  String? userId,  bool isCorrect,  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _AuditionRecord():
return $default(_that.id,_that.correctWordId,_that.selectedWordId,_that.userId,_that.isCorrect,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  int correctWordId,  int? selectedWordId,  String? userId,  bool isCorrect,  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _AuditionRecord() when $default != null:
return $default(_that.id,_that.correctWordId,_that.selectedWordId,_that.userId,_that.isCorrect,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc


class _AuditionRecord implements AuditionRecord {
  const _AuditionRecord({this.id, required this.correctWordId, this.selectedWordId, this.userId, required this.isCorrect, this.createdAt});
  

@override final  int? id;
@override final  int correctWordId;
@override final  int? selectedWordId;
@override final  String? userId;
@override final  bool isCorrect;
@override final  DateTime? createdAt;

/// Create a copy of AuditionRecord
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuditionRecordCopyWith<_AuditionRecord> get copyWith => __$AuditionRecordCopyWithImpl<_AuditionRecord>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuditionRecord&&(identical(other.id, id) || other.id == id)&&(identical(other.correctWordId, correctWordId) || other.correctWordId == correctWordId)&&(identical(other.selectedWordId, selectedWordId) || other.selectedWordId == selectedWordId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.isCorrect, isCorrect) || other.isCorrect == isCorrect)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,correctWordId,selectedWordId,userId,isCorrect,createdAt);

@override
String toString() {
  return 'AuditionRecord(id: $id, correctWordId: $correctWordId, selectedWordId: $selectedWordId, userId: $userId, isCorrect: $isCorrect, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$AuditionRecordCopyWith<$Res> implements $AuditionRecordCopyWith<$Res> {
  factory _$AuditionRecordCopyWith(_AuditionRecord value, $Res Function(_AuditionRecord) _then) = __$AuditionRecordCopyWithImpl;
@override @useResult
$Res call({
 int? id, int correctWordId, int? selectedWordId, String? userId, bool isCorrect, DateTime? createdAt
});




}
/// @nodoc
class __$AuditionRecordCopyWithImpl<$Res>
    implements _$AuditionRecordCopyWith<$Res> {
  __$AuditionRecordCopyWithImpl(this._self, this._then);

  final _AuditionRecord _self;
  final $Res Function(_AuditionRecord) _then;

/// Create a copy of AuditionRecord
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? correctWordId = null,Object? selectedWordId = freezed,Object? userId = freezed,Object? isCorrect = null,Object? createdAt = freezed,}) {
  return _then(_AuditionRecord(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,correctWordId: null == correctWordId ? _self.correctWordId : correctWordId // ignore: cast_nullable_to_non_nullable
as int,selectedWordId: freezed == selectedWordId ? _self.selectedWordId : selectedWordId // ignore: cast_nullable_to_non_nullable
as int?,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,isCorrect: null == isCorrect ? _self.isCorrect : isCorrect // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
