// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_deposit_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CardDepositModel _$CardDepositModelFromJson(Map<String, dynamic> json) =>
    CardDepositModel(
      amount: json['amount'] as num?,
      amountCharged: json['amount_charged'] as num?,
      authModel: json['auth_model'] as String?,
      currency: json['currency'] as String?,
      fee: json['fee'] as num?,
      vat: json['vat'] as num?,
      responseMessage: json['response_message'] as String?,
      paymentReference: json['payment_reference'] as String?,
      status: json['status'] as String?,
      transactionReference: json['transaction_reference'] as String?,
      card: json['card'] == null
          ? null
          : CardBean.fromJson(json['card'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CardDepositModelToJson(CardDepositModel instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'amount_charged': instance.amountCharged,
      'auth_model': instance.authModel,
      'currency': instance.currency,
      'fee': instance.fee,
      'vat': instance.vat,
      'response_message': instance.responseMessage,
      'payment_reference': instance.paymentReference,
      'status': instance.status,
      'transaction_reference': instance.transactionReference,
      'card': instance.card,
    };

CardBean _$CardBeanFromJson(Map<String, dynamic> json) => CardBean(
      cardType: json['card_type'] as String?,
      firstSix: json['first_six'] as String?,
      lastFour: json['last_four'] as String?,
      expiry: json['expiry'] as String?,
    );

Map<String, dynamic> _$CardBeanToJson(CardBean instance) => <String, dynamic>{
      'card_type': instance.cardType,
      'first_six': instance.firstSix,
      'last_four': instance.lastFour,
      'expiry': instance.expiry,
    };
