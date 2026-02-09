import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/user.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends User {
  const UserModel({
    required super.id,
    required super.firstName,
    required super.lastName,
    required super.email,
    required super.username,
    required super.gender,
    super.image,
    super.phone,
    super.age,
    super.birthDate,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  factory UserModel.fromEntity(User entity) {
    return UserModel(
      id: entity.id,
      firstName: entity.firstName,
      lastName: entity.lastName,
      email: entity.email,
      username: entity.username,
      gender: entity.gender,
      image: entity.image,
      phone: entity.phone,
      age: entity.age,
      birthDate: entity.birthDate,
    );
  }

  User toEntity() {
    return User(
      id: id,
      firstName: firstName,
      lastName: lastName,
      email: email,
      username: username,
      gender: gender,
      image: image,
      phone: phone,
      age: age,
      birthDate: birthDate,
    );
  }
}