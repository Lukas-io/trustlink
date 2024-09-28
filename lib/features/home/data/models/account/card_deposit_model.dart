import 'package:json_annotation/json_annotation.dart';

part 'card_deposit_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CardDepositModel {
  num? amount;
  num? amountCharged;
  String? authModel;
  String? currency;
  num? fee;
  num? vat;
  String? responseMessage;
  String? paymentReference;
  String? status;
  String? transactionReference;

  // MetadataBean? metadata;
  CardBean? card;

  CardDepositModel(
      {this.amount,
      this.amountCharged,
      this.authModel,
      this.currency,
      this.fee,
      this.vat,
      this.responseMessage,
      this.paymentReference,
      this.status,
      this.transactionReference,
      // this.metadata,
      this.card});

  factory CardDepositModel.fromJson(Map<String, dynamic> json) =>
      _$CardDepositModelFromJson(json);

  Map<String, dynamic> toJson() => _$CardDepositModelToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class CardBean {
  String? cardType;
  String? firstSix;
  String? lastFour;
  String? expiry;

  CardBean({this.cardType, this.firstSix, this.lastFour, this.expiry});

  factory CardBean.fromJson(Map<String, dynamic> json) =>
      _$CardBeanFromJson(json);

  Map<String, dynamic> toJson() => _$CardBeanToJson(this);
}
//
// @JsonSerializable(fieldRename: FieldRename.snake)
// class MetadataBean {
//   String? gatewayCode;
//   String? stan;
//   String? receipt;
//   String? supportMessage;
//
//   MetadataBean(
//       {this.gatewayCode, this.stan, this.receipt, this.supportMessage});
//
//   factory MetadataBean.fromJson(Map<String, dynamic> json) =>
//       _$MetadataBeanFromJson(json);
//
//   Map<String, dynamic> toJson() => _$MetadataBeanToJson(this);
// }
