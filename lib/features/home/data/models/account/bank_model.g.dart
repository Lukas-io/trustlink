// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bank_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BankModel _$BankModelFromJson(Map<String, dynamic> json) => BankModel(
      message: json['message'] as String?,
      banks: (json['banks'] as List<dynamic>?)
          ?.map((e) => BanksBean.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BankModelToJson(BankModel instance) => <String, dynamic>{
      'message': instance.message,
      'banks': instance.banks,
    };

BanksBean _$BanksBeanFromJson(Map<String, dynamic> json) => BanksBean(
      id: json['id'] as num?,
      name: json['name'] as String?,
      slug: json['slug'] as String?,
      code: json['code'] as String?,
    );

Map<String, dynamic> _$BanksBeanToJson(BanksBean instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'slug': instance.slug,
      'code': instance.code,
    };
