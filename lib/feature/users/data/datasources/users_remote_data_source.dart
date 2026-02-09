import 'package:dio/dio.dart';
import 'package:user_management_app/core/constants/api_constants.dart';
import 'package:user_management_app/core/errors/exceptions.dart';
import 'package:user_management_app/core/network/dio_client.dart';
import 'package:user_management_app/feature/users/data/models/user_model.dart';
import 'package:user_management_app/feature/users/data/models/users_response_model.dart';


abstract class UsersRemoteDataSource {
  Future<List<UserModel>> getUsers({
    required int page, required int limit,
  });

  Future<UserModel> getUserById(int id);

  Future<UserModel> updateUser({
    required int id,
    required Map<String, dynamic> userData,
  });
}

class UsersRemoteDataSourceImpl implements UsersRemoteDataSource {
  final DioClient dioClient;

  static const int limit = 10;

  UsersRemoteDataSourceImpl(this.dioClient);

  @override
 Future<List<UserModel>> getUsers({
  required int limit,
  required int page,
}) async {
  try {
    final int skip = (page - 1) * limit;

    final response = await dioClient.dio.get(
      ApiConstants.usersWithPagination,
      queryParameters: {
        'limit': limit,
        'skip': skip,
      },
    );

    if (response.statusCode == 200) {
      final usersResponse =
          UsersResponseModel.fromJson(response.data);

      return usersResponse.users;
    } else {
      throw ServerException('Failed to load users');
    }
  } on DioException catch (e) {
    handleDioError(e);
    rethrow;
  }
}


  @override
  Future<UserModel> getUserById(int id) async {
    try {
      final response =
          await dioClient.dio.get('${ApiConstants.users}/$id');

      if (response.statusCode == 200) {
        return UserModel.fromJson(response.data);
      } else {
        throw ServerException('Failed to load user');
      }
    } on DioException catch (e) {
      handleDioError(e);
      rethrow;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> updateUser({
    required int id,
    required Map<String, dynamic> userData,
  }) async {
    try {
      final response = await dioClient.dio.put(
        '${ApiConstants.users}/$id',
        data: userData,
      );

      if (response.statusCode == 200) {
        return UserModel.fromJson(response.data);
      } else {
        throw ServerException('Failed to update user');
      }
    } on DioException catch (e) {
      handleDioError(e);
      rethrow;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  void handleDioError(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      throw NetworkException('Connection timeout');
    } else if (e.type == DioExceptionType.connectionError) {
      throw NetworkException('No internet connection');
    } else {
      throw ServerException(e.message ?? 'Server error');
    }
  }
}