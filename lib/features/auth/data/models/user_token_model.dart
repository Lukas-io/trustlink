import 'package:json_annotation/json_annotation.dart';
import 'package:trustlink/features/auth/data/models/user_model.dart';

part 'user_token_model.g.dart';

@JsonSerializable()
class UserTokenModel {
  @JsonKey(name: "access_token")
  final String? token;
  final UserModel? user;

  UserTokenModel({this.token, this.user});

  factory UserTokenModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$UserTokenModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserTokenModelToJson(this);
}
