import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repositories/account_repository.dart';
import 'account_event.dart';
import 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final AccountRepository _accountRepository;

  AccountBloc(this._accountRepository) : super(const AccountInitial()) {}

// void onLogin(LoginEvent event, Emitter<TransactionState> emit) async {
//   emit(const TransactionLoading<LoginEvent>());
//   final dataState = await _TransactionRepository.login({
//     "id": event.id,
//     "password": event.password,
//   });
//   if (dataState is DataSuccess) {
//     emit(TransactionSuccess<LoginEvent>(user: dataState.data!.data!));
//     // emit(TransactionEmailUnverified(event.id));
//   } else {
//     emit(TransactionException((dataState.exception!).message!));
//   }
// }
}
