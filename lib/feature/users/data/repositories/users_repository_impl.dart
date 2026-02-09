import 'package:dartz/dartz.dart';
import 'package:user_management_app/core/errors/exceptions.dart';
import 'package:user_management_app/core/errors/failures.dart';
import '../../domain/entities/user.dart' as domain;
import '../../domain/repositories/users_repository.dart';
import '../datasources/users_remote_data_source.dart';
import '../models/user_model.dart';

class UsersRepositoryImpl implements UsersRepository {
  final UsersRemoteDataSource remoteDataSource;

  UsersRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<domain.User>>> getUsers({
    required int page,
  }) async {
    try {
      final users = await remoteDataSource.getUsers(page: page);
      return Right(users);
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, domain.User>> updateUser(
    domain.User user,
  ) async {
    try {
      final UserModel userModel = UserModel.fromEntity(user);

      final updatedUser = await remoteDataSource.updateUser(
        id: user.id,
        userData: userModel.toJson(),
      );

      return Right(updatedUser);
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }
}
