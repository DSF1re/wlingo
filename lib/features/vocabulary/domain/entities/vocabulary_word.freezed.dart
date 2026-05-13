// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vocabulary_word.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VocabularyWord {

 String get id; String get userId; String get word; String get translation; String? get transcription; int get languageId; DateTime? get lastReviewed; DateTime? get nextReview; int get interval; double get easeFactor; int get repetitionCount;@JsonKey(name: 'created_at') DateTime? get createdAt;
/// Create a copy of VocabularyWord
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VocabularyWordCopyWith<VocabularyWord> get copyWith => _$VocabularyWordCopyWithImpl<VocabularyWord>(this as VocabularyWord, _$identity);

  /// Serializes this VocabularyWord to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VocabularyWord&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.word, word) || other.word == word)&&(identical(other.translation, translation) || other.translation == translation)&&(identical(other.transcription, transcription) || other.transcription == transcription)&&(identical(other.languageId, languageId) || other.languageId == languageId)&&(identical(other.lastReviewed, lastReviewed) || other.lastReviewed == lastReviewed)&&(identical(other.nextReview, nextReview) || other.nextReview == nextReview)&&(identical(other.interval, interval) || other.interval == interval)&&(identical(other.easeFactor, easeFactor) || other.easeFactor == easeFactor)&&(identical(other.repetitionCount, repetitionCount) || other.repetitionCount == repetitionCount)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,word,translation,transcription,languageId,lastReviewed,nextReview,interval,easeFactor,repetitionCount,createdAt);

