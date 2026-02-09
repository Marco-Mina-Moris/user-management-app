import 'package:dartz/dartz.dart';
import 'package:user_management_app/core/errors/exceptions.dart';
import 'package:user_management_app/core/errors/failures.dart';
import 'package:user_management_app/feature/auth/data/datasources/auth_local_data_source.dart';
import 'package:user_management_app/feature/auth/data/datasources/auth_remote_data_source.dart';
import 'package:user_management_app/feature/auth/domain/entities/login_entity.dart';
import 'package:user_management_app/feature/auth/domain/repositories/auth_repository.dart';


class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, LoginEntity>> login({
    required String username,
    required String password,
  }) async {
    try {
      final result = await remoteDataSource.login(
        username: username,
        password: password,
      );
      
      // Save token locally
      await localDataSource.saveToken(result.accessToken);
      
      return Right(result);
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on AuthException catch (e) {
      return Left(AuthFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> logout() async {
    try {
      await localDataSource.deleteToken();
      return const Right(true);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> isLoggedIn() async {
    try {
      final hasToken = await localDataSource.hasToken();
      return Right(hasToken);
    } catch (e) {
      return const Right(false);
    }
  }

  @override
  Future<Either<Failure, String>> getToken() async {
    try {
      final token = await localDataSource.getToken();
      return Right(token);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }
}
