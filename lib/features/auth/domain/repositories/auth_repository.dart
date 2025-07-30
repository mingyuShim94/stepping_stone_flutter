import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/user.dart';
import '../entities/auth_result.dart';

/// 인증 Repository 인터페이스
abstract class AuthRepository {
  /// 현재 사용자 스트림
  Stream<User?> get currentUserStream;
  
  /// 현재 사용자 조회
  Future<Either<Failure, User?>> getCurrentUser();
  
  /// 이메일/패스워드 로그인
  Future<Either<Failure, AuthResult>> signInWithEmail({
    required String email,
    required String password,
  });
  
  /// 이메일/패스워드 회원가입
  Future<Either<Failure, AuthResult>> signUpWithEmail({
    required String email,
    required String password,
    String? displayName,
  });
  
  /// 구글 로그인
  Future<Either<Failure, AuthResult>> signInWithGoogle();
  
  /// 익명 로그인
  Future<Either<Failure, AuthResult>> signInAnonymously();
  
  /// 로그아웃
  Future<Either<Failure, void>> signOut();
  
  /// 계정 삭제
  Future<Either<Failure, void>> deleteAccount();
  
  /// 비밀번호 재설정 이메일 전송
  Future<Either<Failure, void>> sendPasswordResetEmail(String email);
  
  /// 사용자 프로필 업데이트
  Future<Either<Failure, User>> updateUserProfile({
    String? displayName,
    String? nickname,
    String? photoUrl,
  });
  
  /// 사용자 게임 통계 업데이트
  Future<Either<Failure, User>> updateGameStats({
    int? bestScore,
    int? totalScore,
    int? totalPlays,
    Duration? totalPlayTime,
    List<String>? newAchievements,
  });
  
  /// 사용자 레벨 및 경험치 업데이트
  Future<Either<Failure, User>> updateUserLevel({
    required int experience,
  });
  
  /// 익명 계정을 정식 계정으로 연결
  Future<Either<Failure, AuthResult>> linkAnonymousAccount({
    required String email,
    required String password,
  });
  
  /// 계정 연결 (구글)
  Future<Either<Failure, AuthResult>> linkWithGoogle();
}