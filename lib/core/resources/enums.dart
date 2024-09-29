import 'package:json_annotation/json_annotation.dart';

enum TransactionStatus {
  all,
  @JsonValue("Pending")
  pending,
  @JsonValue("Cancelled")
  canceled,
  @JsonValue("Refunded")
  refunded,
  @JsonValue("Completed")
  completed,
}

enum TransactionType {
  @JsonValue("DEBIT")
  debit,
  @JsonValue("CREDIT")
  credit,
}

enum TransactionMode {
  @JsonValue("Wallet")
  wallet,
  @JsonValue("Kora")
  kora,
}
