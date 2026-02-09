import 'package:dartz/dartz.dart';
import 'package:user_management_app/core/errors/failures.dart';
import 'package:user_management_app/feature/users/domain/entities/user.dart';


abstract class UsersRepository {
  Future<Either<Failure, List<User>>> getUsers({
    required int page,
  });

  Future<Either<Failure, User>> updateUser(User user);
}
