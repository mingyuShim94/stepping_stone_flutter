import 'package:freezed_annotation/freezed_annotation.dart';

part 'failures.freezed.dart';

/// 애플리케이션에서 발생하는 실패(Failure) 상태를 나타내는 클래스
@freezed
class Failure with _$Failure {
  const factory Failure.network({
    required String message,
    String? code,
  }) = NetworkFailure;
  
  const factory Failure.server({
    required String message,
    String? code,
  }) = ServerFailure;
  
  const factory Failure.auth({
    required String message,
    String? code,
  }) = AuthFailure;
  
  const factory Failure.game({
    required String message,
    String? code,
  }) = GameFailure;
  
  const factory Failure.cache({
    required String message,
    String? code,
  }) = CacheFailure;
  
  const factory Failure.validation({
    required String message,
    String? code,
  }) = ValidationFailure;
  
  const factory Failure.permission({
    required String message,
    String? code,
  }) = PermissionFailure;
  
  const factory Failure.unknown({
    required String message,
    String? code,
  }) = UnknownFailure;
}

/// Failure를 사용자 친화적인 메시지로 변환하는 확장
extension FailureExtension on Failure {
  String get userMessage {
    return when(
      network: (message, code) => '인터넷 연결을 확인해주세요',
      server: (message, code) => _getServerErrorMessage(message, code),
      auth: (message, code) => _getAuthErrorMessage(message, code),
      game: (message, code) => '게임에 문제가 발생했습니다',
      cache: (message, code) => '데이터를 불러올 수 없습니다',
      validation: (message, code) => message,
      permission: (message, code) => '권한이 필요합니다',
      unknown: (message, code) => '알 수 없는 오류가 발생했습니다',
    );
  }
  
  /// 서버 에러에 대한 구체적인 메시지 반환
  String _getServerErrorMessage(String message, String? code) {
    switch (code) {
      case 'user_data_not_found':
        return '사용자 정보를 불러올 수 없습니다. 잠시 후 다시 시도해주세요.';
      case 'user_data_retry_failed':
        return '서버 연결이 불안정합니다. 잠시 후 다시 시도해주세요.';
      case 'firestore_unavailable':
        return '데이터베이스에 일시적인 문제가 발생했습니다.';
      default:
        return '서버에 일시적인 문제가 발생했습니다';
    }
  }
  
  /// 인증 에러에 대한 구체적인 메시지 반환
  String _getAuthErrorMessage(String message, String? code) {
    switch (code) {
      case 'registration_failed':
        return '회원가입에 실패했습니다. 다시 시도해주세요.';
      case 'no_user':
        return '로그인이 필요합니다.';
      default:
        return message.isNotEmpty ? message : '인증에 실패했습니다.';
    }
  }
}