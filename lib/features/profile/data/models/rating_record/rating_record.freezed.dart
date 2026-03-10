// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rating_record.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RatingRecord {

 int get id;@JsonKey(name: 'correct_word_id') int get correctWordId;@JsonKey(name: 'user_answer') String? get userAnswer;@JsonKey(name: 'user_id') String get userId;@JsonKey(name: 'is_correct') bool get isCorrect;@JsonKey(name: 'created_at') DateTime get createdAt;
/// Create a copy of RatingRecord
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RatingRecordCopyWith<RatingRecord> get copyWith => _$RatingRecordCopyWithImpl<RatingRecord>(this as RatingRecord, _$identity);

  /// Serializes this RatingRecord to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RatingRecord&&(identical(other.id, id) || other.id == id)&&(identical(other.correctWordId, correctWordId) || other.correctWordId == correctWordId)&&(identical(other.userAnswer, userAnswer) || other.userAnswer == userAnswer)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.isCorrect, isCorrect) || other.isCorrect == isCorrect)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,correctWordId,userAnswer,userId,isCorrect,createdAt);

@override
String toString() {
  return 'RatingRecord(id: $id, correctWordId: $correctWordId, userAnswer: $userAnswer, userId: $userId, isCorrect: $isCorrect, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $RatingRecordCopyWith<$Res>  {
  factory $RatingRecordCopyWith(RatingRecord value, $Res Function(RatingRecord) _then) = _$RatingRecordCopyWithImpl;
@useResult
$Res call({
 int id,@JsonKey(name: 'correct_word_id') int correctWordId,@JsonKey(name: 'user_answer') String? userAnswer,@JsonKey(name: 'user_id') String userId,@JsonKey(name: 'is_correct') bool isCorrect,@JsonKey(name: 'created_at') DateTime createdAt
});




}
/// @nodoc
class _$RatingRecordCopyWithImpl<$Res>
    implements $RatingRecordCopyWith<$Res> {
  _$RatingRecordCopyWithImpl(this._self, this._then);

  final RatingRecord _self;
  final $Res Function(RatingRecord) _then;

/// Create a copy of RatingRecord
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? correctWordId = null,Object? userAnswer = freezed,Object? userId = null,Object? isCorrect = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,correctWordId: null == correctWordId ? _self.correctWordId : correctWordId // ignore: cast_nullable_to_non_nullable
as int,userAnswer: freezed == userAnswer ? _self.userAnswer : userAnswer // ignore: cast_nullable_to_non_nullable
as String?,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,isCorrect: null == isCorrect ? _self.isCorrect : isCorrect // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [RatingRecord].
extension RatingRecordPatterns on RatingRecord {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RatingRecord value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RatingRecord() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RatingRecord value)  $default,){
final _that = this;
switch (_that) {
case _RatingRecord():
return $default(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RatingRecord value)?  $default,){
final _that = this;
switch (_that) {
case _RatingRecord() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'correct_word_id')  int correctWordId, @JsonKey(name: 'user_answer')  String? userAnswer, @JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'is_correct')  bool isCorrect, @JsonKey(name: 'created_at')  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RatingRecord() when $default != null:
return $default(_that.id,_that.correctWordId,_that.userAnswer,_that.userId,_that.isCorrect,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'correct_word_id')  int correctWordId, @JsonKey(name: 'user_answer')  String? userAnswer, @JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'is_correct')  bool isCorrect, @JsonKey(name: 'created_at')  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _RatingRecord():
return $default(_that.id,_that.correctWordId,_that.userAnswer,_that.userId,_that.isCorrect,_that.createdAt);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id, @JsonKey(name: 'correct_word_id')  int correctWordId, @JsonKey(name: 'user_answer')  String? userAnswer, @JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'is_correct')  bool isCorrect, @JsonKey(name: 'created_at')  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _RatingRecord() when $default != null:
return $default(_that.id,_that.correctWordId,_that.userAnswer,_that.userId,_that.isCorrect,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RatingRecord implements RatingRecord {
  const _RatingRecord({required this.id, @JsonKey(name: 'correct_word_id') required this.correctWordId, @JsonKey(name: 'user_answer') required this.userAnswer, @JsonKey(name: 'user_id') required this.userId, @JsonKey(name: 'is_correct') required this.isCorrect, @JsonKey(name: 'created_at') required this.createdAt});
  factory _RatingRecord.fromJson(Map<String, dynamic> json) => _$RatingRecordFromJson(json);

@override final  int id;
@override@JsonKey(name: 'correct_word_id') final  int correctWordId;
@override@JsonKey(name: 'user_answer') final  String? userAnswer;
@override@JsonKey(name: 'user_id') final  String userId;
@override@JsonKey(name: 'is_correct') final  bool isCorrect;
@override@JsonKey(name: 'created_at') final  DateTime createdAt;

/// Create a copy of RatingRecord
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RatingRecordCopyWith<_RatingRecord> get copyWith => __$RatingRecordCopyWithImpl<_RatingRecord>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RatingRecordToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RatingRecord&&(identical(other.id, id) || other.id == id)&&(identical(other.correctWordId, correctWordId) || other.correctWordId == correctWordId)&&(identical(other.userAnswer, userAnswer) || other.userAnswer == userAnswer)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.isCorrect, isCorrect) || other.isCorrect == isCorrect)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,correctWordId,userAnswer,userId,isCorrect,createdAt);

@override
String toString() {
  return 'RatingRecord(id: $id, correctWordId: $correctWordId, userAnswer: $userAnswer, userId: $userId, isCorrect: $isCorrect, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$RatingRecordCopyWith<$Res> implements $RatingRecordCopyWith<$Res> {
  factory _$RatingRecordCopyWith(_RatingRecord value, $Res Function(_RatingRecord) _then) = __$RatingRecordCopyWithImpl;
@override @useResult
$Res call({
 int id,@JsonKey(name: 'correct_word_id') int correctWordId,@JsonKey(name: 'user_answer') String? userAnswer,@JsonKey(name: 'user_id') String userId,@JsonKey(name: 'is_correct') bool isCorrect,@JsonKey(name: 'created_at') DateTime createdAt
});




}
/// @nodoc
class __$RatingRecordCopyWithImpl<$Res>
    implements _$RatingRecordCopyWith<$Res> {
  __$RatingRecordCopyWithImpl(this._self, this._then);

  final _RatingRecord _self;
  final $Res Function(_RatingRecord) _then;

/// Create a copy of RatingRecord
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? correctWordId = null,Object? userAnswer = freezed,Object? userId = null,Object? isCorrect = null,Object? createdAt = null,}) {
  return _then(_RatingRecord(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,correctWordId: null == correctWordId ? _self.correctWordId : correctWordId // ignore: cast_nullable_to_non_nullable
as int,userAnswer: freezed == userAnswer ? _self.userAnswer : userAnswer // ignore: cast_nullable_to_non_nullable
as String?,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,isCorrect: null == isCorrect ? _self.isCorrect : isCorrect // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
