import 'package:dartz/dartz.dart';
import 'package:user_management_app/core/errors/failures.dart';
import 'package:user_management_app/feature/auth/domain/entities/login_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, LoginEntity>> login({
    required String username,
    required String password,
  });

  Future<Either<Failure, bool>> logout();

  Future<Either<Failure, bool>> isLoggedIn();

  Future<Either<Failure, String>> getToken();
}
