import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phone;
  final String? username;

  UserModel(
      {this.firstName, this.lastName, this.email, this.phone, this.username});

  factory UserModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
