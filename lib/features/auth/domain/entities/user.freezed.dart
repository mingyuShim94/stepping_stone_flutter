// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$User {
  String get id => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String? get displayName => throw _privateConstructorUsedError;
  String? get photoUrl => throw _privateConstructorUsedError;
  String? get nickname => throw _privateConstructorUsedError;
  bool get isAnonymous => throw _privateConstructorUsedError;
  bool get isEmailVerified => throw _privateConstructorUsedError;
  int get level => throw _privateConstructorUsedError;
  int get experience => throw _privateConstructorUsedError;
  int get totalScore => throw _privateConstructorUsedError;
  int get bestScore => throw _privateConstructorUsedError;
  int get totalPlays => throw _privateConstructorUsedError;
  Duration get totalPlayTime => throw _privateConstructorUsedError;
  List<String> get achievements => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get lastLoginAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserCopyWith<User> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) then) =
      _$UserCopyWithImpl<$Res, User>;
  @useResult
  $Res call(
      {String id,
      String email,
      String? displayName,
      String? photoUrl,
      String? nickname,
      bool isAnonymous,
      bool isEmailVerified,
      int level,
      int experience,
      int totalScore,
      int bestScore,
      int totalPlays,
      Duration totalPlayTime,
      List<String> achievements,
      DateTime? createdAt,
      DateTime? lastLoginAt,
      DateTime? updatedAt,
      bool isActive});
}

/// @nodoc
class _$UserCopyWithImpl<$Res, $Val extends User>
    implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? displayName = freezed,
    Object? photoUrl = freezed,
    Object? nickname = freezed,
    Object? isAnonymous = null,
    Object? isEmailVerified = null,
    Object? level = null,
    Object? experience = null,
    Object? totalScore = null,
    Object? bestScore = null,
    Object? totalPlays = null,
    Object? totalPlayTime = null,
    Object? achievements = null,
    Object? createdAt = freezed,
    Object? lastLoginAt = freezed,
    Object? updatedAt = freezed,
    Object? isActive = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: freezed == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      photoUrl: freezed == photoUrl
          ? _value.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      nickname: freezed == nickname
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String?,
      isAnonymous: null == isAnonymous
          ? _value.isAnonymous
          : isAnonymous // ignore: cast_nullable_to_non_nullable
              as bool,
      isEmailVerified: null == isEmailVerified
          ? _value.isEmailVerified
          : isEmailVerified // ignore: cast_nullable_to_non_nullable
              as bool,
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as int,
      experience: null == experience
          ? _value.experience
          : experience // ignore: cast_nullable_to_non_nullable
              as int,
      totalScore: null == totalScore
          ? _value.totalScore
          : totalScore // ignore: cast_nullable_to_non_nullable
              as int,
      bestScore: null == bestScore
          ? _value.bestScore
          : bestScore // ignore: cast_nullable_to_non_nullable
              as int,
      totalPlays: null == totalPlays
          ? _value.totalPlays
          : totalPlays // ignore: cast_nullable_to_non_nullable
              as int,
      totalPlayTime: null == totalPlayTime
          ? _value.totalPlayTime
          : totalPlayTime // ignore: cast_nullable_to_non_nullable
              as Duration,
      achievements: null == achievements
          ? _value.achievements
          : achievements // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastLoginAt: freezed == lastLoginAt
          ? _value.lastLoginAt
          : lastLoginAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserImplCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$$UserImplCopyWith(
          _$UserImpl value, $Res Function(_$UserImpl) then) =
      __$$UserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String email,
      String? displayName,
      String? photoUrl,
      String? nickname,
      bool isAnonymous,
      bool isEmailVerified,
      int level,
      int experience,
      int totalScore,
      int bestScore,
      int totalPlays,
      Duration totalPlayTime,
      List<String> achievements,
      DateTime? createdAt,
      DateTime? lastLoginAt,
      DateTime? updatedAt,
      bool isActive});
}

