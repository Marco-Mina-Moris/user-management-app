import 'package:equatable/equatable.dart';
import 'package:user_management_app/feature/auth/domain/entities/user_entity.dart';


class LoginEntity extends Equatable {
  final UserEntity user;
  final String accessToken;
  final String refreshToken;

  const LoginEntity({
    required this.user,
    required this.accessToken,
    required this.refreshToken,
  });

  @override
  List<Object> get props => [user, accessToken, refreshToken];
}
