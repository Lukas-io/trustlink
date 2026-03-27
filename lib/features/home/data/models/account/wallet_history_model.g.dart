// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_history_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WalletHistoryModel _$WalletHistoryModelFromJson(Map<String, dynamic> json) =>
    WalletHistoryModel(
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => DataBean.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WalletHistoryModelToJson(WalletHistoryModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'data': instance.data,
    };

DataBean _$DataBeanFromJson(Map<String, dynamic> json) => DataBean(
      id: json['id'] as num?,
      type: json['type'] as String?,
      amount: json['amount'] as num?,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      reference: json['reference'] as String?,
      wallet: json['wallet'] as num?,
    );

Map<String, dynamic> _$DataBeanToJson(DataBean instance) => <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'amount': instance.amount,
      'date': instance.date?.toIso8601String(),
      'reference': instance.reference,
      'wallet': instance.wallet,
    };
