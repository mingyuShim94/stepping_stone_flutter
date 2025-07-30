import 'package:dartz/dartz.dart';
import '../entities/game_record.dart';
import '../repositories/game_repository.dart';
import '../../../../core/error/failures.dart';

/// 랭킹 조회 Use Case
class GetRanking {
  final GameRepository _repository;

  GetRanking(this._repository);

  /// 전체 랭킹 조회
  Future<Either<Failure, List<GameRecord>>> getGlobalRanking({int limit = 100}) {
    return _repository.getGlobalRanking(limit: limit);
  }

  /// 일간 랭킹 조회
  Future<Either<Failure, List<GameRecord>>> getDailyRanking({int limit = 100}) {
    return _repository.getDailyRanking(limit: limit);
  }

  /// 사용자 기록 및 순위 조회
  Future<Either<Failure, UserRankingData>> getUserRanking(String userId) async {
    // 병렬로 데이터 조회
    final results = await Future.wait([
      _repository.getUserBestRecord(userId),
      _repository.getGlobalRanking(limit: 1000), // 순위 계산을 위해 더 많이 조회
      _repository.getUserGameRecords(userId, limit: 10),
    ]);

    final bestRecordResult = results[0] as Either<Failure, GameRecord?>;
    final globalRankingResult = results[1] as Either<Failure, List<GameRecord>>;
    final userRecordsResult = results[2] as Either<Failure, List<GameRecord>>;

    // 실패 확인
    final bestRecord = bestRecordResult.fold(
      (failure) => null,
      (record) => record,
    );

    final globalRanking = globalRankingResult.fold(
      (failure) => <GameRecord>[],
      (records) => records,
    );

    final userRecords = userRecordsResult.fold(
      (failure) => <GameRecord>[],
      (records) => records,
    );

    // 순위 계산
    int? globalRank;
    if (bestRecord != null && globalRanking.isNotEmpty) {
      globalRank = globalRanking.indexWhere((record) => record.userId == userId) + 1;
      if (globalRank == 0) globalRank = null; // 랭킹에 없음
    }

    return Right(UserRankingData(
      bestRecord: bestRecord,
      globalRank: globalRank,
      recentRecords: userRecords,
      totalPlayers: globalRanking.length,
    ));
  }
}

/// 사용자 랭킹 데이터
class UserRankingData {
  final GameRecord? bestRecord;
  final int? globalRank;
  final List<GameRecord> recentRecords;
  final int totalPlayers;

  const UserRankingData({
    required this.bestRecord,
    required this.globalRank,
    required this.recentRecords,
    required this.totalPlayers,
  });

  /// 랭킹 백분율 (상위 몇 %)
  double? get rankPercentage {
    if (globalRank == null || totalPlayers == 0) return null;
    return (globalRank! / totalPlayers) * 100;
  }

  /// 순위를 텍스트로 표시
  String get rankText {
    if (globalRank == null) return '순위 없음';
    return '$globalRank위 / $totalPlayers명';
  }

  /// 순위 백분율을 텍스트로 표시
  String get percentileText {
    final percentage = rankPercentage;
    if (percentage == null) return '';
    return '상위 ${percentage.toStringAsFixed(1)}%';
  }
}