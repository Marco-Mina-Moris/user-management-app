import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'feature/auth/presentation/view/login_screen.dart';
import 'feature/auth/presentation/view_model/auth_view_model.dart';

// ===== Auth dependencies =====
import 'feature/auth/data/datasources/auth_remote_data_source.dart';
import 'feature/auth/data/datasources/auth_local_data_source.dart';
import 'feature/auth/data/repositories/auth_repository_impl.dart';
import 'feature/auth/domain/usecases/login_usecase.dart';
import 'core/network/dio_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ===== Manual DI (Auth only) =====
  final dioClient = DioClient();
  final sharedPreferences = await SharedPreferences.getInstance();

  final authRemoteDataSource =
      AuthRemoteDataSourceImpl(dioClient);
  final authLocalDataSource =
      AuthLocalDataSourceImpl(sharedPreferences);

  final authRepository = AuthRepositoryImpl(
    remoteDataSource: authRemoteDataSource,
    localDataSource: authLocalDataSource,
  );

  final loginUseCase = LoginUseCase(authRepository);

  runApp(
    MyApp(loginUseCase: loginUseCase),
  );
}

class MyApp extends StatelessWidget {
  final LoginUseCase loginUseCase;

  const MyApp({
    super.key,
    required this.loginUseCase,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthViewModel>(
      create: (_) => AuthViewModel(loginUseCase),
      child: MaterialApp(
        title: 'User Management',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
          appBarTheme: const AppBarTheme(
            centerTitle: true,
            elevation: 0,
          ),
        ),
        home: const LoginScreen(),
      ),
    );
  }
}
