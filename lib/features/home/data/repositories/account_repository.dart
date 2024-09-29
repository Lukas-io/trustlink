import 'package:trustlink/features/home/data/models/account/bank_model.dart';
import 'package:trustlink/features/home/data/models/account/card_deposit_model.dart';
import 'package:trustlink/features/home/data/models/account/generated_bank.dart';
import 'package:trustlink/features/home/data/models/account/wallet_history_model.dart';
import 'package:trustlink/features/home/data/models/account/wallet_model.dart';
import 'package:trustlink/features/home/data/models/account/wallet_pay_model.dart';
import 'package:trustlink/features/home/data/models/transaction/transaction_model.dart';
import 'package:trustlink/features/home/data/sources/account_api_service.dart';

import '../../../../core/model/response_model.dart';
import '../../../../core/resources/data_state.dart';
import '../../../../core/resources/perform_request.dart';

class AccountRepository {
  final AccountApiService _accountApiService;

  AccountRepository(this._accountApiService);

  Future<DataState<BankModel>> getAllBanks() {
    return performRequest(_accountApiService.getAllBanks());
  }

  Future<DataState<WalletModel>> getWallet() {
    return performRequest(_accountApiService.getWallet());
  }

  Future<DataState<ResponseModel<BanksBean>>> getUserBank() {
    return performRequest(_accountApiService.getUserBank());
  }

  Future<DataState<WalletHistoryModel>> getWalletHistory() {
    return performRequest(_accountApiService.getWalletHistory());
  }

  Future<DataState<ResponseModel<List<TransactionModel>>>> getTransactions() {
    return performRequest(_accountApiService.getTransactions());
  }

  Future<DataState<ResponseModel>> saveAccount(Map<String, dynamic> body) {
    return performRequest(_accountApiService.saveAccount(body: body));
  }

  Future<DataState<ResponseModel>> updateAccount(Map<String, dynamic> body) {
    return performRequest(_accountApiService.updateAccount(body: body));
  }

  Future<DataState<ResponseModel>> updatePin(Map<String, dynamic> body) {
    return performRequest(_accountApiService.updatePin(body: body));
  }

  Future<DataState<ResponseModel>> completeRefund(Map<String, dynamic> body) {
    return performRequest(_accountApiService.completeRefund(body: body));
  }

  Future<DataState<ResponseModel>> createWallet(Map<String, dynamic> body) {
    return performRequest(_accountApiService.createWallet(body: body));
  }

  Future<DataState<GeneratedBank>> generateAccount(Map<String, dynamic> body) {
    return performRequest(_accountApiService.generateAccount(body: body));
  }

  Future<DataState<CardDepositModel>> cardDeposit(Map<String, dynamic> body) {
    print(body);
    return performRequest(_accountApiService.cardDeposit(body: body));
  }

//
//   {
//   "number":"4084127883172787",
//   "cvv":"123",
//   "expiry_month":"09",
//   "expiry_year":"30",
//   "amount":900000
//   }
//   {
//   "number": "408412788317278",
//   "cvv": "123",
//   "expiry_month": "09",
//   "expiry_year": "30",
//     "amount": 3233223
//
// }
  Future<DataState<ResponseModel>> withdraw(Map<String, dynamic> body) {
    return performRequest(_accountApiService.withdraw(body: body));
  }

  Future<DataState<ResponseModel<WalletPayModel>>> walletPay(
      Map<String, dynamic> body) {
    return performRequest(_accountApiService.walletPay(body: body));
  }

  Future<DataState<ResponseModel<String>>> generateLink(
      Map<String, dynamic> body) {
    return performRequest(_accountApiService.generateLink(body: body));
  }

  Future<DataState<ResponseModel>> verifyTransaction(
      Map<String, dynamic> body, String id) {
    return performRequest(
        _accountApiService.verifyTransaction(body: body, id: id));
  }

  Future<DataState<ResponseModel>> requestRefund(
      Map<String, dynamic> body, String id) {
    return performRequest(_accountApiService.requestRefund(body: body, id: id));
  }

// Future<DataState<GeneratedBank>> generateAccount(Map<String, dynamic> body) {
//   return performRequest(_accountApiService.generateAccount(body: body));
// }
}
