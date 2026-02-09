import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_management_app/feature/auth/presentation/view/login_screen.dart';
import 'package:user_management_app/feature/users/domain/entities/user.dart';
import 'package:user_management_app/feature/users/presentation/view/user_details_screen.dart';
import 'package:user_management_app/feature/users/presentation/view_model/user_details_view_model.dart';
import 'package:user_management_app/feature/users/presentation/view_model/users_state.dart';
import 'package:user_management_app/feature/users/presentation/view_model/users_view_model.dart';
import 'package:user_management_app/feature/users/presentation/widgets/error_view.dart';
import 'package:user_management_app/feature/users/presentation/widgets/loading_view.dart';
import 'package:user_management_app/feature/users/presentation/widgets/user_card.dart';
import 'package:user_management_app/injection_container.dart';

class UsersListScreen extends StatelessWidget {
  const UsersListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<UsersViewModel>()..getUsers(),
      child: const UsersListView(),
    );
  }
}

class UsersListView extends StatelessWidget {
  const UsersListView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<UsersViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const LoginScreen()),
                (_) => false,
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<UsersViewModel, UsersState>(
        builder: (context, state) {
          if (state is UsersLoading && state is! UsersLoaded) {
            return const LoadingView();
          }

          if (state is UsersError) {
            return ErrorView(
              message: state.message,
              onRetry: () => viewModel.getUsers(refresh: true),
            );
          }

          if (state is UsersLoaded) {
            return RefreshIndicator(
              onRefresh: () async {
                await viewModel.getUsers(refresh: true);
              },
              child: NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification scrollInfo) {
                  if (scrollInfo.metrics.pixels >= scrollInfo.metrics.maxScrollExtent * 0.9) {
                    viewModel.getUsers();
                  }
                  return false;
                },
                child: ListView.builder(
                  itemCount: state.users.length + 1,
                  itemBuilder: (context, index) {
                    if (index >= state.users.length) {
                      return viewModel.hasReachedMax
                          ? const SizedBox.shrink()
                          : const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                    }

                    final User user = state.users[index];

                    return UserCard(
                      user: user,
                      onTap: () async {
                        final updatedUser = await Navigator.push<User>(
                          context,
                          MaterialPageRoute(
                            builder: (_) => BlocProvider(
                              create: (_) => sl<UserDetailsViewModel>(
                                param1: user,
                              ),
                              child: const UserDetailsScreen(),
                            ),
                          ),
                        );

                        if (updatedUser != null) {
                          viewModel.updateUserInList(updatedUser);
                        }
                      },
                    );
                  },
                ),
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}