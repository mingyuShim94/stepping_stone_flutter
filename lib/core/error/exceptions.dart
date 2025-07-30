/// 앱에서 사용하는 Exception들 정의
abstract class AppException implements Exception {
  final String message;
  final String? code;
  
  const AppException(this.message, [this.code]);
  
  @override
  String toString() => 'AppException: $message${code != null ? ' ($code)' : ''}';
}

/// 네트워크 관련 예외
class NetworkException extends AppException {
  const NetworkException(super.message, [super.code]);
}

/// 서버 관련 예외
class ServerException extends AppException {
  const ServerException(super.message, [super.code]);
}

/// 인증 관련 예외
class AuthException extends AppException {
  const AuthException(super.message, [super.code]);
}

/// 게임 관련 예외
class GameException extends AppException {
  const GameException(super.message, [super.code]);
}

/// 캐시 관련 예외
class CacheException extends AppException {
  const CacheException(super.message, [super.code]);
}

/// 입력 검증 예외
class ValidationException extends AppException {
  const ValidationException(super.message, [super.code]);
}

/// 권한 관련 예외
class PermissionException extends AppException {
  const PermissionException(super.message, [super.code]);
}

/// 인증되지 않은 사용자 예외
class UnauthorizedException extends AppException {
  const UnauthorizedException(super.message, [super.code]);
}