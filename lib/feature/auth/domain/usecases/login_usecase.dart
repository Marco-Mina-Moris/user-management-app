import 'package:dartz/dartz.dart';
import 'package:user_management_app/core/errors/failures.dart';
import 'package:user_management_app/core/usecases/usecase.dart';
import 'package:user_management_app/feature/auth/domain/entities/login_entity.dart';
import 'package:user_management_app/feature/auth/domain/repositories/auth_repository.dart';


class LoginUseCase implements UseCase<LoginEntity, LoginParams> {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  @override
  Future<Either<Failure, LoginEntity>> call(LoginParams params) async {
    return await repository.login(
      username: params.username,
      password: params.password,
    );
  }
}

class LoginParams {
  final String username;
  final String password;

  LoginParams({
    required this.username,
    required this.password,
  });
}
