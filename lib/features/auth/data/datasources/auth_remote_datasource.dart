import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../../core/error/exceptions.dart';
import '../models/user_model.dart';

/// Firebase 인증 원격 데이터 소스
abstract class AuthRemoteDataSource {
  /// 현재 사용자 스트림
  Stream<User?> get currentUserStream;
  
  /// 현재 Firebase 사용자 조회
  User? getCurrentFirebaseUser();
  
  /// 현재 사용자 데이터 조회
  Future<UserModel?> getCurrentUserData();
  
  /// 이메일/패스워드 로그인
  Future<UserCredential> signInWithEmail({
    required String email,
    required String password,
  });
  
  /// 이메일/패스워드 회원가입
  Future<UserCredential> signUpWithEmail({
    required String email,
    required String password,
    String? displayName,
  });
  
  /// 구글 로그인
  Future<UserCredential> signInWithGoogle();
  
  /// 익명 로그인
  Future<UserCredential> signInAnonymously();
  
  /// 로그아웃
  Future<void> signOut();
  
  /// 계정 삭제
  Future<void> deleteAccount();
  
  /// 비밀번호 재설정 이메일 전송
  Future<void> sendPasswordResetEmail(String email);
  
  /// 사용자 데이터 생성
  Future<void> createUserData(UserModel user);
  
  /// 사용자 데이터 업데이트
  Future<void> updateUserData(String userId, Map<String, dynamic> data);
  
  /// 익명 계정 연결
  Future<UserCredential> linkAnonymousAccount({
    required String email,
    required String password,
  });
  
  /// 구글 계정 연결
  Future<UserCredential> linkWithGoogle();
}

