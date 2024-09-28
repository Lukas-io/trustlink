import 'package:json_annotation/json_annotation.dart';

part 'wallet_history_model.g.dart';

@JsonSerializable()
class WalletHistoryModel {
  String? message;
  List<DataBean>? data;

  WalletHistoryModel({this.message, this.data});

  factory WalletHistoryModel.fromJson(Map<String, dynamic> json) =>
      _$WalletHistoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$WalletHistoryModelToJson(this);
}

@JsonSerializable()
class DataBean {
  num? id;
  String? type;
  num? amount;
  DateTime? date;
  String? reference;
  num? wallet;

  DataBean(
      {this.id,
      this.type,
      this.amount,
      this.date,
      this.reference,
      this.wallet});

  factory DataBean.fromJson(Map<String, dynamic> json) =>
      _$DataBeanFromJson(json);

  Map<String, dynamic> toJson() => _$DataBeanToJson(this);
}
