// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_record_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GameRecordModelImpl _$$GameRecordModelImplFromJson(
        Map<String, dynamic> json) =>
    _$GameRecordModelImpl(
      id: json['id'] as String?,
      userId: json['userId'] as String,
      score: (json['score'] as num).toInt(),
      playTime: (json['playTime'] as num).toInt(),
      timestamp:
          const TimestampConverter().fromJson(json['timestamp'] as Timestamp),
      gameMode: json['gameMode'] as String? ?? 'classic',
      difficulty: json['difficulty'] as String? ?? 'normal',
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
      achievements: (json['achievements'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      isValid: json['isValid'] as bool? ?? true,
    );

Map<String, dynamic> _$$GameRecordModelImplToJson(
        _$GameRecordModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'score': instance.score,
      'playTime': instance.playTime,
      'timestamp': const TimestampConverter().toJson(instance.timestamp),
      'gameMode': instance.gameMode,
      'difficulty': instance.difficulty,
      'metadata': instance.metadata,
      'achievements': instance.achievements,
      'isValid': instance.isValid,
    };
