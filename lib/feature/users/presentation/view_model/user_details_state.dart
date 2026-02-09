import 'package:user_management_app/feature/users/domain/entities/user.dart';

abstract class UserDetailsState {
  final User user;
  final bool isEditMode;

  const UserDetailsState({
    required this.user,
    required this.isEditMode,
  });
}

class UserDetailsInitial extends UserDetailsState {
  const UserDetailsInitial(User user)
      : super(user: user, isEditMode: false);
}

class UserDetailsLoading extends UserDetailsState {
  const UserDetailsLoading({
    required super.user,
    required super.isEditMode,
  });
}

class UserDetailsSuccess extends UserDetailsState {
  const UserDetailsSuccess({
    required super.user,
    required super.isEditMode,
  });
}

class UserDetailsError extends UserDetailsState {
  final String message;

  const UserDetailsError({
    required this.message,
    required super.user,
    required super.isEditMode,
  });
}