@override
String toString() {
  return 'VocabularyWord(id: $id, userId: $userId, word: $word, translation: $translation, transcription: $transcription, languageId: $languageId, lastReviewed: $lastReviewed, nextReview: $nextReview, interval: $interval, easeFactor: $easeFactor, repetitionCount: $repetitionCount, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $VocabularyWordCopyWith<$Res>  {
  factory $VocabularyWordCopyWith(VocabularyWord value, $Res Function(VocabularyWord) _then) = _$VocabularyWordCopyWithImpl;
@useResult
$Res call({
 String id, String userId, String word, String translation, String? transcription, int languageId, DateTime? lastReviewed, DateTime? nextReview, int interval, double easeFactor, int repetitionCount,@JsonKey(name: 'created_at') DateTime? createdAt
});




}
/// @nodoc
class _$VocabularyWordCopyWithImpl<$Res>
    implements $VocabularyWordCopyWith<$Res> {
  _$VocabularyWordCopyWithImpl(this._self, this._then);

  final VocabularyWord _self;
  final $Res Function(VocabularyWord) _then;

/// Create a copy of VocabularyWord
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? word = null,Object? translation = null,Object? transcription = freezed,Object? languageId = null,Object? lastReviewed = freezed,Object? nextReview = freezed,Object? interval = null,Object? easeFactor = null,Object? repetitionCount = null,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,word: null == word ? _self.word : word // ignore: cast_nullable_to_non_nullable
as String,translation: null == translation ? _self.translation : translation // ignore: cast_nullable_to_non_nullable
as String,transcription: freezed == transcription ? _self.transcription : transcription // ignore: cast_nullable_to_non_nullable
as String?,languageId: null == languageId ? _self.languageId : languageId // ignore: cast_nullable_to_non_nullable
as int,lastReviewed: freezed == lastReviewed ? _self.lastReviewed : lastReviewed // ignore: cast_nullable_to_non_nullable
as DateTime?,nextReview: freezed == nextReview ? _self.nextReview : nextReview // ignore: cast_nullable_to_non_nullable
as DateTime?,interval: null == interval ? _self.interval : interval // ignore: cast_nullable_to_non_nullable
as int,easeFactor: null == easeFactor ? _self.easeFactor : easeFactor // ignore: cast_nullable_to_non_nullable
as double,repetitionCount: null == repetitionCount ? _self.repetitionCount : repetitionCount // ignore: cast_nullable_to_non_nullable
as int,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [VocabularyWord].
extension VocabularyWordPatterns on VocabularyWord {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VocabularyWord value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VocabularyWord() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VocabularyWord value)  $default,){
final _that = this;
switch (_that) {
case _VocabularyWord():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VocabularyWord value)?  $default,){
final _that = this;
switch (_that) {
case _VocabularyWord() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  String word,  String translation,  String? transcription,  int languageId,  DateTime? lastReviewed,  DateTime? nextReview,  int interval,  double easeFactor,  int repetitionCount, @JsonKey(name: 'created_at')  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VocabularyWord() when $default != null:
return $default(_that.id,_that.userId,_that.word,_that.translation,_that.transcription,_that.languageId,_that.lastReviewed,_that.nextReview,_that.interval,_that.easeFactor,_that.repetitionCount,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  String word,  String translation,  String? transcription,  int languageId,  DateTime? lastReviewed,  DateTime? nextReview,  int interval,  double easeFactor,  int repetitionCount, @JsonKey(name: 'created_at')  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _VocabularyWord():
return $default(_that.id,_that.userId,_that.word,_that.translation,_that.transcription,_that.languageId,_that.lastReviewed,_that.nextReview,_that.interval,_that.easeFactor,_that.repetitionCount,_that.createdAt);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  String word,  String translation,  String? transcription,  int languageId,  DateTime? lastReviewed,  DateTime? nextReview,  int interval,  double easeFactor,  int repetitionCount, @JsonKey(name: 'created_at')  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _VocabularyWord() when $default != null:
return $default(_that.id,_that.userId,_that.word,_that.translation,_that.transcription,_that.languageId,_that.lastReviewed,_that.nextReview,_that.interval,_that.easeFactor,_that.repetitionCount,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VocabularyWord implements VocabularyWord {
  const _VocabularyWord({required this.id, required this.userId, required this.word, required this.translation, this.transcription, this.languageId = 0, this.lastReviewed, this.nextReview, this.interval = 0, this.easeFactor = 2.5, this.repetitionCount = 0, @JsonKey(name: 'created_at') this.createdAt});
  factory _VocabularyWord.fromJson(Map<String, dynamic> json) => _$VocabularyWordFromJson(json);

@override final  String id;
@override final  String userId;
@override final  String word;
@override final  String translation;
@override final  String? transcription;
@override@JsonKey() final  int languageId;
@override final  DateTime? lastReviewed;
@override final  DateTime? nextReview;
@override@JsonKey() final  int interval;
@override@JsonKey() final  double easeFactor;
@override@JsonKey() final  int repetitionCount;
@override@JsonKey(name: 'created_at') final  DateTime? createdAt;

/// Create a copy of VocabularyWord
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VocabularyWordCopyWith<_VocabularyWord> get copyWith => __$VocabularyWordCopyWithImpl<_VocabularyWord>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VocabularyWordToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VocabularyWord&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.word, word) || other.word == word)&&(identical(other.translation, translation) || other.translation == translation)&&(identical(other.transcription, transcription) || other.transcription == transcription)&&(identical(other.languageId, languageId) || other.languageId == languageId)&&(identical(other.lastReviewed, lastReviewed) || other.lastReviewed == lastReviewed)&&(identical(other.nextReview, nextReview) || other.nextReview == nextReview)&&(identical(other.interval, interval) || other.interval == interval)&&(identical(other.easeFactor, easeFactor) || other.easeFactor == easeFactor)&&(identical(other.repetitionCount, repetitionCount) || other.repetitionCount == repetitionCount)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,word,translation,transcription,languageId,lastReviewed,nextReview,interval,easeFactor,repetitionCount,createdAt);

@override
String toString() {
  return 'VocabularyWord(id: $id, userId: $userId, word: $word, translation: $translation, transcription: $transcription, languageId: $languageId, lastReviewed: $lastReviewed, nextReview: $nextReview, interval: $interval, easeFactor: $easeFactor, repetitionCount: $repetitionCount, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$VocabularyWordCopyWith<$Res> implements $VocabularyWordCopyWith<$Res> {
  factory _$VocabularyWordCopyWith(_VocabularyWord value, $Res Function(_VocabularyWord) _then) = __$VocabularyWordCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, String word, String translation, String? transcription, int languageId, DateTime? lastReviewed, DateTime? nextReview, int interval, double easeFactor, int repetitionCount,@JsonKey(name: 'created_at') DateTime? createdAt
});




}
/// @nodoc
class __$VocabularyWordCopyWithImpl<$Res>
    implements _$VocabularyWordCopyWith<$Res> {
  __$VocabularyWordCopyWithImpl(this._self, this._then);

  final _VocabularyWord _self;
  final $Res Function(_VocabularyWord) _then;

/// Create a copy of VocabularyWord
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? word = null,Object? translation = null,Object? transcription = freezed,Object? languageId = null,Object? lastReviewed = freezed,Object? nextReview = freezed,Object? interval = null,Object? easeFactor = null,Object? repetitionCount = null,Object? createdAt = freezed,}) {
  return _then(_VocabularyWord(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,word: null == word ? _self.word : word // ignore: cast_nullable_to_non_nullable
as String,translation: null == translation ? _self.translation : translation // ignore: cast_nullable_to_non_nullable
as String,transcription: freezed == transcription ? _self.transcription : transcription // ignore: cast_nullable_to_non_nullable
as String?,languageId: null == languageId ? _self.languageId : languageId // ignore: cast_nullable_to_non_nullable
as int,lastReviewed: freezed == lastReviewed ? _self.lastReviewed : lastReviewed // ignore: cast_nullable_to_non_nullable
as DateTime?,nextReview: freezed == nextReview ? _self.nextReview : nextReview // ignore: cast_nullable_to_non_nullable
as DateTime?,interval: null == interval ? _self.interval : interval // ignore: cast_nullable_to_non_nullable
as int,easeFactor: null == easeFactor ? _self.easeFactor : easeFactor // ignore: cast_nullable_to_non_nullable
as double,repetitionCount: null == repetitionCount ? _self.repetitionCount : repetitionCount // ignore: cast_nullable_to_non_nullable
as int,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
