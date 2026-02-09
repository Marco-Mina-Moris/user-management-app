import 'package:user_management_app/feature/users/domain/entities/user.dart';

abstract class UsersState {}

class UsersInitial extends UsersState {}

class UsersLoading extends UsersState {}

class UsersLoaded extends UsersState {
  final List<User> users;
  UsersLoaded({required this.users});
}

class UsersError extends UsersState {
  final String message;
  UsersError({required this.message});
}
