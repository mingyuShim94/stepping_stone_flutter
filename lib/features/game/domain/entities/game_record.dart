import 'package:freezed_annotation/freezed_annotation.dart';

part 'game_record.freezed.dart';

/// 게임 기록 엔티티
@freezed
class GameRecord with _$GameRecord {
  const factory GameRecord({
    required String id,
    required String userId,
    required int score,
    required int playTime, // 플레이 시간 (초)
    required DateTime timestamp,
    @Default('classic') String gameMode, // 'classic', 'timeAttack', 'endless'
    @Default('normal') String difficulty, // 'easy', 'normal', 'hard'
    @Default({}) Map<String, dynamic> metadata, // 게임별 상세 데이터
    @Default([]) List<String> achievements, // 이 게임에서 달성한 업적
    @Default(true) bool isValid, // 치팅 검증 통과 여부
  }) = _GameRecord;

  const GameRecord._();

  /// 점수를 포맷된 문자열로 반환
  String get formattedScore => score.toString().replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
        (Match m) => '${m[1]},',
      );

  /// 플레이 시간을 분:초 형식으로 반환
  String get formattedPlayTime {
    final minutes = playTime ~/ 60;
    final seconds = playTime % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  /// 게임 모드를 한국어로 반환
  String get gameModeName {
    switch (gameMode) {
      case 'classic':
        return '클래식';
      case 'timeAttack':
        return '타임어택';
      case 'endless':
        return '무한모드';
      default:
        return gameMode;
    }
  }

  /// 난이도를 한국어로 반환
  String get difficultyName {
    switch (difficulty) {
      case 'easy':
        return '쉬움';
      case 'normal':
        return '보통';
      case 'hard':
        return '어려움';
      default:
        return difficulty;
    }
  }

  /// 메타데이터에서 특정 값 가져오기
  T? getMetadata<T>(String key) {
    final value = metadata[key];
    return value is T ? value : null;
  }

  /// 점프 횟수 (메타데이터에서)
  int get jumps => getMetadata<int>('jumps') ?? 0;

  /// 떨어진 횟수 (메타데이터에서)
  int get falls => getMetadata<int>('falls') ?? 0;

  /// 최대 콤보 (메타데이터에서)
  int get maxCombo => getMetadata<int>('maxCombo') ?? 0;

  /// 정확도 (메타데이터에서)
  double get accuracy => getMetadata<double>('accuracy') ?? 0.0;

  /// 정확도를 백분율 문자열로 반환
  String get formattedAccuracy => '${(accuracy * 100).toStringAsFixed(1)}%';
}