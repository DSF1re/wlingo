// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_failure.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AppFailure {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppFailure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AppFailure()';
}


}

/// @nodoc
class $AppFailureCopyWith<$Res>  {
$AppFailureCopyWith(AppFailure _, $Res Function(AppFailure) __);
}


/// Adds pattern-matching-related methods to [AppFailure].
extension AppFailurePatterns on AppFailure {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _NetworkError value)?  networkError,TResult Function( _InvalidCredentials value)?  invalidCredentials,TResult Function( _Unexpected value)?  unexpected,TResult Function( _NullUser value)?  nullUser,TResult Function( _EmailNotConfirmed value)?  emailNotConfirmed,TResult Function( _EmailAlreadyInUse value)?  emailAlreadyInUse,TResult Function( _InvalidEmail value)?  invalidEmail,TResult Function( _FillForm value)?  fillForm,TResult Function( _FillAuth value)?  fillAuth,TResult Function( _FillEmail value)?  fillEmail,TResult Function( _FillPassword value)?  fillPassword,TResult Function( _InvalidNameFormat value)?  invalidNameFormat,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NetworkError() when networkError != null:
return networkError(_that);case _InvalidCredentials() when invalidCredentials != null:
return invalidCredentials(_that);case _Unexpected() when unexpected != null:
return unexpected(_that);case _NullUser() when nullUser != null:
return nullUser(_that);case _EmailNotConfirmed() when emailNotConfirmed != null:
return emailNotConfirmed(_that);case _EmailAlreadyInUse() when emailAlreadyInUse != null:
return emailAlreadyInUse(_that);case _InvalidEmail() when invalidEmail != null:
return invalidEmail(_that);case _FillForm() when fillForm != null:
return fillForm(_that);case _FillAuth() when fillAuth != null:
return fillAuth(_that);case _FillEmail() when fillEmail != null:
return fillEmail(_that);case _FillPassword() when fillPassword != null:
return fillPassword(_that);case _InvalidNameFormat() when invalidNameFormat != null:
return invalidNameFormat(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _NetworkError value)  networkError,required TResult Function( _InvalidCredentials value)  invalidCredentials,required TResult Function( _Unexpected value)  unexpected,required TResult Function( _NullUser value)  nullUser,required TResult Function( _EmailNotConfirmed value)  emailNotConfirmed,required TResult Function( _EmailAlreadyInUse value)  emailAlreadyInUse,required TResult Function( _InvalidEmail value)  invalidEmail,required TResult Function( _FillForm value)  fillForm,required TResult Function( _FillAuth value)  fillAuth,required TResult Function( _FillEmail value)  fillEmail,required TResult Function( _FillPassword value)  fillPassword,required TResult Function( _InvalidNameFormat value)  invalidNameFormat,}){
final _that = this;
switch (_that) {
case _NetworkError():
return networkError(_that);case _InvalidCredentials():
return invalidCredentials(_that);case _Unexpected():
return unexpected(_that);case _NullUser():
return nullUser(_that);case _EmailNotConfirmed():
return emailNotConfirmed(_that);case _EmailAlreadyInUse():
return emailAlreadyInUse(_that);case _InvalidEmail():
return invalidEmail(_that);case _FillForm():
return fillForm(_that);case _FillAuth():
return fillAuth(_that);case _FillEmail():
return fillEmail(_that);case _FillPassword():
return fillPassword(_that);case _InvalidNameFormat():
return invalidNameFormat(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _NetworkError value)?  networkError,TResult? Function( _InvalidCredentials value)?  invalidCredentials,TResult? Function( _Unexpected value)?  unexpected,TResult? Function( _NullUser value)?  nullUser,TResult? Function( _EmailNotConfirmed value)?  emailNotConfirmed,TResult? Function( _EmailAlreadyInUse value)?  emailAlreadyInUse,TResult? Function( _InvalidEmail value)?  invalidEmail,TResult? Function( _FillForm value)?  fillForm,TResult? Function( _FillAuth value)?  fillAuth,TResult? Function( _FillEmail value)?  fillEmail,TResult? Function( _FillPassword value)?  fillPassword,TResult? Function( _InvalidNameFormat value)?  invalidNameFormat,}){
final _that = this;
switch (_that) {
case _NetworkError() when networkError != null:
return networkError(_that);case _InvalidCredentials() when invalidCredentials != null:
return invalidCredentials(_that);case _Unexpected() when unexpected != null:
return unexpected(_that);case _NullUser() when nullUser != null:
return nullUser(_that);case _EmailNotConfirmed() when emailNotConfirmed != null:
return emailNotConfirmed(_that);case _EmailAlreadyInUse() when emailAlreadyInUse != null:
return emailAlreadyInUse(_that);case _InvalidEmail() when invalidEmail != null:
return invalidEmail(_that);case _FillForm() when fillForm != null:
return fillForm(_that);case _FillAuth() when fillAuth != null:
return fillAuth(_that);case _FillEmail() when fillEmail != null:
return fillEmail(_that);case _FillPassword() when fillPassword != null:
return fillPassword(_that);case _InvalidNameFormat() when invalidNameFormat != null:
return invalidNameFormat(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  networkError,TResult Function()?  invalidCredentials,TResult Function( String message)?  unexpected,TResult Function()?  nullUser,TResult Function()?  emailNotConfirmed,TResult Function()?  emailAlreadyInUse,TResult Function()?  invalidEmail,TResult Function()?  fillForm,TResult Function()?  fillAuth,TResult Function()?  fillEmail,TResult Function()?  fillPassword,TResult Function()?  invalidNameFormat,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NetworkError() when networkError != null:
return networkError();case _InvalidCredentials() when invalidCredentials != null:
return invalidCredentials();case _Unexpected() when unexpected != null:
return unexpected(_that.message);case _NullUser() when nullUser != null:
return nullUser();case _EmailNotConfirmed() when emailNotConfirmed != null:
return emailNotConfirmed();case _EmailAlreadyInUse() when emailAlreadyInUse != null:
return emailAlreadyInUse();case _InvalidEmail() when invalidEmail != null:
return invalidEmail();case _FillForm() when fillForm != null:
return fillForm();case _FillAuth() when fillAuth != null:
return fillAuth();case _FillEmail() when fillEmail != null:
return fillEmail();case _FillPassword() when fillPassword != null:
return fillPassword();case _InvalidNameFormat() when invalidNameFormat != null:
return invalidNameFormat();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  networkError,required TResult Function()  invalidCredentials,required TResult Function( String message)  unexpected,required TResult Function()  nullUser,required TResult Function()  emailNotConfirmed,required TResult Function()  emailAlreadyInUse,required TResult Function()  invalidEmail,required TResult Function()  fillForm,required TResult Function()  fillAuth,required TResult Function()  fillEmail,required TResult Function()  fillPassword,required TResult Function()  invalidNameFormat,}) {final _that = this;
switch (_that) {
case _NetworkError():
return networkError();case _InvalidCredentials():
return invalidCredentials();case _Unexpected():
return unexpected(_that.message);case _NullUser():
return nullUser();case _EmailNotConfirmed():
return emailNotConfirmed();case _EmailAlreadyInUse():
return emailAlreadyInUse();case _InvalidEmail():
return invalidEmail();case _FillForm():
return fillForm();case _FillAuth():
return fillAuth();case _FillEmail():
return fillEmail();case _FillPassword():
return fillPassword();case _InvalidNameFormat():
return invalidNameFormat();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  networkError,TResult? Function()?  invalidCredentials,TResult? Function( String message)?  unexpected,TResult? Function()?  nullUser,TResult? Function()?  emailNotConfirmed,TResult? Function()?  emailAlreadyInUse,TResult? Function()?  invalidEmail,TResult? Function()?  fillForm,TResult? Function()?  fillAuth,TResult? Function()?  fillEmail,TResult? Function()?  fillPassword,TResult? Function()?  invalidNameFormat,}) {final _that = this;
switch (_that) {
case _NetworkError() when networkError != null:
return networkError();case _InvalidCredentials() when invalidCredentials != null:
return invalidCredentials();case _Unexpected() when unexpected != null:
return unexpected(_that.message);case _NullUser() when nullUser != null:
return nullUser();case _EmailNotConfirmed() when emailNotConfirmed != null:
return emailNotConfirmed();case _EmailAlreadyInUse() when emailAlreadyInUse != null:
return emailAlreadyInUse();case _InvalidEmail() when invalidEmail != null:
return invalidEmail();case _FillForm() when fillForm != null:
return fillForm();case _FillAuth() when fillAuth != null:
return fillAuth();case _FillEmail() when fillEmail != null:
return fillEmail();case _FillPassword() when fillPassword != null:
return fillPassword();case _InvalidNameFormat() when invalidNameFormat != null:
return invalidNameFormat();case _:
  return null;

}
}

}

