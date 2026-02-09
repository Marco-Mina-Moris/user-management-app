// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UsersResponseModel $UsersResponseModelFromJson(Map<String, dynamic> json) =>
    UsersResponseModel(
      users: (json['users'] as List<dynamic>)
          .map((e) => UserModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: json['total'] as int,
      skip: json['skip'] as int,
      limit: json['limit'] as int,
    );

Map<String, dynamic> $UsersResponseModelToJson(UsersResponseModel instance) =>
    <String, dynamic>{
      'users': instance.users,
      'total': instance.total,
      'skip': instance.skip,
      'limit': instance.limit,
    };
