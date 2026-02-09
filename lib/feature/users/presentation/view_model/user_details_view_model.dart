import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_management_app/feature/users/domain/entities/user.dart';
import 'package:user_management_app/feature/users/domain/usecases/update_user_usecase.dart';
import 'user_details_state.dart';

class UserDetailsViewModel extends Cubit<UserDetailsState> {
  final UpdateUserUseCase updateUserUseCase;

  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;

  UserDetailsViewModel({
    required User user,
    required this.updateUserUseCase,
  }) : super(UserDetailsInitial(user)) {
    firstNameController = TextEditingController(text: user.firstName);
    lastNameController = TextEditingController(text: user.lastName);
    emailController = TextEditingController(text: user.email);
  }

  void toggleEditMode() {
    emit(
      UserDetailsSuccess(
        user: state.user,
        isEditMode: !state.isEditMode,
      ),
    );
  }

  Future<void> saveChanges() async {
    emit(
      UserDetailsLoading(
        user: state.user,
        isEditMode: state.isEditMode,
      ),
    );

    final updatedUser = state.user.copyWith(
      firstName: firstNameController.text.trim(),
      lastName: lastNameController.text.trim(),
      email: emailController.text.trim(),
    );

    final result = await updateUserUseCase(
      UpdateUserParams(updatedUser),
    );

    result.fold(
      (failure) => emit(
        UserDetailsError(
          message: failure.message,
          user: state.user,
          isEditMode: state.isEditMode,
        ),
      ),
      (user) => emit(
        UserDetailsSuccess(
          user: user,
          isEditMode: false,
        ),
      ),
    );
  }

  @override
  Future<void> close() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    return super.close();
  }
}
