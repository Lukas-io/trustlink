// import 'package:trustlink/features/auth/data/models/user_model.dart';
// import 'package:trustlink/features/auth/data/models/user_token_model.dart';
//
// import '../../../../core/model/response_model.dart';
// import '../../../../core/resources/data_state.dart';
// import '../../../../core/resources/perform_request.dart';
// import '../sources/transaction_api_service.dart';
//
// class TransactionRepository {
//   final TransactionApiService _transactionApiService;
//
//   TransactionRepository(this._transactionApiService);
//
//   Future<DataState<ResponseModel<UserModel>>> getUserDetails() {
//     return performRequest(_transactionApiService.getUserDetails());
//   }
//
//   Future<DataState<ResponseModel<UserTokenModel>>> login(
//       Map<String, String> body) {
//     return performRequest(_transactionApiService.login(body: body));
//   }
// }
