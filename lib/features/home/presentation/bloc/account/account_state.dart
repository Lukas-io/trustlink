

abstract class AccountState<T> {
  const AccountState();
}

class AccountInitial extends AccountState {
  const AccountInitial();
}

class AccountLoading<T> extends AccountState<T> {
  const AccountLoading();
}

class AccountException extends AccountState {
  final String errorMessage;

  const AccountException(this.errorMessage);
}

class AccountSuccess<T> extends AccountState {
  const AccountSuccess();
}