/// @nodoc


class _NetworkError implements AppFailure {
  const _NetworkError();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NetworkError);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AppFailure.networkError()';
}


}




/// @nodoc


class _InvalidCredentials implements AppFailure {
  const _InvalidCredentials();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InvalidCredentials);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AppFailure.invalidCredentials()';
}


}




/// @nodoc


class _Unexpected implements AppFailure {
  const _Unexpected(this.message);
  

 final  String message;

/// Create a copy of AppFailure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UnexpectedCopyWith<_Unexpected> get copyWith => __$UnexpectedCopyWithImpl<_Unexpected>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Unexpected&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'AppFailure.unexpected(message: $message)';
}


}

/// @nodoc
abstract mixin class _$UnexpectedCopyWith<$Res> implements $AppFailureCopyWith<$Res> {
  factory _$UnexpectedCopyWith(_Unexpected value, $Res Function(_Unexpected) _then) = __$UnexpectedCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$UnexpectedCopyWithImpl<$Res>
    implements _$UnexpectedCopyWith<$Res> {
  __$UnexpectedCopyWithImpl(this._self, this._then);

  final _Unexpected _self;
  final $Res Function(_Unexpected) _then;

/// Create a copy of AppFailure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_Unexpected(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _NullUser implements AppFailure {
  const _NullUser();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NullUser);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AppFailure.nullUser()';
}


}




