import 'package:json_annotation/json_annotation.dart';

part 'bank_model.g.dart';

@JsonSerializable()
class BankModel {
  String? message;
  List<BanksBean>? banks;

  BankModel({this.message, this.banks});

  factory BankModel.fromJson(Map<String, dynamic> json) =>
      _$BankModelFromJson(json);

  Map<String, dynamic> toJson() => _$BankModelToJson(this);
}

@JsonSerializable()
class BanksBean {
  num? id;
  String? name;
  String? slug;
  String? code;

  BanksBean({this.id, this.name, this.slug, this.code});

  factory BanksBean.fromJson(Map<String, dynamic> json) =>
      _$BanksBeanFromJson(json);

  Map<String, dynamic> toJson() => _$BanksBeanToJson(this);
}
