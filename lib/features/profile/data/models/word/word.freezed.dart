// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'word.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Word {

 int get id; String get word; String get transcription; String get russian;@JsonKey(name: 'language_id') int get languageId;
/// Create a copy of Word
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WordCopyWith<Word> get copyWith => _$WordCopyWithImpl<Word>(this as Word, _$identity);

  /// Serializes this Word to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Word&&(identical(other.id, id) || other.id == id)&&(identical(other.word, word) || other.word == word)&&(identical(other.transcription, transcription) || other.transcription == transcription)&&(identical(other.russian, russian) || other.russian == russian)&&(identical(other.languageId, languageId) || other.languageId == languageId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,word,transcription,russian,languageId);

@override
String toString() {
  return 'Word(id: $id, word: $word, transcription: $transcription, russian: $russian, languageId: $languageId)';
}


}

/// @nodoc
abstract mixin class $WordCopyWith<$Res>  {
  factory $WordCopyWith(Word value, $Res Function(Word) _then) = _$WordCopyWithImpl;
@useResult
$Res call({
 int id, String word, String transcription, String russian,@JsonKey(name: 'language_id') int languageId
});




}
/// @nodoc
class _$WordCopyWithImpl<$Res>
    implements $WordCopyWith<$Res> {
  _$WordCopyWithImpl(this._self, this._then);

  final Word _self;
  final $Res Function(Word) _then;

/// Create a copy of Word
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? word = null,Object? transcription = null,Object? russian = null,Object? languageId = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,word: null == word ? _self.word : word // ignore: cast_nullable_to_non_nullable
as String,transcription: null == transcription ? _self.transcription : transcription // ignore: cast_nullable_to_non_nullable
as String,russian: null == russian ? _self.russian : russian // ignore: cast_nullable_to_non_nullable
as String,languageId: null == languageId ? _self.languageId : languageId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [Word].
extension WordPatterns on Word {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Word value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Word() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Word value)  $default,){
final _that = this;
switch (_that) {
case _Word():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Word value)?  $default,){
final _that = this;
switch (_that) {
case _Word() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String word,  String transcription,  String russian, @JsonKey(name: 'language_id')  int languageId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Word() when $default != null:
return $default(_that.id,_that.word,_that.transcription,_that.russian,_that.languageId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String word,  String transcription,  String russian, @JsonKey(name: 'language_id')  int languageId)  $default,) {final _that = this;
switch (_that) {
case _Word():
return $default(_that.id,_that.word,_that.transcription,_that.russian,_that.languageId);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String word,  String transcription,  String russian, @JsonKey(name: 'language_id')  int languageId)?  $default,) {final _that = this;
switch (_that) {
case _Word() when $default != null:
return $default(_that.id,_that.word,_that.transcription,_that.russian,_that.languageId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Word implements Word {
  const _Word({required this.id, required this.word, required this.transcription, required this.russian, @JsonKey(name: 'language_id') required this.languageId});
  factory _Word.fromJson(Map<String, dynamic> json) => _$WordFromJson(json);

@override final  int id;
@override final  String word;
@override final  String transcription;
@override final  String russian;
@override@JsonKey(name: 'language_id') final  int languageId;

/// Create a copy of Word
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WordCopyWith<_Word> get copyWith => __$WordCopyWithImpl<_Word>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WordToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Word&&(identical(other.id, id) || other.id == id)&&(identical(other.word, word) || other.word == word)&&(identical(other.transcription, transcription) || other.transcription == transcription)&&(identical(other.russian, russian) || other.russian == russian)&&(identical(other.languageId, languageId) || other.languageId == languageId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,word,transcription,russian,languageId);

@override
String toString() {
  return 'Word(id: $id, word: $word, transcription: $transcription, russian: $russian, languageId: $languageId)';
}


}

/// @nodoc
abstract mixin class _$WordCopyWith<$Res> implements $WordCopyWith<$Res> {
  factory _$WordCopyWith(_Word value, $Res Function(_Word) _then) = __$WordCopyWithImpl;
@override @useResult
$Res call({
 int id, String word, String transcription, String russian,@JsonKey(name: 'language_id') int languageId
});




}
/// @nodoc
class __$WordCopyWithImpl<$Res>
    implements _$WordCopyWith<$Res> {
  __$WordCopyWithImpl(this._self, this._then);

  final _Word _self;
  final $Res Function(_Word) _then;

/// Create a copy of Word
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? word = null,Object? transcription = null,Object? russian = null,Object? languageId = null,}) {
  return _then(_Word(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,word: null == word ? _self.word : word // ignore: cast_nullable_to_non_nullable
as String,transcription: null == transcription ? _self.transcription : transcription // ignore: cast_nullable_to_non_nullable
as String,russian: null == russian ? _self.russian : russian // ignore: cast_nullable_to_non_nullable
as String,languageId: null == languageId ? _self.languageId : languageId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
