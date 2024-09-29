import 'package:trustlink/features/home/presentation/bloc/account_event.dart';

abstract class AccountState<T, V> {
  final V? data;

  const AccountState({this.data});
}

class AccountInitial extends AccountState {
  const AccountInitial();
}

class AccountLoading<T> extends AccountState<T, void> {
  const AccountLoading();
}

class AccountException<T> extends AccountState<T, String> {
  const AccountException(String errorMessage) : super(data: errorMessage);
}

class AccountSuccess<T, V> extends AccountState<AccountEvent, V> {
  const AccountSuccess({super.data});
}
