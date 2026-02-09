import '../../domain/entities/user.dart';

abstract class UserDetailsState {}

class UserDetailsInitial extends UserDetailsState {}

class UserDetailsLoading extends UserDetailsState {}

class UserDetailsSuccess extends UserDetailsState {
  final User user;
  UserDetailsSuccess(this.user);
}

class UserDetailsError extends UserDetailsState {
  final String message;
  UserDetailsError(this.message);
}
