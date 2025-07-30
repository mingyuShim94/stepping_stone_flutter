// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AuthResult {
  User get user => throw _privateConstructorUsedError;
  bool get isNewUser => throw _privateConstructorUsedError;
  String? get accessToken => throw _privateConstructorUsedError;
  String? get refreshToken => throw _privateConstructorUsedError;
  Map<String, dynamic>? get credential => throw _privateConstructorUsedError;

  /// Create a copy of AuthResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AuthResultCopyWith<AuthResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthResultCopyWith<$Res> {
  factory $AuthResultCopyWith(
          AuthResult value, $Res Function(AuthResult) then) =
      _$AuthResultCopyWithImpl<$Res, AuthResult>;
  @useResult
  $Res call(
      {User user,
      bool isNewUser,
      String? accessToken,
      String? refreshToken,
      Map<String, dynamic>? credential});

  $UserCopyWith<$Res> get user;
}

/// @nodoc
class _$AuthResultCopyWithImpl<$Res, $Val extends AuthResult>
    implements $AuthResultCopyWith<$Res> {
  _$AuthResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = null,
    Object? isNewUser = null,
    Object? accessToken = freezed,
    Object? refreshToken = freezed,
    Object? credential = freezed,
  }) {
    return _then(_value.copyWith(
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User,
      isNewUser: null == isNewUser
          ? _value.isNewUser
          : isNewUser // ignore: cast_nullable_to_non_nullable
              as bool,
      accessToken: freezed == accessToken
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String?,
      refreshToken: freezed == refreshToken
          ? _value.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String?,
      credential: freezed == credential
          ? _value.credential
          : credential // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }

  /// Create a copy of AuthResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res> get user {
    return $UserCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AuthResultImplCopyWith<$Res>
    implements $AuthResultCopyWith<$Res> {
  factory _$$AuthResultImplCopyWith(
          _$AuthResultImpl value, $Res Function(_$AuthResultImpl) then) =
      __$$AuthResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {User user,
      bool isNewUser,
      String? accessToken,
      String? refreshToken,
      Map<String, dynamic>? credential});

  @override
  $UserCopyWith<$Res> get user;
}

/// @nodoc
class __$$AuthResultImplCopyWithImpl<$Res>
    extends _$AuthResultCopyWithImpl<$Res, _$AuthResultImpl>
    implements _$$AuthResultImplCopyWith<$Res> {
  __$$AuthResultImplCopyWithImpl(
      _$AuthResultImpl _value, $Res Function(_$AuthResultImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = null,
    Object? isNewUser = null,
    Object? accessToken = freezed,
    Object? refreshToken = freezed,
    Object? credential = freezed,
  }) {
    return _then(_$AuthResultImpl(
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User,
      isNewUser: null == isNewUser
          ? _value.isNewUser
          : isNewUser // ignore: cast_nullable_to_non_nullable
              as bool,
      accessToken: freezed == accessToken
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String?,
      refreshToken: freezed == refreshToken
          ? _value.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String?,
      credential: freezed == credential
          ? _value._credential
          : credential // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc

class _$AuthResultImpl implements _AuthResult {
  const _$AuthResultImpl(
      {required this.user,
      required this.isNewUser,
      this.accessToken,
      this.refreshToken,
      final Map<String, dynamic>? credential})
      : _credential = credential;

  @override
  final User user;
  @override
  final bool isNewUser;
  @override
  final String? accessToken;
  @override
  final String? refreshToken;
  final Map<String, dynamic>? _credential;
  @override
  Map<String, dynamic>? get credential {
    final value = _credential;
    if (value == null) return null;
    if (_credential is EqualUnmodifiableMapView) return _credential;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'AuthResult(user: $user, isNewUser: $isNewUser, accessToken: $accessToken, refreshToken: $refreshToken, credential: $credential)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthResultImpl &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.isNewUser, isNewUser) ||
                other.isNewUser == isNewUser) &&
            (identical(other.accessToken, accessToken) ||
                other.accessToken == accessToken) &&
            (identical(other.refreshToken, refreshToken) ||
                other.refreshToken == refreshToken) &&
            const DeepCollectionEquality()
                .equals(other._credential, _credential));
  }

  @override
  int get hashCode => Object.hash(runtimeType, user, isNewUser, accessToken,
      refreshToken, const DeepCollectionEquality().hash(_credential));

  /// Create a copy of AuthResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthResultImplCopyWith<_$AuthResultImpl> get copyWith =>
      __$$AuthResultImplCopyWithImpl<_$AuthResultImpl>(this, _$identity);
}

abstract class _AuthResult implements AuthResult {
  const factory _AuthResult(
      {required final User user,
      required final bool isNewUser,
      final String? accessToken,
      final String? refreshToken,
      final Map<String, dynamic>? credential}) = _$AuthResultImpl;

  @override
  User get user;
  @override
  bool get isNewUser;
  @override
  String? get accessToken;
  @override
  String? get refreshToken;
  @override
  Map<String, dynamic>? get credential;

  /// Create a copy of AuthResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthResultImplCopyWith<_$AuthResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
