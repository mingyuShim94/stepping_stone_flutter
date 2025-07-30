/// 앱 전역 상수 정의
class AppConstants {
  // 앱 정보
  static const String appName = 'Stepping Stone Game';
  static const String appVersion = '1.0.0';
  
  // 게임 관련 상수
  static const String gameUrl = 'https://stepping-stone.pages.dev/';
  static const Duration gameLoadTimeout = Duration(seconds: 30);
  
  // 로컬 저장소 키
  static const String userTokenKey = 'user_token';
  static const String userDataKey = 'user_data';
  static const String gameSettingsKey = 'game_settings';
  static const String themeKey = 'theme_mode';
  
  // 네트워크 상수
  static const Duration networkTimeout = Duration(seconds: 30);
  static const int maxRetryAttempts = 3;
  
  // UI 상수
  static const double defaultPadding = 16.0;
  static const double defaultRadius = 8.0;
  static const Duration animationDuration = Duration(milliseconds: 300);
  
  // 게임 모드
  static const String classicMode = 'classic';
  static const String timeAttackMode = 'timeAttack';
  static const String endlessMode = 'endless';
  static const String challengeMode = 'challenge';
  
  // 업적 카테고리
  static const String scoreAchievement = 'score';
  static const String timeAchievement = 'time';
  static const String socialAchievement = 'social';
}