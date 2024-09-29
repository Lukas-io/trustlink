import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:trustlink/features/home/data/models/transaction/transaction_model.dart';
import 'package:trustlink/features/home/presentation/components/transaction_tile.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../injection_container.dart';
import '../bloc/account_bloc.dart';
import '../bloc/account_event.dart';
import '../bloc/account_state.dart';

class RecentTransactions extends StatefulWidget {
  final int transactionLength;

  const RecentTransactions({
    super.key,
    this.transactionLength = 5,
  });

  @override
  State<RecentTransactions> createState() => _RecentTransactionsState();
}

class _RecentTransactionsState extends State<RecentTransactions> {
  @override
  void initState() {
    if (sl<AccountBloc>().state
        is! AccountSuccess<GetTransactionsEvent, List<TransactionModel>>) {
      sl<AccountBloc>().add(GetTransactionsEvent());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AccountBloc>.value(
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
        },
        builder: (context, state) {
          List<TransactionModel> transactions = [];
          if (state
              is AccountSuccess<GetTransactionsEvent, List<TransactionModel>>) {
            transactions = state.data!;
          }
          return Card(
            child: Container(
              width: double.infinity,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(12.0)),
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Recent Transactions",
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(color: AppColors.grey),
                  ),
                  if (state is AccountLoading<GetTransactionsEvent>)
                    Shimmer.fromColors(
                      baseColor: AppColors.secondary,
                      highlightColor: AppColors.bg,
                      child: ListView.separated(
                          padding: const EdgeInsets.only(top: 4),
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return const ShimmerTransactionTile();
                          },
                          shrinkWrap: true,
                          separatorBuilder: (context, index) {
                            return const Divider(
                              height: 0.0,
                              color: AppColors.grey,
                              thickness: 0.2,
                            );
                          },
                          itemCount: widget.transactionLength),
                    ),
                  if (state is AccountSuccess<GetTransactionsEvent,
                      List<TransactionModel>>)
                    transactions.isEmpty
                        ? const Center(
                            child: Text("No Transactions yet!"),
                          )
                        : ListView.separated(
                            padding: const EdgeInsets.only(top: 4),
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final transaction = transactions[index];
                              return TransactionTile(transaction: transaction);
                            },
                            shrinkWrap: true,
                            separatorBuilder: (context, index) {
                              return const Divider(
                                height: 0.0,
                                color: AppColors.grey,
                                thickness: 0.2,
                              );
                            },
                            itemCount:
                                widget.transactionLength > transactions.length
                                    ? transactions.length
                                    : widget.transactionLength),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
