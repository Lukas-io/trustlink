import 'dart:io';

abstract class AccountEvent {
  const AccountEvent();
}

class GetBanksEvent extends AccountEvent {}

class GetWalletEvent extends AccountEvent {}

class GetUserBankEvent extends AccountEvent {}

class GetTransactionsEvent extends AccountEvent {}

class GetHistoryEvent extends AccountEvent {}

class SaveAccountEvent extends AccountEvent {
  final String code;
  final String accountNumber;

  const SaveAccountEvent({
    required this.code,
    required this.accountNumber,
  });
}

class UpdateAccountEvent extends AccountEvent {
  final String code;
  final String accountNumber;

  const UpdateAccountEvent({
    required this.code,
    required this.accountNumber,
  });
}

class UpdatePinEvent extends AccountEvent {
  final String oldPin;
  final String newPin;
  final String confirm;

  const UpdatePinEvent({
    required this.oldPin,
    required this.newPin,
    required this.confirm,
  });
}

class CompleteRefundEvent extends AccountEvent {
  final String code;
  final String id;

  const CompleteRefundEvent({
    required this.code,
    required this.id,
  });
}

class CreateWalletEvent extends AccountEvent {
  final String pin;

  const CreateWalletEvent({
    required this.pin,
  });
}

class WithdrawEvent extends AccountEvent {
  final num amount;
  final String pin;

  const WithdrawEvent({
    required this.amount,
    required this.pin,
  });
}

class CardDepositEvent extends AccountEvent {
  final num amount;
  final String number;
  final String cvv;
  final String expiryMonth;
  final String expiryYear;

  const CardDepositEvent({
    required this.amount,
    required this.number,
    required this.cvv,
    required this.expiryMonth,
    required this.expiryYear,
  });
}

class WalletPayEvent extends AccountEvent {
  final num amount;
  final String pin;
  final String description;
  final String recipient;

  const WalletPayEvent({
    required this.amount,
    required this.pin,
    required this.description,
    required this.recipient,
  });
}

class GenerateLinkEvent extends AccountEvent {
  final String amount;
  final String customerName;
  final String customerEmail;
  final String narration;

  const GenerateLinkEvent({
    required this.amount,
    required this.customerName,
    required this.customerEmail,
    required this.narration,
  });
}

class RequestRefundEvent extends AccountEvent {
  final String id;
  final String reason;
  final File? proof;

  const RequestRefundEvent({
    required this.id,
    required this.reason,
    this.proof,
  });
}

class VerifyTransactionEvent extends AccountEvent {
  final String code;
  final String id;

  const VerifyTransactionEvent({
    required this.id,
    required this.code,
  });
}
