import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trustlink/features/home/presentation/components/info_dialog.dart';

import '../../../../injection_container.dart';
import '../../data/models/transaction/transaction_model.dart';
import '../bloc/account_bloc.dart';
import '../bloc/account_event.dart';
import '../bloc/account_state.dart';
import '../components/animated_transaction_list.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  late ScrollController controller;

  @override
  void initState() {
    controller = ScrollController();

    if (sl<AccountBloc>().state
        is! AccountSuccess<GetTransactionsEvent, List<TransactionModel>>) {
      sl<AccountBloc>().add(GetTransactionsEvent());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Transactions"),
        centerTitle: false,
        elevation: 0.0,
        surfaceTintColor: Colors.transparent,
        titleSpacing: 24,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 24.0),
            child: IconButton(
                onPressed: () {
                  showDialog(
                      context: context, builder: (context) => InfoDialog());
                },
                icon: Icon(Icons.info_outline)),
          )
        ],
      ),
      body: BlocProvider<AccountBloc>.value(
        value: sl<AccountBloc>(),
        child: BlocBuilder<AccountBloc, AccountState>(
            buildWhen: (previous, current) {
          if (current
              is AccountSuccess<GetTransactionsEvent, List<TransactionModel>>) {
            return true;
          }
          if (current is AccountLoading<GetTransactionsEvent>) {
            return true;
          }
          if (current is AccountException<GetTransactionsEvent>) {
            return true;
          }
          return false;
        }, builder: (context, state) {
          List<TransactionModel> transactions = [];
          if (state
              is AccountSuccess<GetTransactionsEvent, List<TransactionModel>>) {
            transactions = state.data!;
          }

          return AnimatedTransactionList(
            controller: controller,
            transactions: transactions,
            state: state,
          );
        }),
      ),
    );
  }
}
