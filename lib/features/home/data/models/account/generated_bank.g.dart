// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generated_bank.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GeneratedBank _$GeneratedBankFromJson(Map<String, dynamic> json) =>
    GeneratedBank(
      accountName: json['account_name'] as String?,
      accountNumber: json['account_number'] as String?,
      bankName: json['bank_name'] as String?,
      bankCode: json['bank_code'] as String?,
      expiryDateInUtc: json['expiry_date_in_utc'] == null
          ? null
          : DateTime.parse(json['expiry_date_in_utc'] as String),
    );

Map<String, dynamic> _$GeneratedBankToJson(GeneratedBank instance) =>
    <String, dynamic>{
      'account_name': instance.accountName,
      'account_number': instance.accountNumber,
      'bank_name': instance.bankName,
      'bank_code': instance.bankCode,
      'expiry_date_in_utc': instance.expiryDateInUtc?.toIso8601String(),
    };
