// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'] as int,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      username: json['username'] as String,
      gender: json['gender'] as String,
      image: json['image'] as String?,
      phone: json['phone'] as String?,
      age: json['age'] as int?,
      birthDate: json['birthDate'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'username': instance.username,
      'gender': instance.gender,
      'image': instance.image,
      'phone': instance.phone,
      'age': instance.age,
      'birthDate': instance.birthDate,
    };
