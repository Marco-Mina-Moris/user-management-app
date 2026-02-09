import 'package:json_annotation/json_annotation.dart';
import 'package:user_management_app/feature/auth/data/models/user_model.dart';
import 'package:user_management_app/feature/auth/domain/entities/login_entity.dart';

part 'login_response_model.g.dart';

@JsonSerializable()
class LoginResponseModel extends LoginEntity {
  @JsonKey(name: 'accessToken')
  final String token;

  @JsonKey(name: 'refreshToken')
  final String refresh;

  const LoginResponseModel({
    required UserModel user,
    required this.token,
    required this.refresh,
  }) : super(
          user: user,
          accessToken: token,
          refreshToken: refresh,
        );

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    // DummyJSON returns user data in the same object
    final userModel = UserModel.fromJson(json);

    return LoginResponseModel(
      user: userModel,
      token: json['accessToken'] ?? '',
      refresh: json['refreshToken'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => $LoginResponseModelToJson(this);
}
