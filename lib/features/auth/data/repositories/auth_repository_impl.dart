import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/user.dart' as domain;
import '../../domain/entities/auth_result.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';
import '../models/user_model.dart';
import '../models/auth_result_model.dart';

/// 인증 Repository 구현
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  
  AuthRepositoryImpl({
    required this.remoteDataSource,
  });
  
  @override
  Stream<domain.User?> get currentUserStream {
    return remoteDataSource.currentUserStream.asyncMap((firebaseUser) async {
      if (firebaseUser == null) return null;
      
      try {
        final userData = await remoteDataSource.getCurrentUserData();
        if (userData != null) {
          return userData.toEntity();
        }
        
        // Firestore 데이터가 없으면 Firebase User로부터 생성하고 백그라운드에서 저장
        final userModel = UserModel.fromFirebaseUser(firebaseUser);
        
        // 백그라운드에서 Firestore 데이터 생성 시도 (에러 발생해도 무시)
        _createUserDataInBackground(userModel);
        
        return userModel.toEntity();
        
      } catch (e) {
        // Firestore 조회 실패 시에도 Firebase User 기반으로 UserModel 생성
        // 에러를 던지지 않고 fallback 처리하여 사용자 경험 보장
        final userModel = UserModel.fromFirebaseUser(firebaseUser);
        
        // 백그라운드에서 Firestore 데이터 생성 재시도
        _createUserDataInBackground(userModel);
        
        return userModel.toEntity();
      }
    });
  }
  
  @override
  Future<Either<Failure, domain.User?>> getCurrentUser() async {
    try {
      final firebaseUser = remoteDataSource.getCurrentFirebaseUser();
      if (firebaseUser == null) return const Right(null);
      
      final userData = await remoteDataSource.getCurrentUserData();
      if (userData != null) {
        return Right(userData.toEntity());
      }
      
      // Firestore 데이터가 없는 경우 Firebase User로부터 생성
      final userModel = UserModel.fromFirebaseUser(firebaseUser);
      await remoteDataSource.createUserData(userModel);
      return Right(userModel.toEntity());
      
    } on ServerException catch (e) {
      return Left(Failure.server(
        message: e.message,
        code: e.code,
      ));
    } on AuthException catch (e) {
      return Left(Failure.auth(
        message: e.message,
        code: e.code,
      ));
    } catch (e) {
      return Left(Failure.unknown(
        message: 'Failed to get current user: $e',
      ));
    }
  }
  
  @override
  Future<Either<Failure, AuthResult>> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await remoteDataSource.signInWithEmail(
        email: email,
        password: password,
      );
      
      if (userCredential.user == null) {
        return Left(Failure.auth(
          message: 'Authentication failed',
          code: 'auth_failed',
        ));
      }
      
      // 사용자 데이터 조회 또는 생성
      UserModel userModel;
      final existingUser = await remoteDataSource.getCurrentUserData();
      
      if (existingUser != null) {
        // 마지막 로그인 시간 업데이트
        userModel = existingUser.updateProfile();
        await remoteDataSource.updateUserData(
          userModel.id, 
          {'lastLoginAt': DateTime.now()},
        );
      } else {
        // 새로운 사용자 데이터 생성
        userModel = UserModel.fromFirebaseUser(userCredential.user!);
        await remoteDataSource.createUserData(userModel);
      }
      
      final authResult = AuthResultModel.fromUserCredential(
        userCredential,
        userModel,
      );
      
      return Right(authResult.toEntity());
      
    } on AuthException catch (e) {
      return Left(Failure.auth(
        message: e.message,
        code: e.code,
      ));
    } on ServerException catch (e) {
      return Left(Failure.server(
        message: e.message,
        code: e.code,
      ));
    } catch (e) {
      return Left(Failure.unknown(
        message: 'Failed to sign in with email: $e',
      ));
    }
  }
  
  @override
  Future<Either<Failure, AuthResult>> signUpWithEmail({
    required String email,
    required String password,
    String? displayName,
  }) async {
    try {
      final userCredential = await remoteDataSource.signUpWithEmail(
        email: email,
        password: password,
        displayName: displayName,
      );
      
      if (userCredential.user == null) {
        return Left(Failure.auth(
          message: 'Registration failed',
          code: 'registration_failed',
        ));
      }
      
      // 회원가입 성공 시 항상 Firebase User 기반으로 UserModel 생성
      // Firestore 동기화는 백그라운드에서 처리하여 사용자 경험 우선
      final userModel = UserModel.fromFirebaseUser(userCredential.user!);
      
      // 백그라운드에서 Firestore 데이터 동기화 (에러 무시)
      _createUserDataInBackground(userModel);
      
      final authResult = AuthResultModel.fromUserCredential(
        userCredential,
        userModel,
      );
      
      return Right(authResult.toEntity());
      
    } on AuthException catch (e) {
      return Left(Failure.auth(
        message: e.message,
        code: e.code,
      ));
    } on ServerException catch (e) {
      return Left(Failure.server(
        message: e.message,
        code: e.code,
      ));
    } catch (e) {
      return Left(Failure.unknown(
        message: 'Failed to sign up with email: $e',
      ));
    }
  }
  
  @override
  Future<Either<Failure, AuthResult>> signInWithGoogle() async {
    try {
      final userCredential = await remoteDataSource.signInWithGoogle();
      
      if (userCredential.user == null) {
        return Left(Failure.auth(
          message: 'Google sign in failed',
          code: 'google_signin_failed',
        ));
      }
      
      // 사용자 데이터 조회 또는 생성 (이미 signInWithGoogle에서 처리됨)
      final userModel = await remoteDataSource.getCurrentUserData();
      if (userModel == null) {
        return Left(Failure.server(
          message: 'Failed to retrieve user data after Google sign in',
          code: 'user_data_not_found',
        ));
      }
      
      final authResult = AuthResultModel.fromUserCredential(
        userCredential,
        userModel,
      );
      
      return Right(authResult.toEntity());
      
    } on AuthException catch (e) {
      return Left(Failure.auth(
        message: e.message,
        code: e.code,
      ));
    } on ServerException catch (e) {
      return Left(Failure.server(
        message: e.message,
        code: e.code,
      ));
    } catch (e) {
      return Left(Failure.unknown(
        message: 'Failed to sign in with Google: $e',
      ));
    }
  }
  
  @override
  Future<Either<Failure, AuthResult>> signInAnonymously() async {
    try {
      final userCredential = await remoteDataSource.signInAnonymously();
      
      if (userCredential.user == null) {
        return Left(Failure.auth(
          message: 'Anonymous sign in failed',
          code: 'anonymous_signin_failed',
        ));
      }
      
      // 익명 사용자 데이터는 이미 signInAnonymously에서 생성됨
      final userModel = await remoteDataSource.getCurrentUserData();
      if (userModel == null) {
        return Left(Failure.server(
          message: 'Failed to retrieve user data after anonymous sign in',
          code: 'user_data_not_found',
        ));
      }
      
      final authResult = AuthResultModel.fromUserCredential(
        userCredential,
        userModel,
      );
      
      return Right(authResult.toEntity());
      
    } on AuthException catch (e) {
      return Left(Failure.auth(
        message: e.message,
        code: e.code,
      ));
    } on ServerException catch (e) {
      return Left(Failure.server(
        message: e.message,
        code: e.code,
      ));
    } catch (e) {
      return Left(Failure.unknown(
        message: 'Failed to sign in anonymously: $e',
      ));
    }
  }
  
  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await remoteDataSource.signOut();
      return const Right(null);
    } on ServerException catch (e) {
      return Left(Failure.server(
        message: e.message,
        code: e.code,
      ));
    } catch (e) {
      return Left(Failure.unknown(
        message: 'Failed to sign out: $e',
      ));
    }
  }
  
  @override
  Future<Either<Failure, void>> deleteAccount() async {
    try {
      await remoteDataSource.deleteAccount();
      return const Right(null);
    } on AuthException catch (e) {
      return Left(Failure.auth(
        message: e.message,
        code: e.code,
      ));
    } on ServerException catch (e) {
      return Left(Failure.server(
        message: e.message,
        code: e.code,
      ));
    } catch (e) {
      return Left(Failure.unknown(
        message: 'Failed to delete account: $e',
      ));
    }
  }
  
  @override
  Future<Either<Failure, void>> sendPasswordResetEmail(String email) async {
    try {
      await remoteDataSource.sendPasswordResetEmail(email);
      return const Right(null);
    } on AuthException catch (e) {
      return Left(Failure.auth(
        message: e.message,
        code: e.code,
      ));
    } on ServerException catch (e) {
      return Left(Failure.server(
        message: e.message,
        code: e.code,
      ));
    } catch (e) {
      return Left(Failure.unknown(
        message: 'Failed to send password reset email: $e',
      ));
    }
  }
  
  @override
  Future<Either<Failure, domain.User>> updateUserProfile({
    String? displayName,
    String? nickname,
    String? photoUrl,
  }) async {
    try {
      final currentUser = remoteDataSource.getCurrentFirebaseUser();
      if (currentUser == null) {
        return Left(Failure.auth(
          message: 'No user signed in',
          code: 'no_user',
        ));
      }
      
      final userData = await remoteDataSource.getCurrentUserData();
      if (userData == null) {
        return Left(Failure.server(
          message: 'User data not found',
          code: 'user_data_not_found',
        ));
      }
      
      // 프로필 업데이트
      final updatedUser = userData.updateProfile(
        displayName: displayName,
        nickname: nickname,
        photoUrl: photoUrl,
      );
      
      // Firestore 업데이트
      final updateData = <String, dynamic>{};
      if (displayName != null) updateData['displayName'] = displayName;
      if (nickname != null) updateData['nickname'] = nickname;
      if (photoUrl != null) updateData['photoUrl'] = photoUrl;
      updateData['updatedAt'] = DateTime.now();
      
      await remoteDataSource.updateUserData(currentUser.uid, updateData);
      
      // Firebase Auth 프로필 업데이트 (displayName만)
      if (displayName != null) {
        await currentUser.updateDisplayName(displayName);
      }
      if (photoUrl != null) {
        await currentUser.updatePhotoURL(photoUrl);
      }
      
      return Right(updatedUser.toEntity());
      
    } on AuthException catch (e) {
      return Left(Failure.auth(
        message: e.message,
        code: e.code,
      ));
    } on ServerException catch (e) {
      return Left(Failure.server(
        message: e.message,
        code: e.code,
      ));
    } catch (e) {
      return Left(Failure.unknown(
        message: 'Failed to update user profile: $e',
      ));
    }
  }
  
  @override
  Future<Either<Failure, domain.User>> updateGameStats({
    int? bestScore,
    int? totalScore,
    int? totalPlays,
    Duration? totalPlayTime,
    List<String>? newAchievements,
  }) async {
    try {
      final currentUser = remoteDataSource.getCurrentFirebaseUser();
      if (currentUser == null) {
        return Left(Failure.auth(
          message: 'No user signed in',
          code: 'no_user',
        ));
      }
      
      final userData = await remoteDataSource.getCurrentUserData();
      if (userData == null) {
        return Left(Failure.server(
          message: 'User data not found',
          code: 'user_data_not_found',
        ));
      }
      
      // 게임 통계 업데이트
      final updatedUser = userData.updateGameStats(
        newScore: totalScore,
        playTime: totalPlayTime,
        newAchievements: newAchievements,
      );
      
      // Firestore 업데이트
      final updateData = <String, dynamic>{
        'totalScore': updatedUser.totalScore,
        'bestScore': updatedUser.bestScore,
        'totalPlays': updatedUser.totalPlays,
        'totalPlayTimeMs': updatedUser.totalPlayTime.inMilliseconds,
        'achievements': updatedUser.achievements,
        'updatedAt': DateTime.now(),
      };
      
      await remoteDataSource.updateUserData(currentUser.uid, updateData);
      
      return Right(updatedUser.toEntity());
      
    } on AuthException catch (e) {
      return Left(Failure.auth(
        message: e.message,
        code: e.code,
      ));
    } on ServerException catch (e) {
      return Left(Failure.server(
        message: e.message,
        code: e.code,
      ));
    } catch (e) {
      return Left(Failure.unknown(
        message: 'Failed to update game stats: $e',
      ));
    }
  }
  
  @override
  Future<Either<Failure, domain.User>> updateUserLevel({
    required int experience,
  }) async {
    try {
      final currentUser = remoteDataSource.getCurrentFirebaseUser();
      if (currentUser == null) {
        return Left(Failure.auth(
          message: 'No user signed in',
          code: 'no_user',
        ));
      }
      
      final userData = await remoteDataSource.getCurrentUserData();
      if (userData == null) {
        return Left(Failure.server(
          message: 'User data not found',
          code: 'user_data_not_found',
        ));
      }
      
      // 레벨 업데이트
      final updatedUser = userData.updateLevel(experience);
      
      // Firestore 업데이트
      final updateData = <String, dynamic>{
        'level': updatedUser.level,
        'experience': updatedUser.experience,
        'updatedAt': DateTime.now(),
      };
      
      await remoteDataSource.updateUserData(currentUser.uid, updateData);
      
      return Right(updatedUser.toEntity());
      
    } on AuthException catch (e) {
      return Left(Failure.auth(
        message: e.message,
        code: e.code,
      ));
    } on ServerException catch (e) {
      return Left(Failure.server(
        message: e.message,
        code: e.code,
      ));
    } catch (e) {
      return Left(Failure.unknown(
        message: 'Failed to update user level: $e',
      ));
    }
  }
  
  @override
  Future<Either<Failure, AuthResult>> linkAnonymousAccount({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await remoteDataSource.linkAnonymousAccount(
        email: email,
        password: password,
      );
      
      if (userCredential.user == null) {
        return Left(Failure.auth(
          message: 'Failed to link anonymous account',
          code: 'link_failed',
        ));
      }
      
      final userModel = await remoteDataSource.getCurrentUserData();
      if (userModel == null) {
        return Left(Failure.server(
          message: 'User data not found after linking',
          code: 'user_data_not_found',
        ));
      }
      
      final authResult = AuthResultModel.fromUserCredential(
        userCredential,
        userModel,
      );
      
      return Right(authResult.toEntity());
      
    } on AuthException catch (e) {
      return Left(Failure.auth(
        message: e.message,
        code: e.code,
      ));
    } on ServerException catch (e) {
      return Left(Failure.server(
        message: e.message,
        code: e.code,
      ));
    } catch (e) {
      return Left(Failure.unknown(
        message: 'Failed to link anonymous account: $e',
      ));
    }
  }
  
  @override
  Future<Either<Failure, AuthResult>> linkWithGoogle() async {
    try {
      final userCredential = await remoteDataSource.linkWithGoogle();
      
      if (userCredential.user == null) {
        return Left(Failure.auth(
          message: 'Failed to link with Google',
          code: 'link_failed',
        ));
      }
      
      final userModel = await remoteDataSource.getCurrentUserData();
      if (userModel == null) {
        return Left(Failure.server(
          message: 'User data not found after linking',
          code: 'user_data_not_found',
        ));
      }
      
      final authResult = AuthResultModel.fromUserCredential(
        userCredential,
        userModel,
      );
      
      return Right(authResult.toEntity());
      
    } on AuthException catch (e) {
      return Left(Failure.auth(
        message: e.message,
        code: e.code,
      ));
    } on ServerException catch (e) {
      return Left(Failure.server(
        message: e.message,
        code: e.code,
      ));
    } catch (e) {
      return Left(Failure.unknown(
        message: 'Failed to link with Google: $e',
      ));
    }
  }
  
  
  /// 백그라운드에서 Firestore 사용자 데이터 생성 (에러 무시)
  void _createUserDataInBackground(UserModel userModel) {
    // Future를 await하지 않고 백그라운드에서 실행
    Future.microtask(() async {
      try {
        await remoteDataSource.createUserData(userModel);
      } catch (e) {
        // 백그라운드 작업이므로 에러를 로그만 남기고 무시
        // TODO: 실제 운영 환경에서는 로깅 프레임워크 사용
        // ignore: avoid_print
        print('Background Firestore user data creation failed: $e');
      }
    });
  }
}