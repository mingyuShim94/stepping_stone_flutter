import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/auth_repository.dart';

/// 로그아웃 Use Case
class SignOut {
  final AuthRepository repository;
  
  SignOut(this.repository);
  
  Future<Either<Failure, void>> call() async {
    return await repository.signOut();
  }
}