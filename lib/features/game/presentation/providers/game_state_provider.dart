import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/game_record.dart';
import '../../domain/usecases/save_game_record.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import 'game_providers.dart';

part 'game_state_provider.freezed.dart';
part 'game_state_provider.g.dart';

/// 게임 상태
@freezed
class GameState with _$GameState {
  const factory GameState({
    @Default(false) bool isPlaying,
    @Default(false) bool isPaused,
    @Default(false) bool isGameOver,
    @Default(false) bool isSaving,
    GameRecord? lastGameRecord,
    String? errorMessage,
  }) = _GameState;
}

/// 게임 상태 Provider
@riverpod
class GameStateNotifier extends _$GameStateNotifier {
  @override
  GameState build() {
    return const GameState();
  }

  /// 게임 시작
  void startGame() {
    state = state.copyWith(
      isPlaying: true,
      isPaused: false,
      isGameOver: false,
      errorMessage: null,
    );
  }

  /// 게임 일시정지
  void pauseGame() {
    state = state.copyWith(isPaused: true);
  }

  /// 게임 재개
  void resumeGame() {
    state = state.copyWith(isPaused: false);
  }

  /// 게임 종료
  void endGame() {
    state = state.copyWith(
      isPlaying: false,
      isPaused: false,
      isGameOver: true,
    );
  }

  /// 게임 리셋
  void resetGame() {
    state = const GameState();
  }

  /// 게임 결과 저장
  Future<bool> saveGameResult(Map<String, dynamic> gameData) async {
    final user = ref.read(firebaseAuthProvider).currentUser;
    if (user == null) {
      state = state.copyWith(
        errorMessage: '로그인이 필요합니다.',
      );
      return false;
    }

    state = state.copyWith(
      isSaving: true,
      errorMessage: null,
    );

    try {
      final saveGameUseCase = ref.read(saveGameRecordProvider);
      final params = SaveGameRecordParams.fromGameData(
        userId: user.uid,
        gameData: gameData,
      );

      final result = await saveGameUseCase.call(params);
      
      return result.fold(
        (failure) {
          state = state.copyWith(
            isSaving: false,
            errorMessage: failure.when(
            network: (message, code) => '인터넷 연결을 확인해주세요',
            server: (message, code) => '서버에 일시적인 문제가 발생했습니다',
            auth: (message, code) => '로그인이 필요합니다',
            game: (message, code) => '게임에 문제가 발생했습니다',
            cache: (message, code) => '데이터를 불러올 수 없습니다',
            validation: (message, code) => message,
            permission: (message, code) => '권한이 필요합니다',
            unknown: (message, code) => '알 수 없는 오류가 발생했습니다',
          ),
          );
          return false;
        },
        (record) {
          state = state.copyWith(
            isSaving: false,
            lastGameRecord: record,
            isGameOver: true,
          );

          // 관련 Provider들 새로고침
          ref.invalidate(currentUserGameRecordsProvider);
          ref.invalidate(currentUserBestRecordProvider);
          ref.invalidate(currentUserRankingDataProvider);
          ref.invalidate(globalRankingProvider);
          ref.invalidate(dailyRankingProvider);

          return true;
        },
      );
    } catch (e) {
      state = state.copyWith(
        isSaving: false,
        errorMessage: '게임 결과 저장 중 오류가 발생했습니다.',
      );
      return false;
    }
  }

  /// 에러 메시지 클리어
  void clearError() {
    state = state.copyWith(errorMessage: null);
  }
}

/// JavaScript Bridge용 게임 이벤트 Provider
@riverpod
class GameBridgeNotifier extends _$GameBridgeNotifier {
  @override
  Map<String, dynamic> build() {
    return {};
  }

  /// JavaScript에서 호출할 게임 시작 이벤트
  void onGameStart() {
    ref.read(gameStateNotifierProvider.notifier).startGame();
  }

  /// JavaScript에서 호출할 게임 일시정지 이벤트
  void onGamePause() {
    ref.read(gameStateNotifierProvider.notifier).pauseGame();
  }

  /// JavaScript에서 호출할 게임 재개 이벤트
  void onGameResume() {
    ref.read(gameStateNotifierProvider.notifier).resumeGame();
  }

  /// JavaScript에서 호출할 게임 종료 이벤트
  Future<void> onGameEnd(Map<String, dynamic> gameData) async {
    ref.read(gameStateNotifierProvider.notifier).endGame();
    await ref.read(gameStateNotifierProvider.notifier).saveGameResult(gameData);
  }

  /// JavaScript에서 호출할 점수 업데이트 이벤트
  void onScoreUpdate(int score) {
    state = {...state, 'currentScore': score};
  }

  /// JavaScript에서 호출할 진행률 업데이트 이벤트
  void onProgressUpdate(double progress) {
    state = {...state, 'progress': progress};
  }

  /// JavaScript에서 호출할 아이템 사용 이벤트
  void onItemUsed(String itemType) {
    final usedItems = List<String>.from(state['usedItems'] ?? []);
    usedItems.add(itemType);
    state = {...state, 'usedItems': usedItems};
  }

  /// Flutter에서 JavaScript로 이벤트 전송용 메소드들
  Map<String, dynamic> getFlutterToJSEvents() {
    final gameState = ref.read(gameStateNotifierProvider);
    
    return {
      'gameState': {
        'isPlaying': gameState.isPlaying,
        'isPaused': gameState.isPaused,
        'isGameOver': gameState.isGameOver,
      },
      'commands': {
        'start': !gameState.isPlaying && !gameState.isGameOver,
        'pause': gameState.isPlaying && !gameState.isPaused,
        'resume': gameState.isPlaying && gameState.isPaused,
        'reset': gameState.isGameOver,
      },
    };
  }
}