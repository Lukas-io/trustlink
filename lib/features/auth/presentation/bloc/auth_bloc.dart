import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trustlink/features/auth/data/models/user_token_model.dart';

import '../../../../core/resources/data_state.dart';
import '../../data/repositories/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc(this._authRepository) : super(const AuthInitial()) {
    on<LoginEvent>(onLogin);
    on<VerifyMailEvent>(onVerifyMail);
    on<RegisterEvent>(onRegister);
    on<ResendOTPEvent>(onResendOTP);
    on<ResetPasswordEvent>(onResetPassword);
    on<GetUserEvent>(onGetUser);
    on<ChangePasswordEvent>(onChangePassword);
  }

  void onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(const AuthLoading<LoginEvent>());
    final dataState = await _authRepository.login({
      "id": event.id,
      "password": event.password,
    });
    if (dataState is DataSuccess) {
      emit(AuthSuccess<LoginEvent>(user: dataState.data!.data!));
      // emit(AuthEmailUnverified(event.id));
    } else {
      emit(AuthException((dataState.exception!).message!));
    }
  }

  void onRegister(RegisterEvent event, Emitter<AuthState> emit) async {
    emit(const AuthLoading<RegisterEvent>());
    final dataState = await _authRepository.register({
      "firstName": event.firstName,
      "lastName": event.lastName,
      "email": event.email,
      "username": event.username,
      "phone": event.phone,
      "password": event.password,
    });

    if (dataState is DataSuccess) {
      emit(AuthSuccess<RegisterEvent>(email: event.email));
    } else {
      emit(AuthException((dataState.exception!).message!));
    }
  }

  void onVerifyMail(VerifyMailEvent event, Emitter<AuthState> emit) async {
    emit(const AuthLoading<VerifyMailEvent>());
    final dataState = await _authRepository.verifyMail({
      "email": event.email,
      "otp": event.otp,
    });
    if (dataState is DataSuccess) {
      emit(AuthSuccess<VerifyMailEvent>(user: dataState.data?.data!));
    } else {
      emit(AuthException((dataState.exception!).message!));
    }
  }

  void onResendOTP(ResendOTPEvent event, Emitter<AuthState> emit) async {
    emit(const AuthLoading<ResendOTPEvent>());
    final dataState = await _authRepository.resendOTP({
      "email": event.email,
    });
    if (dataState is DataSuccess) {
      emit(const AuthSuccess<ResendOTPEvent>());
    } else {
      emit(AuthException((dataState.exception!).message!));
    }
  }

  void onResetPassword(
      ResetPasswordEvent event, Emitter<AuthState> emit) async {
    emit(const AuthLoading<ResetPasswordEvent>());
    final dataState = await _authRepository.resetPassword({
      "email": event.email,
    });
    if (dataState is DataSuccess) {
      emit(AuthSuccess<ResetPasswordEvent>(email: dataState.data!.message!));
    } else {
      emit(AuthException((dataState.exception!).message!));
    }
  }

  void onChangePassword(
      ChangePasswordEvent event, Emitter<AuthState> emit) async {
    emit(const AuthLoading<ChangePasswordEvent>());
    final dataState = await _authRepository.changePassword({
      "old_password": event.oldPassword,
      "new_password": event.newPassword,
      "confirm": event.confirm,
    });
    if (dataState is DataSuccess) {
      emit(AuthSuccess<ChangePasswordEvent>(email: dataState.data!.message!));
    } else {
      emit(AuthException((dataState.exception!).message!));
    }
  }

  void onGetUser(GetUserEvent event, Emitter<AuthState> emit) async {
    emit(const AuthLoading<GetUserEvent>());
    final dataState = await _authRepository.getUserDetails();

    if (dataState is DataSuccess) {
      emit(AuthSuccess<GetUserEvent>(
          user: UserTokenModel(user: dataState.data?.data!)));
    } else {
      emit(AuthException((dataState.exception!).message!));
    }
  }
}
