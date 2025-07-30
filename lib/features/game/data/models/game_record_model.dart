import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/game_record.dart';

part 'game_record_model.freezed.dart';
part 'game_record_model.g.dart';

/// 게임 기록 데이터 모델
@freezed
class GameRecordModel with _$GameRecordModel {
  const GameRecordModel._();
  
  const factory GameRecordModel({
    String? id,
    required String userId,
    required int score,
    required int playTime,
    @TimestampConverter() required DateTime timestamp,
    @Default('classic') String gameMode,
    @Default('normal') String difficulty,
    @Default({}) Map<String, dynamic> metadata,
    @Default([]) List<String> achievements,
    @Default(true) bool isValid,
  }) = _GameRecordModel;

  factory GameRecordModel.fromJson(Map<String, dynamic> json) =>
      _$GameRecordModelFromJson(json);

  /// Firestore 문서에서 모델 생성
  factory GameRecordModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data()!;
    return GameRecordModel.fromJson(data).copyWith(id: snapshot.id);
  }

  /// Firestore 문서로 변환
  Map<String, dynamic> toFirestore() {
    final json = toJson();
    json.remove('id'); // Firestore에서 ID는 문서 ID로 관리
    return json;
  }

  /// 도메인 엔티티로 변환
  GameRecord toDomain() {
    return GameRecord(
      id: id ?? '',
      userId: userId,
      score: score,
      playTime: playTime,
      timestamp: timestamp,
      gameMode: gameMode,
      difficulty: difficulty,
      metadata: metadata,
      achievements: achievements,
      isValid: isValid,
    );
  }

  /// 도메인 엔티티에서 모델 생성
  factory GameRecordModel.fromDomain(GameRecord record) {
    return GameRecordModel(
      id: record.id.isEmpty ? null : record.id,
      userId: record.userId,
      score: record.score,
      playTime: record.playTime,
      timestamp: record.timestamp,
      gameMode: record.gameMode,
      difficulty: record.difficulty,
      metadata: record.metadata,
      achievements: record.achievements,
      isValid: record.isValid,
    );
  }
}

/// Timestamp 변환기
class TimestampConverter implements JsonConverter<DateTime, Timestamp> {
  const TimestampConverter();

  @override
  DateTime fromJson(Timestamp timestamp) => timestamp.toDate();

  @override
  Timestamp toJson(DateTime dateTime) => Timestamp.fromDate(dateTime);
}