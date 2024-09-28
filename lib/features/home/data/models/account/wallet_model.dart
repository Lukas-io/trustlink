import 'package:json_annotation/json_annotation.dart';

part 'wallet_model.g.dart';

@JsonSerializable()
class WalletModel {
  String? message;
  WalletBean? wallet;

  WalletModel({this.message, this.wallet});

  factory WalletModel.fromJson(Map<String, dynamic> json) =>
      _$WalletModelFromJson(json);

  Map<String, dynamic> toJson() => _$WalletModelToJson(this);
}

@JsonSerializable()
class WalletBean {
  num? id;
  num? balance;
  num? user;

  WalletBean({this.id, this.balance, this.user});

  factory WalletBean.fromJson(Map<String, dynamic> json) =>
      _$WalletBeanFromJson(json);

  Map<String, dynamic> toJson() => _$WalletBeanToJson(this);
}
