import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/user.dart';
import '../repositories/users_repository.dart';

class UpdateUserUseCase implements UseCase<User, UpdateUserParams> {
  final UsersRepository repository;

  UpdateUserUseCase(this.repository);

  @override
  Future<Either<Failure, User>> call(UpdateUserParams params) async {
    return await repository.updateUser(
      params.user,
    );
  }
}

class UpdateUserParams {
  final User user;
  UpdateUserParams(this.user);
}

