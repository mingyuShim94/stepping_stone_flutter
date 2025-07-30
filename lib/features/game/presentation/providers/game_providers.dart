import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../data/datasources/game_remote_datasource.dart';
import '../../data/repositories/game_repository_impl.dart';
import '../../domain/repositories/game_repository.dart';
import '../../domain/usecases/save_game_record.dart';
import '../../domain/usecases/get_ranking.dart';
import '../../domain/entities/game_record.dart';
import '../../../auth/presentation/providers/auth_providers.dart';

part 'game_providers.g.dart';

/// Firebase 인스턴스 Provider들
@riverpod
FirebaseFirestore firestore(FirestoreRef ref) => FirebaseFirestore.instance;

/// 게임 데이터 소스 Provider
@riverpod
GameRemoteDataSource gameRemoteDataSource(GameRemoteDataSourceRef ref) {
  return GameRemoteDataSourceImpl(
    firestore: ref.read(firestoreProvider),
    auth: ref.read(firebaseAuthProvider),
  );
}

/// 게임 리포지토리 Provider
@riverpod
GameRepository gameRepository(GameRepositoryRef ref) {
  return GameRepositoryImpl(
    remoteDataSource: ref.read(gameRemoteDataSourceProvider),
  );
}

/// 게임 기록 저장 Use Case Provider
@riverpod
SaveGameRecord saveGameRecord(SaveGameRecordRef ref) {
  return SaveGameRecord(ref.read(gameRepositoryProvider));
}

/// 랭킹 조회 Use Case Provider
@riverpod
GetRanking getRanking(GetRankingRef ref) {
  return GetRanking(ref.read(gameRepositoryProvider));
}

/// 전체 랭킹 Provider
@riverpod
Future<List<GameRecord>> globalRanking(GlobalRankingRef ref, {int limit = 100}) async {
  final getRankingUseCase = ref.read(getRankingProvider);
  final result = await getRankingUseCase.getGlobalRanking(limit: limit);
  
  return result.fold(
    (failure) => throw Exception(failure.when(
      network: (message, code) => '인터넷 연결을 확인해주세요',
      server: (message, code) => '서버에 일시적인 문제가 발생했습니다',
      auth: (message, code) => '로그인이 필요합니다',
      game: (message, code) => '게임에 문제가 발생했습니다',
      cache: (message, code) => '데이터를 불러올 수 없습니다',
      validation: (message, code) => message,
      permission: (message, code) => '권한이 필요합니다',
      unknown: (message, code) => '알 수 없는 오류가 발생했습니다',
    )),
    (records) => records,
  );
}

/// 일간 랭킹 Provider
@riverpod
Future<List<GameRecord>> dailyRanking(DailyRankingRef ref, {int limit = 100}) async {
  final getRankingUseCase = ref.read(getRankingProvider);
  final result = await getRankingUseCase.getDailyRanking(limit: limit);
  
  return result.fold(
    (failure) => throw Exception(failure.when(
      network: (message, code) => '인터넷 연결을 확인해주세요',
      server: (message, code) => '서버에 일시적인 문제가 발생했습니다',
      auth: (message, code) => '로그인이 필요합니다',
      game: (message, code) => '게임에 문제가 발생했습니다',
      cache: (message, code) => '데이터를 불러올 수 없습니다',
      validation: (message, code) => message,
      permission: (message, code) => '권한이 필요합니다',
      unknown: (message, code) => '알 수 없는 오류가 발생했습니다',
    )),
    (records) => records,
  );
}

/// 사용자 게임 기록 Provider
@riverpod
Future<List<GameRecord>> userGameRecords(
  UserGameRecordsRef ref,
  String userId, {
  int limit = 10,
}) async {
  final repository = ref.read(gameRepositoryProvider);
  final result = await repository.getUserGameRecords(userId, limit: limit);
  
  return result.fold(
    (failure) => throw Exception(failure.when(
      network: (message, code) => '인터넷 연결을 확인해주세요',
      server: (message, code) => '서버에 일시적인 문제가 발생했습니다',
      auth: (message, code) => '로그인이 필요합니다',
      game: (message, code) => '게임에 문제가 발생했습니다',
      cache: (message, code) => '데이터를 불러올 수 없습니다',
      validation: (message, code) => message,
      permission: (message, code) => '권한이 필요합니다',
      unknown: (message, code) => '알 수 없는 오류가 발생했습니다',
    )),
    (records) => records,
  );
}

/// 사용자 최고 기록 Provider
@riverpod
Future<GameRecord?> userBestRecord(UserBestRecordRef ref, String userId) async {
  final repository = ref.read(gameRepositoryProvider);
  final result = await repository.getUserBestRecord(userId);
  
  return result.fold(
    (failure) => throw Exception(failure.when(
      network: (message, code) => '인터넷 연결을 확인해주세요',
      server: (message, code) => '서버에 일시적인 문제가 발생했습니다',
      auth: (message, code) => '로그인이 필요합니다',
      game: (message, code) => '게임에 문제가 발생했습니다',
      cache: (message, code) => '데이터를 불러올 수 없습니다',
      validation: (message, code) => message,
      permission: (message, code) => '권한이 필요합니다',
      unknown: (message, code) => '알 수 없는 오류가 발생했습니다',
    )),
    (record) => record,
  );
}

/// 사용자 랭킹 데이터 Provider
@riverpod
Future<UserRankingData> userRankingData(UserRankingDataRef ref, String userId) async {
  final getRankingUseCase = ref.read(getRankingProvider);
  final result = await getRankingUseCase.getUserRanking(userId);
  
  return result.fold(
    (failure) => throw Exception(failure.when(
      network: (message, code) => '인터넷 연결을 확인해주세요',
      server: (message, code) => '서버에 일시적인 문제가 발생했습니다',
      auth: (message, code) => '로그인이 필요합니다',
      game: (message, code) => '게임에 문제가 발생했습니다',
      cache: (message, code) => '데이터를 불러올 수 없습니다',
      validation: (message, code) => message,
      permission: (message, code) => '권한이 필요합니다',
      unknown: (message, code) => '알 수 없는 오류가 발생했습니다',
    )),
    (data) => data,
  );
}

/// 현재 사용자의 게임 기록 Provider (로그인한 사용자)
@riverpod
Future<List<GameRecord>> currentUserGameRecords(
  CurrentUserGameRecordsRef ref, {
  int limit = 10,
}) async {
  final user = ref.read(firebaseAuthProvider).currentUser;
  if (user == null) {
    return [];
  }
  
  return ref.read(userGameRecordsProvider(user.uid, limit: limit).future);
}

/// 현재 사용자의 최고 기록 Provider
@riverpod
Future<GameRecord?> currentUserBestRecord(CurrentUserBestRecordRef ref) async {
  final user = ref.read(firebaseAuthProvider).currentUser;
  if (user == null) {
    return null;
  }
  
  return ref.read(userBestRecordProvider(user.uid).future);
}

/// 현재 사용자의 랭킹 데이터 Provider
@riverpod
Future<UserRankingData?> currentUserRankingData(CurrentUserRankingDataRef ref) async {
  final user = ref.read(firebaseAuthProvider).currentUser;
  if (user == null) {
    return null;
  }
  
  return ref.read(userRankingDataProvider(user.uid).future);
}