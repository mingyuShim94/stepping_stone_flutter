import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

/// 현재 사용자 조회 Use Case
class GetCurrentUser {
  final AuthRepository repository;
  
  GetCurrentUser(this.repository);
  
  Future<Either<Failure, User?>> call() async {
    return await repository.getCurrentUser();
  }
  
  /// 현재 사용자 스트림 조회
  Stream<User?> watchCurrentUser() {
    return repository.currentUserStream;
  }
}