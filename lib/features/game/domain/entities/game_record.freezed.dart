// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_record.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$GameRecord {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  int get score => throw _privateConstructorUsedError;
  int get playTime => throw _privateConstructorUsedError; // 플레이 시간 (초)
  DateTime get timestamp => throw _privateConstructorUsedError;
  String get gameMode =>
      throw _privateConstructorUsedError; // 'classic', 'timeAttack', 'endless'
  String get difficulty =>
      throw _privateConstructorUsedError; // 'easy', 'normal', 'hard'
  Map<String, dynamic> get metadata =>
      throw _privateConstructorUsedError; // 게임별 상세 데이터
  List<String> get achievements =>
      throw _privateConstructorUsedError; // 이 게임에서 달성한 업적
  bool get isValid => throw _privateConstructorUsedError;

  /// Create a copy of GameRecord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GameRecordCopyWith<GameRecord> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameRecordCopyWith<$Res> {
  factory $GameRecordCopyWith(
          GameRecord value, $Res Function(GameRecord) then) =
      _$GameRecordCopyWithImpl<$Res, GameRecord>;
  @useResult
  $Res call(
      {String id,
      String userId,
      int score,
      int playTime,
      DateTime timestamp,
      String gameMode,
      String difficulty,
      Map<String, dynamic> metadata,
      List<String> achievements,
      bool isValid});
}

/// @nodoc
class _$GameRecordCopyWithImpl<$Res, $Val extends GameRecord>
    implements $GameRecordCopyWith<$Res> {
  _$GameRecordCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GameRecord
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? score = null,
    Object? playTime = null,
    Object? timestamp = null,
    Object? gameMode = null,
    Object? difficulty = null,
    Object? metadata = null,
    Object? achievements = null,
    Object? isValid = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as int,
      playTime: null == playTime
          ? _value.playTime
          : playTime // ignore: cast_nullable_to_non_nullable
              as int,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      gameMode: null == gameMode
          ? _value.gameMode
          : gameMode // ignore: cast_nullable_to_non_nullable
              as String,
      difficulty: null == difficulty
          ? _value.difficulty
          : difficulty // ignore: cast_nullable_to_non_nullable
              as String,
      metadata: null == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      achievements: null == achievements
          ? _value.achievements
          : achievements // ignore: cast_nullable_to_non_nullable
              as List<String>,
      isValid: null == isValid
          ? _value.isValid
          : isValid // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GameRecordImplCopyWith<$Res>
    implements $GameRecordCopyWith<$Res> {
  factory _$$GameRecordImplCopyWith(
          _$GameRecordImpl value, $Res Function(_$GameRecordImpl) then) =
      __$$GameRecordImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      int score,
      int playTime,
      DateTime timestamp,
      String gameMode,
      String difficulty,
      Map<String, dynamic> metadata,
      List<String> achievements,
      bool isValid});
}

