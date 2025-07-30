import 'package:dartz/dartz.dart';
import '../../domain/entities/game_record.dart';
import '../../domain/repositories/game_repository.dart';
import '../datasources/game_remote_datasource.dart';
import '../models/game_record_model.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/error/exceptions.dart';

/// 게임 리포지토리 구현
class GameRepositoryImpl implements GameRepository {
  final GameRemoteDataSource _remoteDataSource;

  GameRepositoryImpl({
    required GameRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Future<Either<Failure, GameRecord>> saveGameRecord(GameRecord record) async {
    try {
      final model = GameRecordModel.fromDomain(record);
      final savedModel = await _remoteDataSource.saveGameRecord(model);
      return Right(savedModel.toDomain());
    } on ServerException catch (e) {
      return Left(Failure.server(message: e.message));
    } on UnauthorizedException catch (e) {
      return Left(Failure.auth(message: e.message));
    } catch (e) {
      return Left(const Failure.server(message: '게임 기록 저장 중 알 수 없는 오류가 발생했습니다.'));
    }
  }

  @override
  Future<Either<Failure, List<GameRecord>>> getUserGameRecords(
    String userId, {
    int limit = 10,
  }) async {
    try {
      final models = await _remoteDataSource.getUserGameRecords(userId, limit: limit);
      final records = models.map((model) => model.toDomain()).toList();
      return Right(records);
    } on ServerException catch (e) {
      return Left(Failure.server(message: e.message));
    } catch (e) {
      return Left(const Failure.server(message: '사용자 게임 기록 조회 중 오류가 발생했습니다.'));
    }
  }

  @override
  Future<Either<Failure, List<GameRecord>>> getGlobalRanking({int limit = 100}) async {
    try {
      final models = await _remoteDataSource.getGlobalRanking(limit: limit);
      final records = models.map((model) => model.toDomain()).toList();
      return Right(records);
    } on ServerException catch (e) {
      return Left(Failure.server(message: e.message));
    } catch (e) {
      return Left(const Failure.server(message: '전체 랭킹 조회 중 오류가 발생했습니다.'));
    }
  }

  @override
  Future<Either<Failure, List<GameRecord>>> getDailyRanking({int limit = 100}) async {
    try {
      final models = await _remoteDataSource.getDailyRanking(limit: limit);
      final records = models.map((model) => model.toDomain()).toList();
      return Right(records);
    } on ServerException catch (e) {
      return Left(Failure.server(message: e.message));
    } catch (e) {
      return Left(const Failure.server(message: '일간 랭킹 조회 중 오류가 발생했습니다.'));
    }
  }

  @override
  Future<Either<Failure, GameRecord?>> getUserBestRecord(String userId) async {
    try {
      final model = await _remoteDataSource.getUserBestRecord(userId);
      if (model == null) {
        return const Right(null);
      }
      return Right(model.toDomain());
    } on ServerException catch (e) {
      return Left(Failure.server(message: e.message));
    } catch (e) {
      return Left(const Failure.server(message: '사용자 최고 기록 조회 중 오류가 발생했습니다.'));
    }
  }

  @override
  Future<Either<Failure, void>> updateUserStats(String userId, GameRecord record) async {
    try {
      final model = GameRecordModel.fromDomain(record);
      await _remoteDataSource.updateUserStats(userId, model);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(Failure.server(message: e.message));
    } catch (e) {
      return Left(const Failure.server(message: '사용자 통계 업데이트 중 오류가 발생했습니다.'));
    }
  }
}