import 'package:json_annotation/json_annotation.dart';
import 'package:trustlink/features/auth/data/models/user_model.dart';

part 'wallet_pay_model.g.dart';

@JsonSerializable()
class WalletPayModel {
  num? id;
  String? mode;
  UserModel? sender;
  UserModel? receiver;
  num? amount;
  String? description;
  DateTime? date;

  WalletPayModel(
      {this.id,
      this.mode,
      this.sender,
      this.receiver,
      this.amount,
      this.description,
      this.date});

  factory WalletPayModel.fromJson(Map<String, dynamic> json) =>
      _$WalletPayModelFromJson(json);

  Map<String, dynamic> toJson() => _$WalletPayModelToJson(this);
}