/// @nodoc


class _EmailNotConfirmed implements AppFailure {
  const _EmailNotConfirmed();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EmailNotConfirmed);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AppFailure.emailNotConfirmed()';
}


}




/// @nodoc


class _EmailAlreadyInUse implements AppFailure {
  const _EmailAlreadyInUse();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EmailAlreadyInUse);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AppFailure.emailAlreadyInUse()';
}


}




/// @nodoc


class _InvalidEmail implements AppFailure {
  const _InvalidEmail();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InvalidEmail);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AppFailure.invalidEmail()';
}


}




/// @nodoc


class _FillForm implements AppFailure {
  const _FillForm();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FillForm);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AppFailure.fillForm()';
}


}




/// @nodoc


class _FillAuth implements AppFailure {
  const _FillAuth();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FillAuth);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AppFailure.fillAuth()';
}


}




/// @nodoc


class _FillEmail implements AppFailure {
  const _FillEmail();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FillEmail);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AppFailure.fillEmail()';
}


}




/// @nodoc


class _FillPassword implements AppFailure {
  const _FillPassword();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FillPassword);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AppFailure.fillPassword()';
}


}




/// @nodoc


class _InvalidNameFormat implements AppFailure {
  const _InvalidNameFormat();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InvalidNameFormat);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AppFailure.invalidNameFormat()';
}


}




// dart format on
