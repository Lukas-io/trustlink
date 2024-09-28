// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:trustlink/features/home/presentation/bloc/transaction/transaction_state.dart';
//
// import '../../../data/repositories/transaction_repository.dart';
// import 'transaction_event.dart';
//
// class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
//   final TransactionRepository _transactionRepository;
//
//   TransactionBloc(this._transactionRepository)
//       : super(const TransactionInitial()) {}
//
// // void onLogin(LoginEvent event, Emitter<TransactionState> emit) async {
// //   emit(const TransactionLoading<LoginEvent>());
// //   final dataState = await _TransactionRepository.login({
// //     "id": event.id,
// //     "password": event.password,
// //   });
// //   if (dataState is DataSuccess) {
// //     emit(TransactionSuccess<LoginEvent>(user: dataState.data!.data!));
// //     // emit(TransactionEmailUnverified(event.id));
// //   } else {
// //     emit(TransactionException((dataState.exception!).message!));
// //   }
// // }
// }
