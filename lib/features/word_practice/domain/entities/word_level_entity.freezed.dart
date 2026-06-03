// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'word_level_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WordLevelEntity {

 int get id; String get name; String? get description;@JsonKey(name: 'level_order') int get levelOrder;
/// Create a copy of WordLevelEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WordLevelEntityCopyWith<WordLevelEntity> get copyWith => _$WordLevelEntityCopyWithImpl<WordLevelEntity>(this as WordLevelEntity, _$identity);

  /// Serializes this WordLevelEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WordLevelEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.levelOrder, levelOrder) || other.levelOrder == levelOrder));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,levelOrder);

@override
String toString() {
  return 'WordLevelEntity(id: $id, name: $name, description: $description, levelOrder: $levelOrder)';
}


}

/// @nodoc
abstract mixin class $WordLevelEntityCopyWith<$Res>  {
  factory $WordLevelEntityCopyWith(WordLevelEntity value, $Res Function(WordLevelEntity) _then) = _$WordLevelEntityCopyWithImpl;
@useResult
$Res call({
 int id, String name, String? description,@JsonKey(name: 'level_order') int levelOrder
});




}
/// @nodoc
class _$WordLevelEntityCopyWithImpl<$Res>
    implements $WordLevelEntityCopyWith<$Res> {
  _$WordLevelEntityCopyWithImpl(this._self, this._then);

  final WordLevelEntity _self;
  final $Res Function(WordLevelEntity) _then;

/// Create a copy of WordLevelEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? description = freezed,Object? levelOrder = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,levelOrder: null == levelOrder ? _self.levelOrder : levelOrder // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [WordLevelEntity].
extension WordLevelEntityPatterns on WordLevelEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WordLevelEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WordLevelEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WordLevelEntity value)  $default,){
final _that = this;
switch (_that) {
case _WordLevelEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WordLevelEntity value)?  $default,){
final _that = this;
switch (_that) {
case _WordLevelEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String? description, @JsonKey(name: 'level_order')  int levelOrder)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WordLevelEntity() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.levelOrder);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String? description, @JsonKey(name: 'level_order')  int levelOrder)  $default,) {final _that = this;
switch (_that) {
case _WordLevelEntity():
return $default(_that.id,_that.name,_that.description,_that.levelOrder);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String? description, @JsonKey(name: 'level_order')  int levelOrder)?  $default,) {final _that = this;
switch (_that) {
case _WordLevelEntity() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.levelOrder);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WordLevelEntity implements WordLevelEntity {
  const _WordLevelEntity({required this.id, required this.name, this.description, @JsonKey(name: 'level_order') required this.levelOrder});
  factory _WordLevelEntity.fromJson(Map<String, dynamic> json) => _$WordLevelEntityFromJson(json);

@override final  int id;
@override final  String name;
@override final  String? description;
@override@JsonKey(name: 'level_order') final  int levelOrder;

/// Create a copy of WordLevelEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WordLevelEntityCopyWith<_WordLevelEntity> get copyWith => __$WordLevelEntityCopyWithImpl<_WordLevelEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WordLevelEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WordLevelEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.levelOrder, levelOrder) || other.levelOrder == levelOrder));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,levelOrder);

@override
String toString() {
  return 'WordLevelEntity(id: $id, name: $name, description: $description, levelOrder: $levelOrder)';
}


}

/// @nodoc
abstract mixin class _$WordLevelEntityCopyWith<$Res> implements $WordLevelEntityCopyWith<$Res> {
  factory _$WordLevelEntityCopyWith(_WordLevelEntity value, $Res Function(_WordLevelEntity) _then) = __$WordLevelEntityCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String? description,@JsonKey(name: 'level_order') int levelOrder
});




}
/// @nodoc
class __$WordLevelEntityCopyWithImpl<$Res>
    implements _$WordLevelEntityCopyWith<$Res> {
  __$WordLevelEntityCopyWithImpl(this._self, this._then);

  final _WordLevelEntity _self;
  final $Res Function(_WordLevelEntity) _then;

/// Create a copy of WordLevelEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? description = freezed,Object? levelOrder = null,}) {
  return _then(_WordLevelEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,levelOrder: null == levelOrder ? _self.levelOrder : levelOrder // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
