import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/utils/validators.dart';
import '../entities/auth_result.dart';
import '../repositories/auth_repository.dart';

/// 이메일 회원가입 Use Case
class SignUpWithEmail {
  final AuthRepository repository;
  
  SignUpWithEmail(this.repository);
  
  Future<Either<Failure, AuthResult>> call(SignUpWithEmailParams params) async {
    // 이메일 검증
    final emailValidation = FormValidators.validateEmail(params.email);
    if (!emailValidation.isValid) {
      return Left(Failure.validation(
        message: emailValidation.errorMessage!,
      ));
    }
    
    // 비밀번호 검증
    final passwordValidation = FormValidators.validatePassword(params.password);
    if (!passwordValidation.isValid) {
      return Left(Failure.validation(
        message: passwordValidation.errorMessage!,
      ));
    }
    
    // 비밀번호 확인 검증
    if (params.password != params.confirmPassword) {
      return Left(Failure.validation(
        message: '비밀번호가 일치하지 않습니다.',
      ));
    }
    
    // 표시 이름 검증 (옵션)
    if (params.displayName != null && params.displayName!.isNotEmpty) {
      final nameValidation = FormValidators.validateNickname(params.displayName!);
      if (!nameValidation.isValid) {
        return Left(Failure.validation(
          message: nameValidation.errorMessage!,
        ));
      }
    }
    
    return await repository.signUpWithEmail(
      email: params.email.trim().toLowerCase(),
      password: params.password,
      displayName: params.displayName?.trim(),
    );
  }
}

/// 이메일 회원가입 파라미터
class SignUpWithEmailParams {
  final String email;
  final String password;
  final String confirmPassword;
  final String? displayName;
  
  SignUpWithEmailParams({
    required this.email,
    required this.password,
    required this.confirmPassword,
    this.displayName,
  });
}