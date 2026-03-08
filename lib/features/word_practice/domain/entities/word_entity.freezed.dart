// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'word_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$WordEntity {

 int get id; String get word; String get transcription; String get russian; int get languageId; String? get image;
/// Create a copy of WordEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WordEntityCopyWith<WordEntity> get copyWith => _$WordEntityCopyWithImpl<WordEntity>(this as WordEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WordEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.word, word) || other.word == word)&&(identical(other.transcription, transcription) || other.transcription == transcription)&&(identical(other.russian, russian) || other.russian == russian)&&(identical(other.languageId, languageId) || other.languageId == languageId)&&(identical(other.image, image) || other.image == image));
}


@override
int get hashCode => Object.hash(runtimeType,id,word,transcription,russian,languageId,image);

@override
String toString() {
  return 'WordEntity(id: $id, word: $word, transcription: $transcription, russian: $russian, languageId: $languageId, image: $image)';
}


}

/// @nodoc
abstract mixin class $WordEntityCopyWith<$Res>  {
  factory $WordEntityCopyWith(WordEntity value, $Res Function(WordEntity) _then) = _$WordEntityCopyWithImpl;
@useResult
$Res call({
 int id, String word, String transcription, String russian, int languageId, String? image
});




}
/// @nodoc
class _$WordEntityCopyWithImpl<$Res>
    implements $WordEntityCopyWith<$Res> {
  _$WordEntityCopyWithImpl(this._self, this._then);

  final WordEntity _self;
  final $Res Function(WordEntity) _then;

/// Create a copy of WordEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? word = null,Object? transcription = null,Object? russian = null,Object? languageId = null,Object? image = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,word: null == word ? _self.word : word // ignore: cast_nullable_to_non_nullable
as String,transcription: null == transcription ? _self.transcription : transcription // ignore: cast_nullable_to_non_nullable
as String,russian: null == russian ? _self.russian : russian // ignore: cast_nullable_to_non_nullable
as String,languageId: null == languageId ? _self.languageId : languageId // ignore: cast_nullable_to_non_nullable
as int,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [WordEntity].
extension WordEntityPatterns on WordEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WordEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WordEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WordEntity value)  $default,){
final _that = this;
switch (_that) {
case _WordEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WordEntity value)?  $default,){
final _that = this;
switch (_that) {
case _WordEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String word,  String transcription,  String russian,  int languageId,  String? image)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WordEntity() when $default != null:
return $default(_that.id,_that.word,_that.transcription,_that.russian,_that.languageId,_that.image);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String word,  String transcription,  String russian,  int languageId,  String? image)  $default,) {final _that = this;
switch (_that) {
case _WordEntity():
return $default(_that.id,_that.word,_that.transcription,_that.russian,_that.languageId,_that.image);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String word,  String transcription,  String russian,  int languageId,  String? image)?  $default,) {final _that = this;
switch (_that) {
case _WordEntity() when $default != null:
return $default(_that.id,_that.word,_that.transcription,_that.russian,_that.languageId,_that.image);case _:
  return null;

}
}

}

/// @nodoc


class _WordEntity implements WordEntity {
  const _WordEntity({required this.id, required this.word, required this.transcription, required this.russian, required this.languageId, this.image});
  

@override final  int id;
@override final  String word;
@override final  String transcription;
@override final  String russian;
@override final  int languageId;
@override final  String? image;

/// Create a copy of WordEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WordEntityCopyWith<_WordEntity> get copyWith => __$WordEntityCopyWithImpl<_WordEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WordEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.word, word) || other.word == word)&&(identical(other.transcription, transcription) || other.transcription == transcription)&&(identical(other.russian, russian) || other.russian == russian)&&(identical(other.languageId, languageId) || other.languageId == languageId)&&(identical(other.image, image) || other.image == image));
}


@override
int get hashCode => Object.hash(runtimeType,id,word,transcription,russian,languageId,image);

@override
String toString() {
  return 'WordEntity(id: $id, word: $word, transcription: $transcription, russian: $russian, languageId: $languageId, image: $image)';
}


}

/// @nodoc
abstract mixin class _$WordEntityCopyWith<$Res> implements $WordEntityCopyWith<$Res> {
  factory _$WordEntityCopyWith(_WordEntity value, $Res Function(_WordEntity) _then) = __$WordEntityCopyWithImpl;
@override @useResult
$Res call({
 int id, String word, String transcription, String russian, int languageId, String? image
});




}
/// @nodoc
class __$WordEntityCopyWithImpl<$Res>
    implements _$WordEntityCopyWith<$Res> {
  __$WordEntityCopyWithImpl(this._self, this._then);

  final _WordEntity _self;
  final $Res Function(_WordEntity) _then;

/// Create a copy of WordEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? word = null,Object? transcription = null,Object? russian = null,Object? languageId = null,Object? image = freezed,}) {
  return _then(_WordEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,word: null == word ? _self.word : word // ignore: cast_nullable_to_non_nullable
as String,transcription: null == transcription ? _self.transcription : transcription // ignore: cast_nullable_to_non_nullable
as String,russian: null == russian ? _self.russian : russian // ignore: cast_nullable_to_non_nullable
as String,languageId: null == languageId ? _self.languageId : languageId // ignore: cast_nullable_to_non_nullable
as int,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
