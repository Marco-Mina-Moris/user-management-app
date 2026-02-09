// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponseModel $LoginResponseModelFromJson(Map<String, dynamic> json) =>
    LoginResponseModel(
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
      token: json['accessToken'] as String,
      refresh: json['refreshToken'] as String,
    );

Map<String, dynamic> $LoginResponseModelToJson(LoginResponseModel instance) =>
    <String, dynamic>{
      'user': instance.user,
      'accessToken': instance.token,
      'refreshToken': instance.refresh,
    };
