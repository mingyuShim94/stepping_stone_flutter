import 'package:dartz/dartz.dart';
import '../entities/game_record.dart';
import '../../../../core/error/failures.dart';

/// 게임 리포지토리 인터페이스
abstract class GameRepository {
  /// 게임 기록 저장
  Future<Either<Failure, GameRecord>> saveGameRecord(GameRecord record);
  
  /// 사용자의 게임 기록 목록 조회
  Future<Either<Failure, List<GameRecord>>> getUserGameRecords(
    String userId, {
    int limit = 10,
  });
  
  /// 전체 랭킹 조회
  Future<Either<Failure, List<GameRecord>>> getGlobalRanking({int limit = 100});
  
  /// 일간 랭킹 조회
  Future<Either<Failure, List<GameRecord>>> getDailyRanking({int limit = 100});
  
  /// 사용자 최고 기록 조회
  Future<Either<Failure, GameRecord?>> getUserBestRecord(String userId);
  
  /// 사용자 통계 업데이트
  Future<Either<Failure, void>> updateUserStats(String userId, GameRecord record);
}