/// Firebase 인증 원격 데이터 소스 구현
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;
  final GoogleSignIn googleSignIn;
  
  AuthRemoteDataSourceImpl({
    required this.firebaseAuth,
    required this.firestore,
    required this.googleSignIn,
  });
  
  @override
  Stream<User?> get currentUserStream => firebaseAuth.authStateChanges();
  
  @override
  User? getCurrentFirebaseUser() {
    return firebaseAuth.currentUser;
  }
  
  @override
  Future<UserModel?> getCurrentUserData() async {
    try {
      final currentUser = getCurrentFirebaseUser();
      if (currentUser == null) return null;
      
      final doc = await firestore
          .collection('users')
          .doc(currentUser.uid)
          .get();
          
      if (!doc.exists) return null;
      
      return UserModel.fromFirestore(doc.data()!, currentUser.uid);
    } on FirebaseException catch (e) {
      throw ServerException(
        e.message ?? 'Failed to get user data',
        e.code,
      );
    } catch (e) {
      throw ServerException(
        'Unexpected error occurred: $e',
        'unknown',
      );
    }
  }
  
  @override
  Future<UserCredential> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final result = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      return result;
    } on FirebaseAuthException catch (e) {
      throw AuthException(
        _getAuthErrorMessage(e.code),
        e.code,
      );
    } catch (e) {
      throw ServerException(
        'Unexpected error occurred during sign in: $e',
        'unknown',
      );
    }
  }
  
  @override
  Future<UserCredential> signUpWithEmail({
    required String email,
    required String password,
    String? displayName,
  }) async {
    try {
      final result = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      // 사용자 프로필 업데이트
      if (displayName != null && result.user != null) {
        await result.user!.updateDisplayName(displayName);
      }
      
      // Firestore에 사용자 데이터 생성 (더 안전한 방식으로)
      if (result.user != null) {
        final userModel = UserModel.fromFirebaseUser(result.user!);
        try {
          await createUserData(userModel);
        } catch (firestoreError) {
          // Firestore 생성 실패를 로그에 기록하되 회원가입 자체는 성공으로 처리
          // TODO: 실제 운영 환경에서는 로깅 프레임워크 사용
          // ignore: avoid_print
          print('Warning: Failed to create Firestore document during signup: $firestoreError');
          
          // Firebase Auth는 성공했으므로 결과 반환
          // Repository 레벨에서 fallback 처리됨
        }
      }
      
      return result;
    } on FirebaseAuthException catch (e) {
      throw AuthException(
        _getAuthErrorMessage(e.code),
        e.code,
      );
    } catch (e) {
      throw ServerException(
        'Unexpected error occurred during sign up: $e',
        'unknown',
      );
    }
  }
  
  @override
  Future<UserCredential> signInWithGoogle() async {
    try {
      // Google 로그인 트리거
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        throw const AuthException(
          'Google sign in was cancelled',
          'sign_in_cancelled',
        );
      }
      
      // Google 인증 정보 획득
      final GoogleSignInAuthentication googleAuth = 
          await googleUser.authentication;
      
      // Firebase 자격 증명 생성
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      
      // Firebase에 로그인
      final result = await firebaseAuth.signInWithCredential(credential);
      
      // 신규 사용자인 경우 Firestore에 데이터 생성
      if (result.additionalUserInfo?.isNewUser == true && result.user != null) {
        final userModel = UserModel.fromFirebaseUser(result.user!);
        await createUserData(userModel);
      }
      
      return result;
    } on FirebaseAuthException catch (e) {
      throw AuthException(
        _getAuthErrorMessage(e.code),
        e.code,
      );
    } catch (e) {
      throw ServerException(
        'Unexpected error occurred during Google sign in: $e',
        'unknown',
      );
    }
  }
  
  @override
  Future<UserCredential> signInAnonymously() async {
    try {
      final result = await firebaseAuth.signInAnonymously();
      
      // 익명 사용자 데이터 생성
      if (result.user != null) {
        final userModel = UserModel.fromFirebaseUser(result.user!);
        await createUserData(userModel);
      }
      
      return result;
    } on FirebaseAuthException catch (e) {
      throw AuthException(
        _getAuthErrorMessage(e.code),
        e.code,
      );
    } catch (e) {
      throw ServerException(
        'Unexpected error occurred during anonymous sign in: $e',
        'unknown',
      );
    }
  }
  
  @override
  Future<void> signOut() async {
    try {
      await Future.wait([
        firebaseAuth.signOut(),
        googleSignIn.signOut(),
      ]);
    } catch (e) {
      throw ServerException(
        'Failed to sign out: $e',
        'sign_out_failed',
      );
    }
  }
  
  @override
  Future<void> deleteAccount() async {
    try {
      final currentUser = getCurrentFirebaseUser();
      if (currentUser == null) {
        throw const AuthException(
          'No user signed in',
          'no_user',
        );
      }
      
      // Firestore 데이터 삭제
      await firestore.collection('users').doc(currentUser.uid).delete();
      
      // Firebase Auth 계정 삭제
      await currentUser.delete();
    } on FirebaseAuthException catch (e) {
      throw AuthException(
        _getAuthErrorMessage(e.code),
        e.code,
      );
    } catch (e) {
      throw ServerException(
        'Failed to delete account: $e',
        'delete_failed',
      );
    }
  }
  
  @override
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw AuthException(
        _getAuthErrorMessage(e.code),
        e.code,
      );
    } catch (e) {
      throw ServerException(
        'Failed to send password reset email: $e',
        'unknown',
      );
    }
  }
  
  @override
  Future<void> createUserData(UserModel user) async {
    try {
      await firestore
          .collection('users')
          .doc(user.id)
          .set(user.toFirestore());
    } on FirebaseException catch (e) {
      throw ServerException(
        e.message ?? 'Failed to create user data',
        e.code,
      );
    } catch (e) {
      throw ServerException(
        'Failed to create user data: $e',
        'unknown',
      );
    }
  }
  
  @override
  Future<void> updateUserData(String userId, Map<String, dynamic> data) async {
    try {
      await firestore
          .collection('users')
          .doc(userId)
          .update(data);
    } on FirebaseException catch (e) {
      throw ServerException(
        e.message ?? 'Failed to update user data',
        e.code,
      );
    } catch (e) {
      throw ServerException(
        'Failed to update user data: $e',
        'unknown',
      );
    }
  }
  
  @override
  Future<UserCredential> linkAnonymousAccount({
    required String email,
    required String password,
  }) async {
    try {
      final currentUser = getCurrentFirebaseUser();
      if (currentUser == null || !currentUser.isAnonymous) {
        throw const AuthException(
          'No anonymous user to link',
          'no_anonymous_user',
        );
      }
      
      final credential = EmailAuthProvider.credential(
        email: email,
        password: password,
      );
      
      final result = await currentUser.linkWithCredential(credential);
      
      // 사용자 정보 업데이트
      if (result.user != null) {
        await updateUserData(result.user!.uid, {
          'email': email,
          'isAnonymous': false,
          'updatedAt': FieldValue.serverTimestamp(),
        });
      }
      
      return result;
    } on FirebaseAuthException catch (e) {
      throw AuthException(
        _getAuthErrorMessage(e.code),
        e.code,
      );
    } catch (e) {
      throw ServerException(
        'Failed to link anonymous account: $e',
        'unknown',
      );
    }
  }
  
  @override
  Future<UserCredential> linkWithGoogle() async {
    try {
      final currentUser = getCurrentFirebaseUser();
      if (currentUser == null) {
        throw const AuthException(
          'No user signed in',
          'no_user',
        );
      }
      
      // Google 로그인 트리거
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        throw const AuthException(
          'Google sign in was cancelled',
          'sign_in_cancelled',
        );
      }
      
      // Google 인증 정보 획득
      final GoogleSignInAuthentication googleAuth = 
          await googleUser.authentication;
      
      // Firebase 자격 증명 생성
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      
      // 계정 연결
      final result = await currentUser.linkWithCredential(credential);
      
      // 사용자 정보 업데이트
      if (result.user != null) {
        await updateUserData(result.user!.uid, {
          'email': result.user!.email,
          'displayName': result.user!.displayName,
          'photoUrl': result.user!.photoURL,
          'isAnonymous': false,
          'updatedAt': FieldValue.serverTimestamp(),
        });
      }
      
      return result;
    } on FirebaseAuthException catch (e) {
      throw AuthException(
        _getAuthErrorMessage(e.code),
        e.code,
      );
    } catch (e) {
      throw ServerException(
        'Failed to link with Google: $e',
        'unknown',
      );
    }
  }
  
  /// Firebase Auth 에러 코드를 사용자 친화적 메시지로 변환
  String _getAuthErrorMessage(String code) {
    switch (code) {
      case 'user-not-found':
        return '등록되지 않은 이메일입니다.';
      case 'wrong-password':
        return '비밀번호가 올바르지 않습니다.';
      case 'invalid-email':
        return '유효하지 않은 이메일 형식입니다.';
      case 'user-disabled':
        return '비활성화된 계정입니다.';
      case 'too-many-requests':
        return '너무 많은 로그인 시도가 있었습니다. 잠시 후 다시 시도해주세요.';
      case 'operation-not-allowed':
        return '이 로그인 방법은 현재 사용할 수 없습니다.';
      case 'weak-password':
        return '비밀번호가 너무 약합니다.';
      case 'email-already-in-use':
        return '이미 사용 중인 이메일입니다.';
      case 'credential-already-in-use':
        return '이미 다른 계정에 연결된 자격 증명입니다.';
      case 'provider-already-linked':
        return '이미 연결된 제공업체입니다.';
      case 'requires-recent-login':
        return '보안을 위해 다시 로그인해주세요.';
      case 'account-exists-with-different-credential':
        return '같은 이메일로 다른 로그인 방법이 이미 존재합니다.';
      default:
        return '로그인 중 오류가 발생했습니다.';
    }
  }
}