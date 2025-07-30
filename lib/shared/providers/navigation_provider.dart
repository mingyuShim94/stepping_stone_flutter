import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'navigation_provider.g.dart';

/// 네비게이션 인덱스 Provider
@riverpod
class NavigationNotifier extends _$NavigationNotifier {
  @override
  int build() {
    return 0; // 기본값: 첫 번째 탭 (게임)
  }

  /// 탭 변경
  void setIndex(int index) {
    if (index >= 0 && index < 5) { // 0: 게임, 1: 랭킹, 2: 친구, 3: 상점, 4: 프로필
      state = index;
    }
  }

  /// 게임 탭으로 이동
  void goToGame() => setIndex(0);

  /// 랭킹 탭으로 이동
  void goToRanking() => setIndex(1);

  /// 친구 탭으로 이동
  void goToFriends() => setIndex(2);

  /// 상점 탭으로 이동
  void goToShop() => setIndex(3);

  /// 프로필 탭으로 이동
  void goToProfile() => setIndex(4);
}

/// 현재 활성 탭 확인 Provider들
@riverpod
bool isGameTab(Ref ref) {
  return ref.watch(navigationNotifierProvider) == 0;
}

@riverpod
bool isRankingTab(Ref ref) {
  return ref.watch(navigationNotifierProvider) == 1;
}

@riverpod
bool isFriendsTab(Ref ref) {
  return ref.watch(navigationNotifierProvider) == 2;
}

@riverpod
bool isShopTab(Ref ref) {
  return ref.watch(navigationNotifierProvider) == 3;
}

@riverpod
bool isProfileTab(Ref ref) {
  return ref.watch(navigationNotifierProvider) == 4;
}