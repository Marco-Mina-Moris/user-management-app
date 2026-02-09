import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_management_app/feature/users/domain/entities/user.dart';
import 'package:user_management_app/feature/users/domain/usecases/get_users_usecase.dart';
import 'package:user_management_app/feature/users/presentation/view_model/users_state.dart';

class UsersViewModel extends Cubit<UsersState> {
  final GetUsersUseCase getUsersUseCase;

  UsersViewModel(this.getUsersUseCase) : super(UsersInitial());

  int page = 1;
  final int limit = 10;
  bool isFetching = false;
  bool hasReachedMax = false;

  /// cache for locally updated users (DummyJSON workaround)
  final Map<int, User> updatedUsersCache = {};

  Future<void> getUsers({bool refresh = false}) async {
    if (isFetching || hasReachedMax) return;

    if (refresh) {
      page = 1;
      hasReachedMax = false;
      emit(UsersLoading());
    }

    isFetching = true;

    final result = await getUsersUseCase(
      GetUsersParams(
        page: page,
        limit: limit,
      ),
    );

    result.fold(
      (failure) {
        isFetching = false;
        emit(UsersError(message: failure.message));
      },
      (users) {
        isFetching = false;

        if (users.isEmpty) {
          hasReachedMax = true;
          return;
        }

        /// merge API users with locally updated users
        final mergedUsers = users.map((user) {
          return updatedUsersCache[user.id] ?? user;
        }).toList();

        final currentUsers = state is UsersLoaded && !refresh
            ? (state as UsersLoaded).users
            : <User>[];

        emit(
          UsersLoaded(
            users: [...currentUsers, ...mergedUsers],
          ),
        );

        page++;
      },
    );
  }

  /// called after returning from UserDetailsScreen
  void updateUserInList(User updatedUser) {
    if (state is! UsersLoaded) return;

    updatedUsersCache[updatedUser.id] = updatedUser;

    final currentUsers = List<User>.from(
      (state as UsersLoaded).users,
    );

    final index = currentUsers.indexWhere((u) => u.id == updatedUser.id);

    if (index == -1) return;

    currentUsers[index] = updatedUser;

    emit(UsersLoaded(users: currentUsers));
  }
}