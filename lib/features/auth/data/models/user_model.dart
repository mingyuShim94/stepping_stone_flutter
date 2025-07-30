import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import '../../domain/entities/user.dart';

/// User 엔티티의 데이터 모델
class UserModel {
  final String id;
  final String email;
  final String? displayName;
  final String? nickname;
  final String? photoUrl;
  final bool isAnonymous;
  final bool isEmailVerified;
  final int level;
  final int experience;
  final int totalScore;
  final int bestScore;
  final int totalPlays;
  final Duration totalPlayTime;
  final List<String> achievements;
  final DateTime? lastLoginAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final bool isActive;

  const UserModel({
    required this.id,
    required this.email,
    this.displayName,
    this.nickname,
    this.photoUrl,
    this.isAnonymous = false,
    this.isEmailVerified = false,
    this.level = 1,
    this.experience = 0,
    this.totalScore = 0,
    this.bestScore = 0,
    this.totalPlays = 0,
    this.totalPlayTime = Duration.zero,
    this.achievements = const [],
    this.lastLoginAt,
    this.createdAt,
    this.updatedAt,
    this.isActive = true,
  });

  /// Firebase User로부터 UserModel 생성
  factory UserModel.fromFirebaseUser(firebase_auth.User firebaseUser) {
    final now = DateTime.now();
    
    return UserModel(
      id: firebaseUser.uid,
      email: firebaseUser.email ?? '',
      displayName: firebaseUser.displayName,
      photoUrl: firebaseUser.photoURL,
      isAnonymous: firebaseUser.isAnonymous,
      isEmailVerified: firebaseUser.emailVerified,
      level: 1,
      experience: 0,
      totalScore: 0,
      bestScore: 0,
      totalPlays: 0,
      totalPlayTime: Duration.zero,
      achievements: const [],
      lastLoginAt: now,
      createdAt: now,
      updatedAt: now,
    );
  }

  /// Firestore 문서로부터 UserModel 생성
  factory UserModel.fromFirestore(Map<String, dynamic> doc, String id) {
    return UserModel(
      id: id,
      email: doc['email'] as String? ?? '',
      displayName: doc['displayName'] as String?,
      nickname: doc['nickname'] as String?,
      photoUrl: doc['photoUrl'] as String?,
      isAnonymous: doc['isAnonymous'] as bool? ?? false,
      isEmailVerified: doc['isEmailVerified'] as bool? ?? false,
      level: doc['level'] as int? ?? 1,
      experience: doc['experience'] as int? ?? 0,
      totalScore: doc['totalScore'] as int? ?? 0,
      bestScore: doc['bestScore'] as int? ?? 0,
      totalPlays: doc['totalPlays'] as int? ?? 0,
      totalPlayTime: Duration(
        milliseconds: doc['totalPlayTimeMs'] as int? ?? 0,
      ),
      achievements: List<String>.from(doc['achievements'] as List? ?? []),
      lastLoginAt: _timestampToDateTime(doc['lastLoginAt']),
      createdAt: _timestampToDateTime(doc['createdAt']),
      updatedAt: _timestampToDateTime(doc['updatedAt']),
    );
  }

  /// User 엔티티로부터 UserModel 생성
  factory UserModel.fromEntity(User user) {
    return UserModel(
      id: user.id,
      email: user.email,
      displayName: user.displayName,
      nickname: user.nickname,
      photoUrl: user.photoUrl,
      isAnonymous: user.isAnonymous,
      isEmailVerified: user.isEmailVerified,
      level: user.level,
      experience: user.experience,
      totalScore: user.totalScore,
      bestScore: user.bestScore,
      totalPlays: user.totalPlays,
      totalPlayTime: user.totalPlayTime,
      achievements: user.achievements,
      lastLoginAt: user.lastLoginAt,
      createdAt: user.createdAt,
      updatedAt: user.updatedAt,
    );
  }

  /// Firestore 저장을 위한 Map으로 변환
  Map<String, dynamic> toFirestore() {
    return {
      'email': email,
      'displayName': displayName,
      'nickname': nickname,
      'photoUrl': photoUrl,
      'isAnonymous': isAnonymous,
      'isEmailVerified': isEmailVerified,
      'level': level,
      'experience': experience,
      'totalScore': totalScore,
      'bestScore': bestScore,
      'totalPlays': totalPlays,
      'totalPlayTimeMs': totalPlayTime.inMilliseconds,
      'achievements': achievements,
      'lastLoginAt': lastLoginAt != null ? Timestamp.fromDate(lastLoginAt!) : null,
      'createdAt': createdAt != null ? Timestamp.fromDate(createdAt!) : null,
      'updatedAt': updatedAt != null ? Timestamp.fromDate(updatedAt!) : null,
    };
  }

