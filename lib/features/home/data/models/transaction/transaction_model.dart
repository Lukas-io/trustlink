import 'package:json_annotation/json_annotation.dart';
import 'package:trustlink/features/auth/data/models/user_model.dart';

part 'transaction_model.g.dart';

@JsonSerializable()
class TransactionModel {
  num? id;
  String? mode;
  UserModel? sender;
  UserModel? receiver;
  num? amount;
  String? description;
  DateTime? date;
  String? status;
  String? type;

  TransactionModel({
    this.id,
    this.mode,
    this.sender,
    this.receiver,
    this.amount,
    this.description,
    this.date,
    this.status,
    this.type,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionModelFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionModelToJson(this);
}
