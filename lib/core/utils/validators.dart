/// 입력값 검증을 위한 유틸리티 클래스
class Validators {
  /// 이메일 형식 검증
  static bool isValidEmail(String email) {
    return RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email.trim());
  }
  
  /// 닉네임 검증 (2-20자, 한글/영문/숫자/_만 허용)
  static bool isValidNickname(String nickname) {
    if (nickname.trim().isEmpty) return false;
    if (nickname.length < 2 || nickname.length > 20) return false;
    return RegExp(r'^[a-zA-Z0-9가-힣_]+$').hasMatch(nickname);
  }
  
  /// 비밀번호 검증 (최소 6자)
  static bool isValidPassword(String password) {
    return password.length >= 6;
  }
  
  /// 점수 유효성 검증
  static bool isValidScore(int score) {
    return score >= 0 && score <= 999999; // 최대 6자리
  }
  
  /// 플레이 시간 검증 (최대 24시간)
  static bool isValidPlayTime(Duration duration) {
    return duration.inHours <= 24 && !duration.isNegative;
  }
  
  /// 문자열이 비어있지 않은지 검증
  static bool isNotEmpty(String? value) {
    return value != null && value.trim().isNotEmpty;
  }
  
  /// 숫자 범위 검증
  static bool isInRange(num value, num min, num max) {
    return value >= min && value <= max;
  }
}

/// 입력 검증 결과를 나타내는 클래스
class ValidationResult {
  final bool isValid;
  final String? errorMessage;
  
  const ValidationResult({
    required this.isValid,
    this.errorMessage,
  });
  
  static const ValidationResult valid = ValidationResult(isValid: true);
  
  static ValidationResult invalid(String message) {
    return ValidationResult(isValid: false, errorMessage: message);
  }
}

/// 폼 검증을 위한 헬퍼 클래스
class FormValidators {
  /// 이메일 검증
  static ValidationResult validateEmail(String? email) {
    if (email == null || email.trim().isEmpty) {
      return ValidationResult.invalid('이메일을 입력해주세요');
    }
    
    if (!Validators.isValidEmail(email)) {
      return ValidationResult.invalid('유효한 이메일 주소를 입력해주세요');
    }
    
    return ValidationResult.valid;
  }
  
  /// 닉네임 검증
  static ValidationResult validateNickname(String? nickname) {
    if (nickname == null || nickname.trim().isEmpty) {
      return ValidationResult.invalid('닉네임을 입력해주세요');
    }
    
    if (!Validators.isValidNickname(nickname)) {
      return ValidationResult.invalid('닉네임은 2-20자의 한글, 영문, 숫자, _만 사용 가능합니다');
    }
    
    return ValidationResult.valid;
  }
  
  /// 비밀번호 검증
  static ValidationResult validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return ValidationResult.invalid('비밀번호를 입력해주세요');
    }
    
    if (!Validators.isValidPassword(password)) {
      return ValidationResult.invalid('비밀번호는 최소 6자 이상이어야 합니다');
    }
    
    return ValidationResult.valid;
  }
  
  /// 비밀번호 확인 검증
  static ValidationResult validatePasswordConfirm(
    String? password,
    String? confirmPassword,
  ) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return ValidationResult.invalid('비밀번호 확인을 입력해주세요');
    }
    
    if (password != confirmPassword) {
      return ValidationResult.invalid('비밀번호가 일치하지 않습니다');
    }
    
    return ValidationResult.valid;
  }
}