import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_management_app/feature/users/presentation/view_model/user_details_state.dart';
import 'package:user_management_app/feature/users/presentation/view_model/user_details_view_model.dart';
import 'package:user_management_app/feature/users/presentation/widgets/error_view.dart';
import 'package:user_management_app/feature/users/presentation/widgets/field.dart';
import 'package:user_management_app/feature/users/presentation/widgets/loading_view.dart';
import 'package:user_management_app/feature/users/presentation/widgets/profile_header.dart';

class UserDetailsScreen extends StatelessWidget {
  const UserDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Details'),
        actions: [
          BlocBuilder<UserDetailsViewModel, UserDetailsState>(
            builder: (context, state) {
              return IconButton(
                icon: Icon(
                  state.isEditMode ? Icons.close : Icons.edit,
                ),
                onPressed: () {
                  context.read<UserDetailsViewModel>().toggleEditMode();
                },
              );
            },
          ),
        ],
      ),
      body: BlocConsumer<UserDetailsViewModel, UserDetailsState>(
        listener: (context, state) {
          if (state is UserDetailsSuccess && !state.isEditMode) {
            Navigator.pop(context, state.user);
          }
        },
        builder: (context, state) {
          final viewModel = context.read<UserDetailsViewModel>();

          if (state is UserDetailsLoading) {
            return const LoadingView();
          }

          if (state is UserDetailsError) {
            return ErrorView(
              message: state.message,
              onRetry: viewModel.saveChanges,
            );
          }

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProfileHeader(user: state.user),
                const SizedBox(height: 24),
                Field(
                  label: 'First Name',
                  controller: viewModel.firstNameController,
                  enabled: state.isEditMode,
                ),
                const SizedBox(height: 12),
                Field(
                  label: 'Last Name',
                  controller: viewModel.lastNameController,
                  enabled: state.isEditMode,
                ),
                const SizedBox(height: 12),
                Field(
                  label: 'Email',
                  controller: viewModel.emailController,
                  enabled: state.isEditMode,
                ),
                const Spacer(),
                if (state.isEditMode)
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: viewModel.saveChanges,
                      child: const Text('Save Changes'),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
