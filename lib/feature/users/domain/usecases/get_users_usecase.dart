import 'package:dartz/dartz.dart';
import 'package:user_management_app/core/errors/failures.dart';
import 'package:user_management_app/core/usecases/usecase.dart';
import 'package:user_management_app/feature/users/domain/entities/user.dart';
import 'package:user_management_app/feature/users/domain/repositories/users_repository.dart';

class GetUsersUseCase implements UseCase<List<User>, GetUsersParams> {
  final UsersRepository repository;

  GetUsersUseCase(this.repository);

  @override
  Future<Either<Failure, List<User>>> call(GetUsersParams params) async {
    return await repository.getUsers(
      page: params.page,
      limit: params.limit,
    );
  }
}

class GetUsersParams {
  final int page;
  final int limit;

  GetUsersParams({
    required this.page,
    required this.limit,
  });
}
