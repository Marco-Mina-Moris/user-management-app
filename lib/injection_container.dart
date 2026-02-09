import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_management_app/core/network/dio_client.dart';
import 'package:user_management_app/feature/auth/data/datasources/auth_local_data_source.dart';
import 'package:user_management_app/feature/auth/data/datasources/auth_remote_data_source.dart';
import 'package:user_management_app/feature/auth/data/repositories/auth_repository_impl.dart';
import 'package:user_management_app/feature/auth/domain/repositories/auth_repository.dart';
import 'package:user_management_app/feature/auth/domain/usecases/login_usecase.dart';
import 'package:user_management_app/feature/auth/presentation/view_model/auth_view_model.dart';
import 'package:user_management_app/feature/users/data/datasources/users_remote_data_source.dart';
import 'package:user_management_app/feature/users/data/repositories/users_repository_impl.dart';
import 'package:user_management_app/feature/users/domain/entities/user.dart';
import 'package:user_management_app/feature/users/domain/repositories/users_repository.dart';
import 'package:user_management_app/feature/users/domain/usecases/get_users_usecase.dart';
import 'package:user_management_app/feature/users/domain/usecases/update_user_usecase.dart';
import 'package:user_management_app/feature/users/presentation/view_model/user_details_view_model.dart';
import 'package:user_management_app/feature/users/presentation/view_model/users_view_model.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton(() => DioClient());

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  sl.registerFactory(() => AuthViewModel(sl()));

  sl.registerLazySingleton(() => LoginUseCase(sl()));

  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );

  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(sl()),
  );

  sl.registerFactory(() => UsersViewModel(sl()));
  sl.registerFactoryParam<UserDetailsViewModel, User, void>(
    (user, _) => UserDetailsViewModel(
      user: user,
      updateUserUseCase: sl(),
    ),
  );

  sl.registerLazySingleton(() => GetUsersUseCase(sl()));
  sl.registerLazySingleton(() => UpdateUserUseCase(sl()));

  sl.registerLazySingleton<UsersRepository>(
    () => UsersRepositoryImpl(sl()),
  );

  sl.registerLazySingleton<UsersRemoteDataSource>(
    () => UsersRemoteDataSourceImpl(sl()),
  );
}
