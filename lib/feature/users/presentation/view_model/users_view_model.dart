import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/user.dart';
import '../../domain/usecases/get_users_usecase.dart';
import 'users_state.dart';

class UsersViewModel extends Cubit<UsersState> {
  final GetUsersUseCase getUsersUseCase;

  UsersViewModel(this.getUsersUseCase) : super(UsersInitial());

  int page = 1;
  bool isFetching = false;
  bool hasReachedEnd = false;

  /// Local source of truth for updated users
  final Map<int, User> updatedUsersCache = {};

  Future<void> getUsers({bool refresh = false}) async {
    if (isFetching || hasReachedEnd) return;

    if (refresh) {
      page = 1;
      hasReachedEnd = false;
      emit(UsersLoading());
    }

    isFetching = true;

    final result = await getUsersUseCase(GetUsersParams(page));

    result.fold(
      (failure) {
        isFetching = false;
        emit(UsersError(failure.message));
      },
      (users) {
        isFetching = false;

        if (users.isEmpty) {
          hasReachedEnd = true;
        }

        final currentUsers = state is UsersLoaded && !refresh
            ? (state as UsersLoaded).users
            : <User>[];

        /// Merge API users with local updated users
        final mergedUsers = users.map((user) {
          return updatedUsersCache[user.id] ?? user;
        }).toList();

        emit(
          UsersLoaded(
            refresh ? mergedUsers : [...currentUsers, ...mergedUsers],
          ),
        );

        page++;
      },
    );
  }

  /// Called when user is updated from details screen
  void updateUserInList(User updatedUser) {
    updatedUsersCache[updatedUser.id] = updatedUser;

    if (state is UsersLoaded) {
      final users = List<User>.from(
        (state as UsersLoaded).users,
      );

      final index = users.indexWhere((u) => u.id == updatedUser.id);

      if (index != -1) {
        users[index] = updatedUser;
        emit(UsersLoaded(users));
      }
    }
  }
}
