// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_pay_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WalletPayModel _$WalletPayModelFromJson(Map<String, dynamic> json) =>
    WalletPayModel(
      id: json['id'] as num?,
      mode: json['mode'] as String?,
      sender: json['sender'] == null
          ? null
          : UserModel.fromJson(json['sender'] as Map<String, dynamic>),
      receiver: json['receiver'] == null
          ? null
          : UserModel.fromJson(json['receiver'] as Map<String, dynamic>),
      amount: json['amount'] as num?,
      description: json['description'] as String?,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
    );

Map<String, dynamic> _$WalletPayModelToJson(WalletPayModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'mode': instance.mode,
      'sender': instance.sender,
      'receiver': instance.receiver,
      'amount': instance.amount,
      'description': instance.description,
      'date': instance.date?.toIso8601String(),
    };
