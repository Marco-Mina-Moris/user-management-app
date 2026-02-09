import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_management_app/feature/users/domain/entities/user.dart';
import 'package:user_management_app/feature/users/presentation/view_model/user_details_state.dart';
import 'package:user_management_app/feature/users/presentation/view_model/user_details_view_model.dart';
import 'package:user_management_app/feature/users/presentation/widgets/error_view.dart';
import 'package:user_management_app/feature/users/presentation/widgets/field.dart';
import 'package:user_management_app/feature/users/presentation/widgets/loading_view.dart';
import 'package:user_management_app/feature/users/presentation/widgets/profile_header.dart';

class UserDetailsScreen extends StatelessWidget {
  final User user;

  UserDetailsScreen({
    super.key,
    required this.user,
  });

  final ValueNotifier<bool> isEditMode = ValueNotifier(false);

  late final TextEditingController firstNameController =
      TextEditingController(text: user.firstName);
  late final TextEditingController lastNameController =
      TextEditingController(text: user.lastName);
  late final TextEditingController emailController =
      TextEditingController(text: user.email);

  User buildUpdatedUser() {
    return user.copyWith(
      firstName: firstNameController.text.trim(),
      lastName: lastNameController.text.trim(),
      email: emailController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<UserDetailsViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('User Details'),
        actions: [
          ValueListenableBuilder<bool>(
            valueListenable: isEditMode,
            builder: (context, edit, _) {
              return IconButton(
                icon: Icon(edit ? Icons.close : Icons.edit),
                onPressed: () => isEditMode.value = !edit,
              );
            },
          ),
        ],
      ),
      body: BlocConsumer<UserDetailsViewModel, UserDetailsState>(
        listener: (context, state) {
          if (state is UserDetailsSuccess) {
            Navigator.pop(context, state.user);
          }
        },
        builder: (context, state) {
          if (state is UserDetailsLoading) {
            return const LoadingView();
          }

          if (state is UserDetailsError) {
            return ErrorView(
              message: state.message,
              onRetry: () => viewModel.updateUser(buildUpdatedUser()),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(16),
            child: ValueListenableBuilder<bool>(
              valueListenable: isEditMode,
              builder: (context, edit, _) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProfileHeader(user: user),
                    const SizedBox(height: 24),
                    Field(
                      label: 'First Name',
                      controller: firstNameController,
                      enabled: edit,
                    ),
                    const SizedBox(height: 12),
                    Field(
                      label: 'Last Name',
                      controller: lastNameController,
                      enabled: edit,
                    ),
                    const SizedBox(height: 12),
                    Field(
                      label: 'Email',
                      controller: emailController,
                      enabled: edit,
                    ),
                    const Spacer(),
                    if (edit)
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => viewModel.updateUser(
                            buildUpdatedUser(),
                          ),
                          child: const Text('Save Changes'),
                        ),
                      ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
