import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String username;
  final String gender;
  final String? image;
  final String? phone;
  final int? age;
  final String? birthDate;

  const User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.username,
    required this.gender,
    this.image,
    this.phone,
    this.age,
    this.birthDate,
  });

  User copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? email,
    String? username,
    String? gender,
    String? image,
    String? phone,
    int? age,
    String? birthDate,
  }) {
    return User(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      username: username ?? this.username,
      gender: gender ?? this.gender,
      image: image ?? this.image,
      phone: phone ?? this.phone,
      age: age ?? this.age,
      birthDate: birthDate ?? this.birthDate,
    );
  }

  @override
  List<Object?> get props => [
        id,
        firstName,
        lastName,
        email,
        username,
        gender,
        image,
        phone,
        age,
        birthDate,
      ];
}
