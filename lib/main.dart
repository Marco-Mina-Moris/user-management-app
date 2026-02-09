import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_management_app/injection_container.dart' as di;
import 'package:user_management_app/injection_container.dart';
import 'feature/auth/presentation/view/login_screen.dart';
import 'feature/auth/presentation/view_model/auth_view_model.dart';
import 'feature/users/presentation/view_model/users_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthViewModel>(
          create: (_) => di.sl<AuthViewModel>(),
        ),
        BlocProvider<UsersViewModel>(
          create: (_) => di.sl<UsersViewModel>()..getUsers(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginScreen(),
      ),
    );
  }
}