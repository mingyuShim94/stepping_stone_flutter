import 'package:dartz/dartz.dart';
import '../entities/game_record.dart';
import '../repositories/game_repository.dart';
import '../../../../core/error/failures.dart';

/// 게임 기록 저장 Use Case
class SaveGameRecord {
  final GameRepository _repository;

  SaveGameRecord(this._repository);

  /// 게임 기록을 저장하고 사용자 통계를 업데이트
  Future<Either<Failure, GameRecord>> call(SaveGameRecordParams params) async {
    // 기본 검증
    if (params.score < 0) {
      return const Left(Failure.validation(message: '점수는 0 이상이어야 합니다.'));
    }
    
    if (params.playTime < 0) {
      return const Left(Failure.validation(message: '플레이 시간은 0 이상이어야 합니다.'));
    }

    // 게임 기록 생성
    final record = GameRecord(
      id: '', // 저장 시 자동 생성
      userId: params.userId,
      score: params.score,
      playTime: params.playTime,
      timestamp: DateTime.now(),
      gameMode: params.gameMode,
      difficulty: params.difficulty,
      metadata: params.metadata,
      achievements: params.achievements,
      isValid: params.isValid,
    );

    // 게임 기록 저장
    final saveResult = await _repository.saveGameRecord(record);
    
    return saveResult.fold(
      (failure) => Left(failure),
      (savedRecord) async {
        // 사용자 통계 업데이트
        final statsResult = await _repository.updateUserStats(params.userId, savedRecord);
        
        return statsResult.fold(
          // 통계 업데이트 실패해도 기록 저장은 성공으로 간주
          (failure) => Right(savedRecord),
          (_) => Right(savedRecord),
        );
      },
    );
  }
}

/// 게임 기록 저장 파라미터
class SaveGameRecordParams {
  final String userId;
  final int score;
  final int playTime;
  final String gameMode;
  final String difficulty;
  final Map<String, dynamic> metadata;
  final List<String> achievements;
  final bool isValid;

  const SaveGameRecordParams({
    required this.userId,
    required this.score,
    required this.playTime,
    this.gameMode = 'classic',
    this.difficulty = 'normal',
    this.metadata = const {},
    this.achievements = const [],
    this.isValid = true,
  });

  /// Three.js 게임에서 오는 데이터를 파라미터로 변환
  factory SaveGameRecordParams.fromGameData({
    required String userId,
    required Map<String, dynamic> gameData,
  }) {
    return SaveGameRecordParams(
      userId: userId,
      score: gameData['score'] as int? ?? 0,
      playTime: gameData['playTime'] as int? ?? 0,
      gameMode: gameData['gameMode'] as String? ?? 'classic',
      difficulty: gameData['difficulty'] as String? ?? 'normal',
      metadata: {
        'jumps': gameData['jumps'] as int? ?? 0,
        'falls': gameData['falls'] as int? ?? 0,
        'maxCombo': gameData['maxCombo'] as int? ?? 0,
        'accuracy': gameData['accuracy'] as double? ?? 0.0,
        'powerupsUsed': gameData['powerupsUsed'] as List<String>? ?? <String>[],
        'specialEvents': gameData['specialEvents'] as List<String>? ?? <String>[],
      },
      achievements: gameData['achievements'] as List<String>? ?? <String>[],
      isValid: gameData['isValid'] as bool? ?? true,
    );
  }
}