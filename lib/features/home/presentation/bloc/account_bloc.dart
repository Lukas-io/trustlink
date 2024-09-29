import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trustlink/features/home/data/models/account/bank_model.dart';
import 'package:trustlink/features/home/data/models/account/wallet_history_model.dart';
import 'package:trustlink/features/home/data/models/account/wallet_model.dart';
import 'package:trustlink/features/home/data/models/transaction/transaction_model.dart';

import '../../../../core/resources/data_state.dart';
import '../../data/repositories/account_repository.dart';
import 'account_event.dart';
import 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final AccountRepository _accountRepository;

  AccountBloc(this._accountRepository) : super(const AccountInitial()) {
    on<GetBanksEvent>(onGetBanks);
    on<GetWalletEvent>(onGetWallet);
    on<GetUserBankEvent>(onGetUserBank);
    on<GetTransactionsEvent>(onGetTransactions);
    on<GetHistoryEvent>(onGetHistory);
    on<SaveAccountEvent>(onSaveAccount);
    on<UpdateAccountEvent>(onUpdateAccount);
    on<UpdatePinEvent>(onUpdatePin);
    on<CompleteRefundEvent>(onCompleteRefund);
    on<CreateWalletEvent>(onCreateWallet);
    on<WithdrawEvent>(onWithdraw);
    on<CardDepositEvent>(onCardDeposit);
    on<WalletPayEvent>(onWalletPay);
    on<GenerateLinkEvent>(onGenerateLink);
    on<RequestRefundEvent>(onRequestRefund);
    on<VerifyTransactionEvent>(onVerifyTransaction);
  }

  void onGetBanks(GetBanksEvent event, Emitter<AccountState> emit) async {
    emit(const AccountLoading<GetBanksEvent>());
    final dataState = await _accountRepository.getAllBanks();
    if (dataState is DataSuccess) {
      emit(AccountSuccess<GetBanksEvent, BankModel>(data: dataState.data!));
    } else {
      emit(AccountException<GetBanksEvent>((dataState.exception!).message!));
    }
  }

  void onGetWallet(GetWalletEvent event, Emitter<AccountState> emit) async {
    emit(const AccountLoading<GetWalletEvent>());
    final dataState = await _accountRepository.getWallet();
    if (dataState is DataSuccess) {
      emit(AccountSuccess<GetWalletEvent, WalletModel>(data: dataState.data!));
    } else {
      emit(AccountException<GetWalletEvent>((dataState.exception!).message!));
    }
  }

  void onGetUserBank(GetUserBankEvent event, Emitter<AccountState> emit) async {
    emit(const AccountLoading<GetUserBankEvent>());
    final dataState = await _accountRepository.getUserBank();
    if (dataState is DataSuccess) {
      emit(AccountSuccess<GetUserBankEvent, BanksBean>(
          data: dataState.data!.data));
    } else {
      emit(AccountException<GetUserBankEvent>((dataState.exception!).message!));
    }
  }

  void onGetTransactions(
      GetTransactionsEvent event, Emitter<AccountState> emit) async {
    emit(const AccountLoading<GetTransactionsEvent>());
    final dataState = await _accountRepository.getTransactions();
    if (dataState is DataSuccess) {
      emit(AccountSuccess<GetTransactionsEvent, List<TransactionModel>>(
          data: dataState.data!.data!));
    } else {
      emit(AccountException<GetTransactionsEvent>(
          (dataState.exception!).message!));
    }
  }

  void onGetHistory(GetHistoryEvent event, Emitter<AccountState> emit) async {
    emit(const AccountLoading<GetHistoryEvent>());
    final dataState = await _accountRepository.getWalletHistory();
    if (dataState is DataSuccess) {
      emit(AccountSuccess<GetHistoryEvent, WalletHistoryModel>(
          data: dataState.data!));
    } else {
      emit(AccountException<GetHistoryEvent>((dataState.exception!).message!));
    }
  }

  void onSaveAccount(SaveAccountEvent event, Emitter<AccountState> emit) async {
    emit(const AccountLoading<SaveAccountEvent>());
    final dataState = await _accountRepository.saveAccount({
      "account_number": event.accountNumber,
      "code": event.code,
    });
    if (dataState is DataSuccess) {
      emit(AccountSuccess<SaveAccountEvent, String>(
          data: dataState.data!.message!));
    } else {
      emit(AccountException<SaveAccountEvent>((dataState.exception!).message!));
    }
  }

  void onUpdateAccount(
      UpdateAccountEvent event, Emitter<AccountState> emit) async {
    emit(const AccountLoading<UpdateAccountEvent>());
    final dataState = await _accountRepository.updateAccount({
      "account_number": event.accountNumber,
      "code": event.code,
    });
    if (dataState is DataSuccess) {
      emit(AccountSuccess<UpdateAccountEvent, String>(
          data: dataState.data!.message!));
    } else {
      emit(AccountException<UpdateAccountEvent>(
          (dataState.exception!).message!));
    }
  }

  void onUpdatePin(UpdatePinEvent event, Emitter<AccountState> emit) async {
    emit(const AccountLoading<UpdatePinEvent>());
    final dataState = await _accountRepository.updatePin({
      "new_pin": event.oldPin,
      "old_pin": event.newPin,
      "confirm": event.confirm,
    });
    if (dataState is DataSuccess) {
      emit(AccountSuccess<UpdatePinEvent, String>(
          data: dataState.data!.message!));
    } else {
      emit(AccountException<UpdatePinEvent>((dataState.exception!).message!));
    }
  }

  void onCompleteRefund(
      CompleteRefundEvent event, Emitter<AccountState> emit) async {
    emit(const AccountLoading<CompleteRefundEvent>());
    final dataState = await _accountRepository.completeRefund({
      "code": event.code,
    });
    if (dataState is DataSuccess) {
      emit(AccountSuccess<CompleteRefundEvent, String>(
          data: dataState.data!.message!));
    } else {
      emit(AccountException<CompleteRefundEvent>(
          (dataState.exception!).message!));
    }
  }

  void onCreateWallet(
      CreateWalletEvent event, Emitter<AccountState> emit) async {
    emit(const AccountLoading<CreateWalletEvent>());
    final dataState = await _accountRepository.createWallet({
      "pin": event.pin,
    });
    if (dataState is DataSuccess) {
      emit(AccountSuccess<CreateWalletEvent, String>(
          data: dataState.data!.message!));
    } else {
      emit(
          AccountException<CreateWalletEvent>((dataState.exception!).message!));
    }
  }

  void onWithdraw(WithdrawEvent event, Emitter<AccountState> emit) async {
    emit(const AccountLoading<WithdrawEvent>());
    final dataState = await _accountRepository.withdraw({
      "amount": event.amount,
      "pin": event.pin,
    });
    if (dataState is DataSuccess) {
      emit(AccountSuccess<WithdrawEvent, String>(
          data: dataState.data!.message!));
      // emit(AccountEmailUnverified(event.id));
    } else {
      emit(AccountException<WithdrawEvent>((dataState.exception!).message!));
    }
  }

  void onCardDeposit(CardDepositEvent event, Emitter<AccountState> emit) async {
    emit(const AccountLoading<CardDepositEvent>());
    final dataState = await _accountRepository.cardDeposit({
      "amount": event.amount,
      "number": event.number,
      "cvv": event.cvv,
      "expiry_month": event.expiryMonth,
      "expiry_year": event.expiryYear,
    });
    if (dataState is DataSuccess) {
      emit(AccountSuccess<CardDepositEvent, String>(
          data: dataState.data!.responseMessage));
    } else {
      emit(AccountException<CardDepositEvent>((dataState.exception!).message!));
    }
  }

  void onWalletPay(WalletPayEvent event, Emitter<AccountState> emit) async {
    emit(const AccountLoading<WalletPayEvent>());
    final dataState = await _accountRepository.walletPay({
      "amount": event.amount,
      "pin": event.pin,
      "description": event.description,
      "recipient": event.recipient,
    });
    if (dataState is DataSuccess) {
      emit(AccountSuccess<WalletPayEvent, String>(
          data: dataState.data!.message));
      // emit(AccountEmailUnverified(event.id));
    } else {
      emit(AccountException<WalletPayEvent>((dataState.exception!).message!));
    }
  }

  void onGenerateLink(
      GenerateLinkEvent event, Emitter<AccountState> emit) async {
    emit(const AccountLoading<GenerateLinkEvent>());
    final dataState = await _accountRepository.generateLink({
      "amount": event.amount,
      "customer_name": event.customerName,
      "customer_email": event.customerEmail,
      "narration": event.narration,
    });
    if (dataState is DataSuccess) {
      emit(AccountSuccess<GenerateLinkEvent, String>(
          data: dataState.data!.data!));
    } else {
      emit(
          AccountException<GenerateLinkEvent>((dataState.exception!).message!));
    }
  }

  void onVerifyTransaction(
      VerifyTransactionEvent event, Emitter<AccountState> emit) async {
    emit(const AccountLoading<VerifyTransactionEvent>());
    final dataState = await _accountRepository.verifyTransaction(
      {
        "code": event.code,
      },
      event.id,
    );
    if (dataState is DataSuccess) {
      emit(AccountSuccess<VerifyTransactionEvent, String>(
          data: dataState.data!.message));
    } else {
      emit(AccountException<VerifyTransactionEvent>(
          (dataState.exception!).message!));
    }
  }

  void onRequestRefund(
      RequestRefundEvent event, Emitter<AccountState> emit) async {
    emit(const AccountLoading<RequestRefundEvent>());
    final dataState = await _accountRepository.requestRefund(
      {
        "reason": event.reason,
        "proof": event.proof,
      },
      event.id,
    );
    if (dataState is DataSuccess) {
      emit(AccountSuccess<RequestRefundEvent, String>(
          data: dataState.data!.message));
    } else {
      emit(AccountException<RequestRefundEvent>(
          (dataState.exception!).message!));
    }
  }
}