/// @nodoc
class __$$UserImplCopyWithImpl<$Res>
    extends _$UserCopyWithImpl<$Res, _$UserImpl>
    implements _$$UserImplCopyWith<$Res> {
  __$$UserImplCopyWithImpl(_$UserImpl _value, $Res Function(_$UserImpl) _then)
      : super(_value, _then);

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? displayName = freezed,
    Object? photoUrl = freezed,
    Object? nickname = freezed,
    Object? isAnonymous = null,
    Object? isEmailVerified = null,
    Object? level = null,
    Object? experience = null,
    Object? totalScore = null,
    Object? bestScore = null,
    Object? totalPlays = null,
    Object? totalPlayTime = null,
    Object? achievements = null,
    Object? createdAt = freezed,
    Object? lastLoginAt = freezed,
    Object? updatedAt = freezed,
    Object? isActive = null,
  }) {
    return _then(_$UserImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: freezed == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      photoUrl: freezed == photoUrl
          ? _value.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      nickname: freezed == nickname
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String?,
      isAnonymous: null == isAnonymous
          ? _value.isAnonymous
          : isAnonymous // ignore: cast_nullable_to_non_nullable
              as bool,
      isEmailVerified: null == isEmailVerified
          ? _value.isEmailVerified
          : isEmailVerified // ignore: cast_nullable_to_non_nullable
              as bool,
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as int,
      experience: null == experience
          ? _value.experience
          : experience // ignore: cast_nullable_to_non_nullable
              as int,
      totalScore: null == totalScore
          ? _value.totalScore
          : totalScore // ignore: cast_nullable_to_non_nullable
              as int,
      bestScore: null == bestScore
          ? _value.bestScore
          : bestScore // ignore: cast_nullable_to_non_nullable
              as int,
      totalPlays: null == totalPlays
          ? _value.totalPlays
          : totalPlays // ignore: cast_nullable_to_non_nullable
              as int,
      totalPlayTime: null == totalPlayTime
          ? _value.totalPlayTime
          : totalPlayTime // ignore: cast_nullable_to_non_nullable
              as Duration,
      achievements: null == achievements
          ? _value._achievements
          : achievements // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastLoginAt: freezed == lastLoginAt
          ? _value.lastLoginAt
          : lastLoginAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$UserImpl extends _User {
  const _$UserImpl(
      {required this.id,
      required this.email,
      this.displayName,
      this.photoUrl,
      this.nickname,
      this.isAnonymous = false,
      this.isEmailVerified = false,
      this.level = 1,
      this.experience = 0,
      this.totalScore = 0,
      this.bestScore = 0,
      this.totalPlays = 0,
      this.totalPlayTime = Duration.zero,
      final List<String> achievements = const [],
      this.createdAt,
      this.lastLoginAt,
      this.updatedAt,
      this.isActive = true})
      : _achievements = achievements,
        super._();

  @override
  final String id;
  @override
  final String email;
  @override
  final String? displayName;
  @override
  final String? photoUrl;
  @override
  final String? nickname;
  @override
  @JsonKey()
  final bool isAnonymous;
  @override
  @JsonKey()
  final bool isEmailVerified;
  @override
  @JsonKey()
  final int level;
  @override
  @JsonKey()
  final int experience;
  @override
  @JsonKey()
  final int totalScore;
  @override
  @JsonKey()
  final int bestScore;
  @override
  @JsonKey()
  final int totalPlays;
  @override
  @JsonKey()
  final Duration totalPlayTime;
  final List<String> _achievements;
  @override
  @JsonKey()
  List<String> get achievements {
    if (_achievements is EqualUnmodifiableListView) return _achievements;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_achievements);
  }

  @override
  final DateTime? createdAt;
  @override
  final DateTime? lastLoginAt;
  @override
  final DateTime? updatedAt;
  @override
  @JsonKey()
  final bool isActive;

  @override
  String toString() {
    return 'User(id: $id, email: $email, displayName: $displayName, photoUrl: $photoUrl, nickname: $nickname, isAnonymous: $isAnonymous, isEmailVerified: $isEmailVerified, level: $level, experience: $experience, totalScore: $totalScore, bestScore: $bestScore, totalPlays: $totalPlays, totalPlayTime: $totalPlayTime, achievements: $achievements, createdAt: $createdAt, lastLoginAt: $lastLoginAt, updatedAt: $updatedAt, isActive: $isActive)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.photoUrl, photoUrl) ||
                other.photoUrl == photoUrl) &&
            (identical(other.nickname, nickname) ||
                other.nickname == nickname) &&
            (identical(other.isAnonymous, isAnonymous) ||
                other.isAnonymous == isAnonymous) &&
            (identical(other.isEmailVerified, isEmailVerified) ||
                other.isEmailVerified == isEmailVerified) &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.experience, experience) ||
                other.experience == experience) &&
            (identical(other.totalScore, totalScore) ||
                other.totalScore == totalScore) &&
            (identical(other.bestScore, bestScore) ||
                other.bestScore == bestScore) &&
            (identical(other.totalPlays, totalPlays) ||
                other.totalPlays == totalPlays) &&
            (identical(other.totalPlayTime, totalPlayTime) ||
                other.totalPlayTime == totalPlayTime) &&
            const DeepCollectionEquality()
                .equals(other._achievements, _achievements) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.lastLoginAt, lastLoginAt) ||
                other.lastLoginAt == lastLoginAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      email,
      displayName,
      photoUrl,
      nickname,
      isAnonymous,
      isEmailVerified,
      level,
      experience,
      totalScore,
      bestScore,
      totalPlays,
      totalPlayTime,
      const DeepCollectionEquality().hash(_achievements),
      createdAt,
      lastLoginAt,
      updatedAt,
      isActive);

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      __$$UserImplCopyWithImpl<_$UserImpl>(this, _$identity);
}

abstract class _User extends User {
  const factory _User(
      {required final String id,
      required final String email,
      final String? displayName,
      final String? photoUrl,
      final String? nickname,
      final bool isAnonymous,
      final bool isEmailVerified,
      final int level,
      final int experience,
      final int totalScore,
      final int bestScore,
      final int totalPlays,
      final Duration totalPlayTime,
      final List<String> achievements,
      final DateTime? createdAt,
      final DateTime? lastLoginAt,
      final DateTime? updatedAt,
      final bool isActive}) = _$UserImpl;
  const _User._() : super._();

  @override
  String get id;
  @override
  String get email;
  @override
  String? get displayName;
  @override
  String? get photoUrl;
  @override
  String? get nickname;
  @override
  bool get isAnonymous;
  @override
  bool get isEmailVerified;
  @override
  int get level;
  @override
  int get experience;
  @override
  int get totalScore;
  @override
  int get bestScore;
  @override
  int get totalPlays;
  @override
  Duration get totalPlayTime;
  @override
  List<String> get achievements;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get lastLoginAt;
  @override
  DateTime? get updatedAt;
  @override
  bool get isActive;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
