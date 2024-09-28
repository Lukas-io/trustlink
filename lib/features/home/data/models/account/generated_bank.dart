import 'package:json_annotation/json_annotation.dart';

part 'generated_bank.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class GeneratedBank {
  String? accountName;
  String? accountNumber;
  String? bankName;
  String? bankCode;
  DateTime? expiryDateInUtc;

  GeneratedBank({
    this.accountName,
    this.accountNumber,
    this.bankName,
    this.bankCode,
    this.expiryDateInUtc,
  });

  factory GeneratedBank.fromJson(Map<String, dynamic> json) =>
      _$GeneratedBankFromJson(json);

  Map<String, dynamic> toJson() => _$GeneratedBankToJson(this);
}
