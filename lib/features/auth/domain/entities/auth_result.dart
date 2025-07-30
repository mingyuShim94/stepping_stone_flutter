import 'package:freezed_annotation/freezed_annotation.dart';
import 'user.dart';

part 'auth_result.freezed.dart';

/// 인증 결과
@freezed
class AuthResult with _$AuthResult {
  const factory AuthResult({
    required User user,
    required bool isNewUser,
    String? accessToken,
    String? refreshToken,
    Map<String, dynamic>? credential,
  }) = _AuthResult;
}

/// 로그인 방법
enum LoginMethod {
  email,
  google,
  anonymous,
}

extension LoginMethodExtension on LoginMethod {
  String get displayName {
    switch (this) {
      case LoginMethod.email:
        return '이메일';
      case LoginMethod.google:
        return '구글';
      case LoginMethod.anonymous:
        return '게스트';
    }
  }
  
  String get iconPath {
    switch (this) {
      case LoginMethod.email:
        return 'assets/icons/email.png';
      case LoginMethod.google:
        return 'assets/icons/google.png';
      case LoginMethod.anonymous:
        return 'assets/icons/guest.png';
    }
  }
}