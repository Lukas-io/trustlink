import 'package:trustlink/features/auth/data/models/user_token_model.dart';

abstract class AuthState<T> {
  const AuthState();
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading<T> extends AuthState<T> {
  const AuthLoading();
}

class AuthException extends AuthState {
  final String errorMessage;

  const AuthException(this.errorMessage);
}

class AuthEmailUnverified extends AuthState {
  const AuthEmailUnverified(this.email);

  final String email;
}

class AuthVerificationEmailSentSuccess extends AuthState {
  const AuthVerificationEmailSentSuccess();
}

class AuthSuccess<T> extends AuthState {
  const AuthSuccess({this.user, this.email});

  final UserTokenModel? user;
  final String? email;
}
