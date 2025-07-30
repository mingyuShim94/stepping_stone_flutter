import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/utils/validators.dart';
import '../entities/auth_result.dart';
import '../repositories/auth_repository.dart';

/// 이메일 로그인 Use Case
class SignInWithEmail {
  final AuthRepository repository;
  
  SignInWithEmail(this.repository);
  
  Future<Either<Failure, AuthResult>> call(SignInWithEmailParams params) async {
    // 입력 검증
    final emailValidation = FormValidators.validateEmail(params.email);
    if (!emailValidation.isValid) {
      return Left(Failure.validation(
        message: emailValidation.errorMessage!,
      ));
    }
    
    final passwordValidation = FormValidators.validatePassword(params.password);
    if (!passwordValidation.isValid) {
      return Left(Failure.validation(
        message: passwordValidation.errorMessage!,
      ));
    }
    
    return await repository.signInWithEmail(
      email: params.email.trim().toLowerCase(),
      password: params.password,
    );
  }
}

/// 이메일 로그인 파라미터
class SignInWithEmailParams {
  final String email;
  final String password;
  
  SignInWithEmailParams({
    required this.email,
    required this.password,
  });
}