// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionModel _$TransactionModelFromJson(Map<String, dynamic> json) =>
    TransactionModel(
      id: json['id'] as num?,
      mode: $enumDecodeNullable(_$TransactionModeEnumMap, json['mode']),
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
      status: $enumDecodeNullable(_$TransactionStatusEnumMap, json['status']),
      type: $enumDecodeNullable(_$TransactionTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$TransactionModelToJson(TransactionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'mode': _$TransactionModeEnumMap[instance.mode],
      'sender': instance.sender,
      'receiver': instance.receiver,
      'amount': instance.amount,
      'description': instance.description,
      'date': instance.date?.toIso8601String(),
      'status': _$TransactionStatusEnumMap[instance.status],
      'type': _$TransactionTypeEnumMap[instance.type],
    };

const _$TransactionModeEnumMap = {
  TransactionMode.wallet: 'Wallet',
  TransactionMode.kora: 'Kora',
};

const _$TransactionStatusEnumMap = {
  TransactionStatus.all: 'all',
  TransactionStatus.pending: 'Pending',
  TransactionStatus.canceled: 'Cancelled',
  TransactionStatus.refunded: 'Refunded',
  TransactionStatus.completed: 'Completed',
};

const _$TransactionTypeEnumMap = {
  TransactionType.debit: 'DEBIT',
  TransactionType.credit: 'CREDIT',
};
