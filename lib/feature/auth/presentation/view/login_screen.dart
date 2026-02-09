import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';

import 'package:user_management_app/core/constants/app_strings.dart';
import 'package:user_management_app/core/dialogs/app_toasts.dart';
import 'package:user_management_app/core/utils/validator.dart';

import 'package:user_management_app/feature/auth/presentation/view_model/auth_state.dart';
import 'package:user_management_app/feature/auth/presentation/view_model/auth_view_model.dart';
import 'package:user_management_app/feature/auth/presentation/widgets/custom_button.dart';
import 'package:user_management_app/feature/auth/presentation/widgets/custom_text_field.dart';
import 'package:user_management_app/main.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const LoginView();
  }
}

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final usernameController = TextEditingController();
    final passwordController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: BlocConsumer<AuthViewModel, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            AppToast.show(
              context: context,
              title: 'Success',
              message: 'Login successful',
              type: ToastificationType.success,
            );

            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (_) => MyApp(
                    loginUseCase: context.read<AuthViewModel>().loginUseCase),
              ),
            );
          }

          if (state is AuthError) {
            AppToast.show(
              context: context,
              title: 'Login Failed',
              message: state.message,
              type: ToastificationType.error,
            );
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: SingleChildScrollView(
              padding:
                  const EdgeInsets.only(left: 24.0, right: 24.0, top: 110.0),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Icon(
                      Icons.account_circle,
                      size: 100,
                      color: Colors.blue,
                    ),
                    const SizedBox(height: 32),
                    const Text(
                      AppStrings.appName,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 48),
                    CustomTextFormField(
                      controller: usernameController,
                      hintText: 'username',
                      prefixIcon: Icons.person,
                      validator: Validator.validateName,
                      action: TextInputAction.next,
                    ),
                    const SizedBox(height: 16),
                    CustomTextFormField(
                      controller: passwordController,
                      hintText: 'password',
                      prefixIcon: Icons.lock,
                      keyboardType: TextInputType.visiblePassword,
                      validator: Validator.validatePassword,
                      isPassword: true,
                      action: TextInputAction.done,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Test credentials: emilys / emilyspass',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color.fromARGB(255, 151, 151, 151),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    CustomButton(
                      text: AppStrings.login,
                      isLoading: state is AuthLoading,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          context.read<AuthViewModel>().login(
                                username: usernameController.text.trim(),
                                password: passwordController.text.trim(),
                              );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
