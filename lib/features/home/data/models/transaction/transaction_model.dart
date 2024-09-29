import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:trustlink/core/constants/app_colors.dart';
import 'package:trustlink/core/resources/enums.dart';
import 'package:trustlink/features/auth/data/models/user_model.dart';

part 'transaction_model.g.dart';

@JsonSerializable()
class TransactionModel {
  num? id;
  TransactionMode? mode;
  UserModel? sender;
  UserModel? receiver;
  num? amount;
  String? description;
  DateTime? date;
  TransactionStatus? status;
  TransactionType? type;

  bool isReceiver(String email) {
    if (receiver!.email == email) {
      return true;
    } else {
      return false;
    }
  }

  Color get colorMode {
    switch (mode) {
      case TransactionMode.wallet:
        return AppColors.primary;
      case TransactionMode.kora:
        return AppColors.kora;

      default:
        return AppColors.primary;
    }
  }

  Color get color {
    switch (status) {
      case TransactionStatus.pending:
        return AppColors.secondary;
      case TransactionStatus.canceled:
        return AppColors.orange;
      case TransactionStatus.refunded:
        return AppColors.purple;
      case TransactionStatus.completed:
        return AppColors.completed;

      default:
        return AppColors.primary;
    }
  }

  IconData get icon {
    switch (status) {
      case TransactionStatus.pending:
        return Icons.hourglass_empty_outlined;
      case TransactionStatus.canceled:
        return Icons.cancel_outlined;
      case TransactionStatus.refunded:
        return Icons.undo;
      case TransactionStatus.completed:
        return Icons.check;

      default:
        return Icons.check;
    }
  }

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
