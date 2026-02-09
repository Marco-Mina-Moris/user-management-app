class ApiConstants {
  static const String baseUrl = 'https://dummyjson.com';
  static const String login = '/auth/login';
  static const String users = '/users';
  static const String usersWithPagination = '/users';

  // Pagination
  static const int limit = 10;

  // Headers
  static const Map<String, String> headers = {
    'Content-Type': 'application/json',
  };
}
