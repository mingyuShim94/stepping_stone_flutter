// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_record_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GameRecordModel _$GameRecordModelFromJson(Map<String, dynamic> json) {
  return _GameRecordModel.fromJson(json);
}

/// @nodoc
mixin _$GameRecordModel {
  String? get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  int get score => throw _privateConstructorUsedError;
  int get playTime => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get timestamp => throw _privateConstructorUsedError;
  String get gameMode => throw _privateConstructorUsedError;
  String get difficulty => throw _privateConstructorUsedError;
  Map<String, dynamic> get metadata => throw _privateConstructorUsedError;
  List<String> get achievements => throw _privateConstructorUsedError;
  bool get isValid => throw _privateConstructorUsedError;

  /// Serializes this GameRecordModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GameRecordModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GameRecordModelCopyWith<GameRecordModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameRecordModelCopyWith<$Res> {
  factory $GameRecordModelCopyWith(
          GameRecordModel value, $Res Function(GameRecordModel) then) =
      _$GameRecordModelCopyWithImpl<$Res, GameRecordModel>;
  @useResult
  $Res call(
      {String? id,
      String userId,
      int score,
      int playTime,
      @TimestampConverter() DateTime timestamp,
      String gameMode,
      String difficulty,
      Map<String, dynamic> metadata,
      List<String> achievements,
      bool isValid});
}

/// @nodoc
class _$GameRecordModelCopyWithImpl<$Res, $Val extends GameRecordModel>
    implements $GameRecordModelCopyWith<$Res> {
  _$GameRecordModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GameRecordModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
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
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
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
abstract class _$$GameRecordModelImplCopyWith<$Res>
    implements $GameRecordModelCopyWith<$Res> {
  factory _$$GameRecordModelImplCopyWith(_$GameRecordModelImpl value,
          $Res Function(_$GameRecordModelImpl) then) =
      __$$GameRecordModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String userId,
      int score,
      int playTime,
      @TimestampConverter() DateTime timestamp,
      String gameMode,
      String difficulty,
      Map<String, dynamic> metadata,
      List<String> achievements,
      bool isValid});
}

/// @nodoc
class __$$GameRecordModelImplCopyWithImpl<$Res>
    extends _$GameRecordModelCopyWithImpl<$Res, _$GameRecordModelImpl>
    implements _$$GameRecordModelImplCopyWith<$Res> {
  __$$GameRecordModelImplCopyWithImpl(
      _$GameRecordModelImpl _value, $Res Function(_$GameRecordModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of GameRecordModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
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
    return _then(_$GameRecordModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
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
@JsonSerializable()
class _$GameRecordModelImpl extends _GameRecordModel {
  const _$GameRecordModelImpl(
      {this.id,
      required this.userId,
      required this.score,
      required this.playTime,
      @TimestampConverter() required this.timestamp,
      this.gameMode = 'classic',
      this.difficulty = 'normal',
      final Map<String, dynamic> metadata = const {},
      final List<String> achievements = const [],
      this.isValid = true})
      : _metadata = metadata,
        _achievements = achievements,
        super._();

  factory _$GameRecordModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$GameRecordModelImplFromJson(json);

  @override
  final String? id;
  @override
  final String userId;
  @override
  final int score;
  @override
  final int playTime;
  @override
  @TimestampConverter()
  final DateTime timestamp;
  @override
  @JsonKey()
  final String gameMode;
  @override
  @JsonKey()
  final String difficulty;
  final Map<String, dynamic> _metadata;
  @override
  @JsonKey()
  Map<String, dynamic> get metadata {
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_metadata);
  }

  final List<String> _achievements;
  @override
  @JsonKey()
  List<String> get achievements {
    if (_achievements is EqualUnmodifiableListView) return _achievements;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_achievements);
  }

  @override
  @JsonKey()
  final bool isValid;

  @override
  String toString() {
    return 'GameRecordModel(id: $id, userId: $userId, score: $score, playTime: $playTime, timestamp: $timestamp, gameMode: $gameMode, difficulty: $difficulty, metadata: $metadata, achievements: $achievements, isValid: $isValid)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameRecordModelImpl &&
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

  @JsonKey(includeFromJson: false, includeToJson: false)
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

  /// Create a copy of GameRecordModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GameRecordModelImplCopyWith<_$GameRecordModelImpl> get copyWith =>
      __$$GameRecordModelImplCopyWithImpl<_$GameRecordModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GameRecordModelImplToJson(
      this,
    );
  }
}

abstract class _GameRecordModel extends GameRecordModel {
  const factory _GameRecordModel(
      {final String? id,
      required final String userId,
      required final int score,
      required final int playTime,
      @TimestampConverter() required final DateTime timestamp,
      final String gameMode,
      final String difficulty,
      final Map<String, dynamic> metadata,
      final List<String> achievements,
      final bool isValid}) = _$GameRecordModelImpl;
  const _GameRecordModel._() : super._();

  factory _GameRecordModel.fromJson(Map<String, dynamic> json) =
      _$GameRecordModelImpl.fromJson;

  @override
  String? get id;
  @override
  String get userId;
  @override
  int get score;
  @override
  int get playTime;
  @override
  @TimestampConverter()
  DateTime get timestamp;
  @override
  String get gameMode;
  @override
  String get difficulty;
  @override
  Map<String, dynamic> get metadata;
  @override
  List<String> get achievements;
  @override
  bool get isValid;

  /// Create a copy of GameRecordModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GameRecordModelImplCopyWith<_$GameRecordModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
