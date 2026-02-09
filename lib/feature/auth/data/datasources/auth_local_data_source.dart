import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_management_app/core/errors/exceptions.dart';


abstract class AuthLocalDataSource {
  Future<void> saveToken(String token);
  Future<String> getToken();
  Future<void> deleteToken();
  Future<bool> hasToken();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences sharedPreferences;
  static const String tokenKey = 'AUTH_TOKEN';

  AuthLocalDataSourceImpl(this.sharedPreferences);

  @override
  Future<void> saveToken(String token) async {
    try {
      await sharedPreferences.setString(tokenKey, token);
    } catch (e) {
      throw CacheException('Failed to save token');
    }
  }

  @override
  Future<String> getToken() async {
    try {
      final token = sharedPreferences.getString(tokenKey);
      if (token != null) {
        return token;
      } else {
        throw CacheException('No token found');
      }
    } catch (e) {
      throw CacheException('Failed to get token');
    }
  }

  @override
  Future<void> deleteToken() async {
    try {
      await sharedPreferences.remove(tokenKey);
    } catch (e) {
      throw CacheException('Failed to delete token');
    }
  }

  @override
  Future<bool> hasToken() async {
    try {
      return sharedPreferences.containsKey(tokenKey);
    } catch (e) {
      return false;
    }
  }
}
