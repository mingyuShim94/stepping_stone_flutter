import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/entities/auth_result.dart';
import 'user_model.dart';

/// AuthResult 엔티티의 데이터 모델
class AuthResultModel {
  final UserModel user;
  final bool isNewUser;
  final Map<String, dynamic>? credential;

  const AuthResultModel({
    required this.user,
    required this.isNewUser,
    this.credential,
  });

  /// Firebase UserCredential로부터 AuthResultModel 생성
  factory AuthResultModel.fromUserCredential(
    UserCredential userCredential,
    UserModel userModel,
  ) {
    return AuthResultModel(
      user: userModel,
      isNewUser: userCredential.additionalUserInfo?.isNewUser ?? false,
      credential: userCredential.credential?.asMap(),
    );
  }

  /// AuthResult 엔티티로부터 AuthResultModel 생성
  factory AuthResultModel.fromEntity(AuthResult authResult) {
    return AuthResultModel(
      user: UserModel.fromEntity(authResult.user),
      isNewUser: authResult.isNewUser,
      credential: authResult.credential,
    );
  }

  /// AuthResultModel을 AuthResult 엔티티로 변환
  AuthResult toEntity() {
    return AuthResult(
      user: user.toEntity(),
      isNewUser: isNewUser,
      credential: credential,
    );
  }

  /// copyWith 메서드
  AuthResultModel copyWith({
    UserModel? user,
    bool? isNewUser,
    Map<String, dynamic>? credential,
  }) {
    return AuthResultModel(
      user: user ?? this.user,
      isNewUser: isNewUser ?? this.isNewUser,
      credential: credential ?? this.credential,
    );
  }
}

/// AuthCredential을 Map으로 변환하기 위한 확장
extension AuthCredentialExtension on AuthCredential {
  Map<String, dynamic> asMap() {
    return {
      'providerId': providerId,
      'signInMethod': signInMethod,
      'token': token,
    };
  }
}