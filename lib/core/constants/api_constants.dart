class ApiConstants {
  static const String baseUrl = 'https://dummyjson.com';
  static const String login = '/auth/login';
  static const String users = '/users';
  static const String usersWithPagination = '/users';

  static const int limit = 10;

  static const Map<String, String> headers = {
    'Content-Type': 'application/json',
  };
}
