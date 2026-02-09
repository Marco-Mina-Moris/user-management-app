import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_management_app/feature/users/domain/entities/user.dart';
import 'package:user_management_app/feature/users/domain/usecases/update_user_usecase.dart';
import 'package:user_management_app/feature/users/presentation/view_model/user_details_state.dart';

class UserDetailsViewModel extends Cubit<UserDetailsState> {
  final UpdateUserUseCase updateUserUseCase;

  UserDetailsViewModel(this.updateUserUseCase) : super(UserDetailsInitial());

  Future<void> updateUser(User user) async {
    emit(UserDetailsLoading());

    final result = await updateUserUseCase(UpdateUserParams(user));

    result.fold(
      (failure) => emit(UserDetailsError(failure.message)),
      (updatedUser) => emit(UserDetailsSuccess(updatedUser)),
    );
  }
}
