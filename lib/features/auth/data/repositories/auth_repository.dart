import 'package:trustlink/features/auth/data/models/user_model.dart';
import 'package:trustlink/features/auth/data/models/user_token_model.dart';

import '../../../../core/model/response_model.dart';
import '../../../../core/resources/data_state.dart';
import '../../../../core/resources/perform_request.dart';
import '../sources/auth_api_service.dart';

class AuthRepository {
  final AuthApiService _authApiService;

  AuthRepository(this._authApiService);

  Future<DataState<ResponseModel<UserModel>>> getUserDetails() {
    return performRequest(_authApiService.getUserDetails());
  }

  Future<DataState<ResponseModel<UserTokenModel>>> login(
      Map<String, String> body) {
    return performRequest(_authApiService.login(body: body));
  }

  Future<DataState<ResponseModel<UserModel>>> register(
      Map<String, dynamic> body) {
    return performRequest(_authApiService.register(body: body));
  }

  Future<DataState<ResponseModel>> resendOTP(Map<String, dynamic> body) {
    return performRequest(_authApiService.resendOTP(body: body));
  }

  Future<DataState<ResponseModel>> resetPassword(Map<String, dynamic> body) {
    return performRequest(_authApiService.resetPassword(body: body));
  }

  Future<DataState<ResponseModel>> completeReset(
      Map<String, dynamic> body, String token) {
    return performRequest(
        _authApiService.completeReset(body: body, token: token));
  }

  Future<DataState<ResponseModel>> changePassword(Map<String, dynamic> body) {
    return performRequest(_authApiService.changePassword(body: body));
  }

  Future<DataState<ResponseModel<UserTokenModel>>> verifyMail(
      Map<String, String> body) {
    return performRequest(_authApiService.verifyEmail(body: body));
  }
}
