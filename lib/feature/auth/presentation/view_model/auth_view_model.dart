import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_management_app/feature/auth/domain/usecases/login_usecase.dart';
import 'package:user_management_app/feature/auth/presentation/view_model/auth_state.dart';


class AuthViewModel extends Cubit<AuthState> {
  final LoginUseCase loginUseCase;

  AuthViewModel(this.loginUseCase) : super(AuthInitial());

  Future<void> login({
    required String username,
    required String password,
  }) async {
    emit(AuthLoading());

    final result = await loginUseCase(
      LoginParams(username: username, password: password),
    );

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (loginEntity) => emit(AuthSuccess(loginEntity)),
    );
  }
}
