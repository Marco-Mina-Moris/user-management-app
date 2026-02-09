import 'package:dio/dio.dart';
import 'package:user_management_app/core/constants/api_constants.dart';
import 'package:user_management_app/core/errors/exceptions.dart';
import 'package:user_management_app/core/network/dio_client.dart';
import 'package:user_management_app/feature/auth/data/models/login_response_model.dart';

abstract class AuthRemoteDataSource {
  Future<LoginResponseModel> login({
    required String username,
    required String password,
  });
  
  Future<void> logout({required String token});
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final DioClient dioClient;

  AuthRemoteDataSourceImpl(this.dioClient);

  @override
  Future<LoginResponseModel> login({
    required String username,
    required String password,
  }) async {
    try {
      final response = await dioClient.dio.post(
        ApiConstants.login,
        data: {
          'username': username,
          'password': password,
          'expiresInMins': 60,
        },
      );

      if (response.statusCode == 200) {
        return LoginResponseModel.fromJson(response.data);
      } else {
        throw ServerException('Login failed');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw NetworkException('Connection timeout');
      } else if (e.type == DioExceptionType.connectionError) {
        throw NetworkException('No internet connection');
      } else if (e.response?.statusCode == 400) {
        throw AuthException(
            e.response?.data['message'] ?? 'Invalid credentials');
      } else if (e.response?.statusCode == 401) {
        throw AuthException('Invalid credentials');
      } else {
        throw ServerException(e.message ?? 'Server error');
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> logout({required String token}) async {
    try {
      // Note: DummyJSON doesn't have a real logout endpoint
      // This is a placeholder for when you use a real API
      final response = await dioClient.dio.post(
        '${ApiConstants.baseUrl}/auth/logout',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode != 200) {
        throw ServerException('Logout failed');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw NetworkException('Connection timeout');
      } else if (e.type == DioExceptionType.connectionError) {
        throw NetworkException('No internet connection');
      } else {
        // For DummyJSON, we'll ignore the error since there's no real logout endpoint
        // In a real app, you would throw the exception
        return;
      }
    } catch (e) {
      // Ignore for DummyJSON
      return;
    }
  }
}