/// @nodoc
class __$$GameRecordImplCopyWithImpl<$Res>
    extends _$GameRecordCopyWithImpl<$Res, _$GameRecordImpl>
    implements _$$GameRecordImplCopyWith<$Res> {
  __$$GameRecordImplCopyWithImpl(
      _$GameRecordImpl _value, $Res Function(_$GameRecordImpl) _then)
      : super(_value, _then);

  /// Create a copy of GameRecord
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? score = null,
    Object? playTime = null,
    Object? timestamp = null,
    Object? gameMode = null,
    Object? difficulty = null,
    Object? metadata = null,
    Object? achievements = null,
    Object? isValid = null,
  }) {
    return _then(_$GameRecordImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as int,
      playTime: null == playTime
          ? _value.playTime
          : playTime // ignore: cast_nullable_to_non_nullable
              as int,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      gameMode: null == gameMode
          ? _value.gameMode
          : gameMode // ignore: cast_nullable_to_non_nullable
              as String,
      difficulty: null == difficulty
          ? _value.difficulty
          : difficulty // ignore: cast_nullable_to_non_nullable
              as String,
      metadata: null == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      achievements: null == achievements
          ? _value._achievements
          : achievements // ignore: cast_nullable_to_non_nullable
              as List<String>,
      isValid: null == isValid
          ? _value.isValid
          : isValid // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$GameRecordImpl extends _GameRecord {
  const _$GameRecordImpl(
      {required this.id,
      required this.userId,
      required this.score,
      required this.playTime,
      required this.timestamp,
      this.gameMode = 'classic',
      this.difficulty = 'normal',
      final Map<String, dynamic> metadata = const {},
      final List<String> achievements = const [],
      this.isValid = true})
      : _metadata = metadata,
        _achievements = achievements,
        super._();

  @override
  final String id;
  @override
  final String userId;
  @override
  final int score;
  @override
  final int playTime;
// 플레이 시간 (초)
  @override
  final DateTime timestamp;
  @override
  @JsonKey()
  final String gameMode;
// 'classic', 'timeAttack', 'endless'
  @override
  @JsonKey()
  final String difficulty;
// 'easy', 'normal', 'hard'
  final Map<String, dynamic> _metadata;
// 'easy', 'normal', 'hard'
  @override
  @JsonKey()
  Map<String, dynamic> get metadata {
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_metadata);
  }

// 게임별 상세 데이터
  final List<String> _achievements;
// 게임별 상세 데이터
  @override
  @JsonKey()
  List<String> get achievements {
    if (_achievements is EqualUnmodifiableListView) return _achievements;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_achievements);
  }

// 이 게임에서 달성한 업적
  @override
  @JsonKey()
  final bool isValid;

  @override
  String toString() {
    return 'GameRecord(id: $id, userId: $userId, score: $score, playTime: $playTime, timestamp: $timestamp, gameMode: $gameMode, difficulty: $difficulty, metadata: $metadata, achievements: $achievements, isValid: $isValid)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameRecordImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.score, score) || other.score == score) &&
            (identical(other.playTime, playTime) ||
                other.playTime == playTime) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.gameMode, gameMode) ||
                other.gameMode == gameMode) &&
            (identical(other.difficulty, difficulty) ||
                other.difficulty == difficulty) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata) &&
            const DeepCollectionEquality()
                .equals(other._achievements, _achievements) &&
            (identical(other.isValid, isValid) || other.isValid == isValid));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      score,
      playTime,
      timestamp,
      gameMode,
      difficulty,
      const DeepCollectionEquality().hash(_metadata),
      const DeepCollectionEquality().hash(_achievements),
      isValid);

  /// Create a copy of GameRecord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GameRecordImplCopyWith<_$GameRecordImpl> get copyWith =>
      __$$GameRecordImplCopyWithImpl<_$GameRecordImpl>(this, _$identity);
}

abstract class _GameRecord extends GameRecord {
  const factory _GameRecord(
      {required final String id,
      required final String userId,
      required final int score,
      required final int playTime,
      required final DateTime timestamp,
      final String gameMode,
      final String difficulty,
      final Map<String, dynamic> metadata,
      final List<String> achievements,
      final bool isValid}) = _$GameRecordImpl;
  const _GameRecord._() : super._();

  @override
  String get id;
  @override
  String get userId;
  @override
  int get score;
  @override
  int get playTime; // 플레이 시간 (초)
  @override
  DateTime get timestamp;
  @override
  String get gameMode; // 'classic', 'timeAttack', 'endless'
  @override
  String get difficulty; // 'easy', 'normal', 'hard'
  @override
  Map<String, dynamic> get metadata; // 게임별 상세 데이터
  @override
  List<String> get achievements; // 이 게임에서 달성한 업적
  @override
  bool get isValid;

  /// Create a copy of GameRecord
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GameRecordImplCopyWith<_$GameRecordImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
