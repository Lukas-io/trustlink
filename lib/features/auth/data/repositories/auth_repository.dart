import 'package:trustlink/features/auth/data/models/user_model.dart';
import 'package:trustlink/features/auth/data/models/user_token_model.dart';

import '../../../../core/model/response_model.dart';
import '../../../../core/resources/data_state.dart';
import '../../../../core/resources/perform_request.dart';
import '../../../../data/mock_data.dart';
import '../sources/auth_api_service.dart';

class AuthRepository {
  final AuthApiService _authApiService;

  AuthRepository(this._authApiService);

  Future<DataState<ResponseModel<UserModel>>> getUserDetails() {
    if (useMockData) {
      return Future.value(DataSuccess(ResponseModel(
        status: 200,
        message: 'Success',
        data: mockUserToken.user,
      )));
    }
    return performRequest(_authApiService.getUserDetails());
  }

  Future<DataState<ResponseModel<UserTokenModel>>> login(
      Map<String, String> body) {
    if (useMockData) {
      return Future.value(DataSuccess(ResponseModel(
        status: 200,
        message: 'Login successful',
        data: mockUserToken,
      )));
    }
    return performRequest(_authApiService.login(body: body));
  }

  Future<DataState<ResponseModel<UserModel>>> register(
      Map<String, dynamic> body) {
    if (useMockData) {
      return Future.value(DataSuccess(ResponseModel(
        status: 200,
        message: 'Registration successful',
        data: mockUserToken.user,
      )));
    }
    return performRequest(_authApiService.register(body: body));
  }

  Future<DataState<ResponseModel>> resendOTP(Map<String, dynamic> body) {
    if (useMockData) {
      return Future.value(DataSuccess(ResponseModel(
        status: 200,
        message: 'OTP sent',
      )));
    }
    return performRequest(_authApiService.resendOTP(body: body));
  }

  Future<DataState<ResponseModel>> resetPassword(Map<String, dynamic> body) {
    if (useMockData) {
      return Future.value(DataSuccess(ResponseModel(
        status: 200,
        message: 'Password reset email sent',
      )));
    }
    return performRequest(_authApiService.resetPassword(body: body));
  }

  Future<DataState<ResponseModel>> completeReset(
      Map<String, dynamic> body, String token) {
    if (useMockData) {
      return Future.value(DataSuccess(ResponseModel(
        status: 200,
        message: 'Password reset complete',
      )));
    }
    return performRequest(
        _authApiService.completeReset(body: body, token: token));
  }

  Future<DataState<ResponseModel>> changePassword(Map<String, dynamic> body) {
    if (useMockData) {
      return Future.value(DataSuccess(ResponseModel(
        status: 200,
        message: 'Password changed',
      )));
    }
    return performRequest(_authApiService.changePassword(body: body));
  }

  Future<DataState<ResponseModel<UserTokenModel>>> verifyMail(
      Map<String, String> body) {
    if (useMockData) {
      return Future.value(DataSuccess(ResponseModel(
        status: 200,
        message: 'Email verified',
        data: mockUserToken,
      )));
    }
    return performRequest(_authApiService.verifyEmail(body: body));
  }
}