  /// UserModel을 User 엔티티로 변환
  User toEntity() {
    return User(
      id: id,
      email: email,
      displayName: displayName,
      nickname: nickname,
      photoUrl: photoUrl,
      isAnonymous: isAnonymous,
      isEmailVerified: isEmailVerified,
      level: level,
      experience: experience,
      totalScore: totalScore,
      bestScore: bestScore,
      totalPlays: totalPlays,
      totalPlayTime: totalPlayTime,
      achievements: achievements,
      lastLoginAt: lastLoginAt,
      createdAt: createdAt,
      updatedAt: updatedAt,
      isActive: isActive,
    );
  }

  /// 사용자 프로필 업데이트를 위한 메서드
  UserModel updateProfile({
    String? displayName,
    String? nickname,
    String? photoUrl,
    bool? isEmailVerified,
  }) {
    return UserModel(
      id: id,
      email: email,
      displayName: displayName ?? this.displayName,
      nickname: nickname ?? this.nickname,
      photoUrl: photoUrl ?? this.photoUrl,
      isAnonymous: isAnonymous,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      level: level,
      experience: experience,
      totalScore: totalScore,
      bestScore: bestScore,
      totalPlays: totalPlays,
      totalPlayTime: totalPlayTime,
      achievements: achievements,
      lastLoginAt: lastLoginAt,
      createdAt: createdAt,
      updatedAt: DateTime.now(),
      isActive: isActive,
    );
  }

  /// 게임 통계 업데이트를 위한 메서드
  UserModel updateGameStats({
    int? newScore,
    Duration? playTime,
    List<String>? newAchievements,
  }) {
    final updatedTotalScore = totalScore + (newScore ?? 0);
    final updatedBestScore = newScore != null && newScore > bestScore 
        ? newScore 
        : bestScore;
    final updatedTotalPlays = totalPlays + 1;
    final updatedTotalPlayTime = totalPlayTime + (playTime ?? Duration.zero);
    
    // 새로운 업적 추가
    final updatedAchievements = [...achievements];
    if (newAchievements != null) {
      for (final achievement in newAchievements) {
        if (!updatedAchievements.contains(achievement)) {
          updatedAchievements.add(achievement);
        }
      }
    }
    
    return UserModel(
      id: id,
      email: email,
      displayName: displayName,
      nickname: nickname,
      photoUrl: photoUrl,
      isAnonymous: isAnonymous,
      isEmailVerified: isEmailVerified,
      level: level,
      experience: experience,
      totalScore: updatedTotalScore,
      bestScore: updatedBestScore,
      totalPlays: updatedTotalPlays,
      totalPlayTime: updatedTotalPlayTime,
      achievements: updatedAchievements,
      lastLoginAt: lastLoginAt,
      createdAt: createdAt,
      updatedAt: DateTime.now(),
      isActive: isActive,
    );
  }

  /// 레벨 업 계산을 위한 메서드
  UserModel updateLevel(int addedExperience) {
    final updatedExperience = experience + addedExperience;
    final newLevel = _calculateLevel(updatedExperience);
    
    return UserModel(
      id: id,
      email: email,
      displayName: displayName,
      nickname: nickname,
      photoUrl: photoUrl,
      isAnonymous: isAnonymous,
      isEmailVerified: isEmailVerified,
      level: newLevel,
      experience: updatedExperience,
      totalScore: totalScore,
      bestScore: bestScore,
      totalPlays: totalPlays,
      totalPlayTime: totalPlayTime,
      achievements: achievements,
      lastLoginAt: lastLoginAt,
      createdAt: createdAt,
      updatedAt: DateTime.now(),
      isActive: isActive,
    );
  }

  /// 경험치를 바탕으로 레벨 계산
  int _calculateLevel(int experience) {
    // 간단한 레벨 계산 공식 (필요에 따라 조정 가능)
    // 레벨 1: 0 경험치
    // 레벨 2: 100 경험치
    // 레벨 3: 300 경험치 (누적)
    // 레벨 4: 600 경험치 (누적)
    // 각 레벨에 필요한 경험치가 점점 증가
    
    if (experience < 100) return 1;
    if (experience < 300) return 2;
    if (experience < 600) return 3;
    if (experience < 1000) return 4;
    if (experience < 1500) return 5;
    
    // 레벨 6 이상은 500씩 증가
    return 5 + ((experience - 1500) ~/ 500) + 1;
  }

  /// Firestore Timestamp를 DateTime으로 변환하는 헬퍼 메서드
  static DateTime? _timestampToDateTime(dynamic timestamp) {
    if (timestamp == null) return null;
    
    if (timestamp is Timestamp) {
      return timestamp.toDate();
    }
    
    if (timestamp is DateTime) {
      return timestamp;
    }
    
    // null 반환
    return null;
  }
}