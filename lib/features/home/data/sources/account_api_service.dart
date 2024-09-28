import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:trustlink/features/home/data/models/account/bank_model.dart';
import 'package:trustlink/features/home/data/models/account/card_deposit_model.dart';
import 'package:trustlink/features/home/data/models/account/generated_bank.dart';
import 'package:trustlink/features/home/data/models/account/wallet_history_model.dart';
import 'package:trustlink/features/home/data/models/account/wallet_model.dart';
import 'package:trustlink/features/home/data/models/account/wallet_pay_model.dart';
import 'package:trustlink/features/home/data/models/transaction/transaction_model.dart';

import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/model/response_model.dart';

part 'account_api_service.g.dart';

@RestApi(baseUrl: ApiEndpoints.baseApiUrl)
abstract class AccountApiService {
  factory AccountApiService(Dio dio) = _AccountApiService;

  @GET(ApiEndpoints.getWallet)
  Future<HttpResponse<WalletModel>> getWallet();

  @GET(ApiEndpoints.allBanks)
  Future<HttpResponse<BankModel>> getAllBanks();

  @GET(ApiEndpoints.getTransactionHistory)
  Future<HttpResponse<ResponseModel<TransactionModel>>> getTransactions();

  @GET(ApiEndpoints.getWalletHistory)
  Future<HttpResponse<WalletHistoryModel>> getWalletHistory();

  @POST(ApiEndpoints.saveAccount)
  Future<HttpResponse<ResponseModel>> saveAccount(
      {@Body() required Map<String, dynamic> body});

  @PUT(ApiEndpoints.updateAccount)
  Future<HttpResponse<ResponseModel>> updateAccount(
      {@Body() required Map<String, dynamic> body});

  @PUT(ApiEndpoints.updatePin)
  Future<HttpResponse<ResponseModel>> updatePin(
      {@Body() required Map<String, dynamic> body});

  @PUT(ApiEndpoints.completeRefund)
  Future<HttpResponse<ResponseModel>> completeRefund(
      {@Body() required Map<String, dynamic> body});

  @POST(ApiEndpoints.createWallet)
  Future<HttpResponse<ResponseModel>> createWallet({
    @Body() required Map<String, dynamic> body,
  });

  @POST(ApiEndpoints.withdraw)
  Future<HttpResponse<ResponseModel>> withdraw({
    @Body() required Map<String, dynamic> body,
  });

  @POST(ApiEndpoints.generateAccount)
  Future<HttpResponse<GeneratedBank>> generateAccount({
    @Body() required Map<String, dynamic> body,
  });

  @POST(ApiEndpoints.cardDeposit)
  Future<HttpResponse<CardDepositModel>> cardDeposit({
    @Body() required Map<String, dynamic> body,
  });

  @POST(ApiEndpoints.walletPay)
  Future<HttpResponse<ResponseModel<WalletPayModel>>> walletPay({
    @Body() required Map<String, dynamic> body,
  });

  @POST(ApiEndpoints.generateLink)
  Future<HttpResponse<ResponseModel<String>>> generateLink({
    @Body() required Map<String, dynamic> body,
  });

  @POST(ApiEndpoints.requestRefund)
  Future<HttpResponse<ResponseModel>> requestRefund({
    @Body() required Map<String, dynamic> body,
  });
}
