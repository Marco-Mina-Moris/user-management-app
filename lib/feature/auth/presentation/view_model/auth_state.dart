import 'package:user_management_app/feature/auth/domain/entities/login_entity.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final LoginEntity loginEntity;
  AuthSuccess(this.loginEntity);
}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}
