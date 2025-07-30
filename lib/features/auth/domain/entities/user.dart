import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

/// 사용자 엔티티
@freezed
class User with _$User {
  const factory User({
    required String id,
    required String email,
    String? displayName,
    String? photoUrl,
    String? nickname,
    @Default(false) bool isAnonymous,
    @Default(false) bool isEmailVerified,
    @Default(1) int level,
    @Default(0) int experience,
    @Default(0) int totalScore,
    @Default(0) int bestScore,
    @Default(0) int totalPlays,
    @Default(Duration.zero) Duration totalPlayTime,
    @Default([]) List<String> achievements,
    DateTime? createdAt,
    DateTime? lastLoginAt,
    DateTime? updatedAt,
    @Default(true) bool isActive,
  }) = _User;
  
  const User._();
  
  /// 사용자 레벨 계산 (경험치 기반)
  int get calculatedLevel => (experience / 1000).floor() + 1;
  
  /// 다음 레벨까지 필요한 경험치
  int get experienceToNextLevel => 
      ((calculatedLevel) * 1000) - experience;
  
  /// 레벨 진행률 (0.0 ~ 1.0)
  double get levelProgress {
    final currentLevelExp = experience % 1000;
    return currentLevelExp / 1000.0;
  }
  
  /// 평균 점수
  double get averageScore {
    if (totalPlays == 0) return 0.0;
    return totalScore / totalPlays;
  }
  
  /// 게임 숙련도 (초보자/중급자/고급자/전문가)
  String get skillLevel {
    if (bestScore >= 10000) return '전문가';
    if (bestScore >= 5000) return '고급자';
    if (bestScore >= 1000) return '중급자';
    return '초보자';
  }
  
  /// 프로필 완성도 (0.0 ~ 1.0)
  double get profileCompleteness {
    double score = 0.0;
    if (displayName != null && displayName!.isNotEmpty) score += 0.2;
    if (nickname != null && nickname!.isNotEmpty) score += 0.2;
    if (photoUrl != null && photoUrl!.isNotEmpty) score += 0.2;
    if (totalPlays > 0) score += 0.2;
    if (achievements.isNotEmpty) score += 0.2;
    return score;
  }
}