import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_management_app/core/network/dio_client.dart';
import 'package:user_management_app/feature/auth/presentation/view/login_screen.dart';
import 'package:user_management_app/feature/users/data/datasources/users_remote_data_source.dart';
import 'package:user_management_app/feature/users/data/repositories/users_repository_impl.dart';
import 'package:user_management_app/feature/users/domain/usecases/update_user_usecase.dart';
import 'package:user_management_app/feature/users/presentation/view/user_details_Screen.dart';
import 'package:user_management_app/feature/users/presentation/view_model/user_details_view_model.dart';
import 'package:user_management_app/feature/users/presentation/view_model/users_state.dart';
import 'package:user_management_app/feature/users/presentation/view_model/users_view_model.dart';
import 'package:user_management_app/feature/users/presentation/widgets/error_view.dart';
import 'package:user_management_app/feature/users/presentation/widgets/loading_view.dart';
import 'package:user_management_app/feature/users/presentation/widgets/user_card.dart';

class UsersListScreen extends StatelessWidget {
  const UsersListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => context.read<UsersViewModel>()..getUsers(),
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
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<UsersViewModel, UsersState>(
        builder: (context, state) {
          if (state is UsersLoading) {
            return const LoadingView();
          }

          if (state is UsersError) {
            return ErrorView(
              message: state.message,
              onRetry: () => viewModel.getUsers(refresh: true),
            );
          }

          if (state is UsersLoaded) {
            return NotificationListener<ScrollNotification>(
              onNotification: (scrollInfo) {
                if (scrollInfo.metrics.pixels ==
                    scrollInfo.metrics.maxScrollExtent) {
                  viewModel.getUsers();
                }
                return false;
              },
              child: RefreshIndicator(
                onRefresh: () async {
                  context.read<UsersViewModel>().getUsers(refresh: true);
                },
                child: ListView.builder(
                  itemCount: state.users.length,
                  itemBuilder: (context, index) {
                    return UserCard(
                      user: state.users[index],
                      onTap: () async {
                        final updatedUser = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => BlocProvider(
                              create: (_) => UserDetailsViewModel(
                                UpdateUserUseCase(
                                  UsersRepositoryImpl(
                                    UsersRemoteDataSourceImpl(
                                      DioClient(),
                                    ),
                                  ),
                                ),
                              ),
                              child: UserDetailsScreen(user: state.users[index]),
                            ),
                          ),
                        );

                        if (updatedUser != null) {
                          context
                              .read<UsersViewModel>()
                              .updateUserInList(updatedUser);
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
