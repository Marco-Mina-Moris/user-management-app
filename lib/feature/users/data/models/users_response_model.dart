import 'package:json_annotation/json_annotation.dart';
import 'user_model.dart';

part 'users_response_model.g.dart';

@JsonSerializable()
class UsersResponseModel {
  final List<UserModel> users;
  final int total;
  final int skip;
  final int limit;

  UsersResponseModel({
    required this.users,
    required this.total,
    required this.skip,
    required this.limit,
  });

  factory UsersResponseModel.fromJson(Map<String, dynamic> json) =>
      _$UsersResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$UsersResponseModelToJson(this);
}
