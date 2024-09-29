abstract class AuthEvent {
  const AuthEvent();
}

class LoginEvent extends AuthEvent {
  final String id;
  final String password;

  const LoginEvent({
    required this.id,
    required this.password,
  });
}

class RegisterEvent extends AuthEvent {
  final String firstName;
  final String lastName;
  final String email;
  final String username;
  final String phone;
  final String password;

  const RegisterEvent({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.username,
    required this.phone,
    required this.password,
  });
}

class VerifyMailEvent extends AuthEvent {
  final String email;
  final String otp;

  const VerifyMailEvent({
    required this.email,
    required this.otp,
  });
}

class ResendOTPEvent extends AuthEvent {
  final String email;

  const ResendOTPEvent({
    required this.email,
  });
}

class ChangePasswordEvent extends AuthEvent {
  final String oldPassword;
  final String newPassword;
  final String confirm;

  const ChangePasswordEvent({
    required this.oldPassword,
    required this.newPassword,
    required this.confirm,
  });
}

class GetUserEvent extends AuthEvent {}

class ResetPasswordEvent extends AuthEvent {
  final String email;

  const ResetPasswordEvent({
    required this.email,
  });
}
