import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/auth_result.dart';
import '../repositories/auth_repository.dart';

/// 구글 로그인 Use Case
class SignInWithGoogle {
  final AuthRepository repository;
  
  SignInWithGoogle(this.repository);
  
  Future<Either<Failure, AuthResult>> call() async {
    return await repository.signInWithGoogle();
  }
}