// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WalletModel _$WalletModelFromJson(Map<String, dynamic> json) => WalletModel(
      message: json['message'] as String?,
      wallet: json['wallet'] == null
          ? null
          : WalletBean.fromJson(json['wallet'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WalletModelToJson(WalletModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'wallet': instance.wallet,
    };

WalletBean _$WalletBeanFromJson(Map<String, dynamic> json) => WalletBean(
      id: json['id'] as num?,
      balance: json['balance'] as num?,
      user: json['user'] as num?,
    );

Map<String, dynamic> _$WalletBeanToJson(WalletBean instance) =>
    <String, dynamic>{
      'id': instance.id,
      'balance': instance.balance,
      'user': instance.user,
    };
