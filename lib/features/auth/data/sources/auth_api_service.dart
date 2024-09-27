import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:trustlink/features/auth/data/models/user_model.dart';
import 'package:trustlink/features/auth/data/models/user_token_model.dart';

import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/model/response_model.dart';

part 'auth_api_service.g.dart';

@RestApi(baseUrl: ApiEndpoints.baseApiUrl)
abstract class AuthApiService {
  factory AuthApiService(Dio dio) = _AuthApiService;

  @POST(ApiEndpoints.login)
  Future<HttpResponse<ResponseModel<UserTokenModel>>> login(
      {@Body() required Map<String, dynamic> body});

  @POST(ApiEndpoints.register)
  Future<HttpResponse<ResponseModel<UserModel>>> register({
    @Body() required Map<String, dynamic> body,
  });

  @POST(ApiEndpoints.resendOTP)
  Future<HttpResponse<ResponseModel>> resendOTP({
    @Body() required Map<String, dynamic> body,
  });

  @POST(ApiEndpoints.resetPassword)
  Future<HttpResponse<ResponseModel>> resetPassword({
    @Body() required Map<String, dynamic> body,
  });

  @POST(ApiEndpoints.completeReset)
  Future<HttpResponse<ResponseModel>> completeReset({
    @Query("token") required String token,
    @Body() required Map<String, dynamic> body,
  });

  @POST(ApiEndpoints.changePassword)
  Future<HttpResponse<ResponseModel>> changePassword({
    @Body() required Map<String, dynamic> body,
  });

  @POST(ApiEndpoints.verifyEmail)
  Future<HttpResponse<ResponseModel<UserTokenModel>>> verifyEmail({
    @Body() required Map<String, dynamic> body,
  });

  @GET(ApiEndpoints.userDetails)
  Future<HttpResponse<ResponseModel<UserModel>>> getUserDetails();
}
