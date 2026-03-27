import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:trustlink/features/home/presentation/bloc/account_event.dart';
import 'package:trustlink/features/home/presentation/bloc/account_state.dart';
import 'package:trustlink/features/home/presentation/components/transaction_tile.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/resources/enums.dart';
import '../../../../injection_container.dart';
import '../../data/models/transaction/transaction_model.dart';
import '../bloc/account_bloc.dart';
import '../pages/fliter_widget.dart';

class AnimatedTransactionList extends StatelessWidget {
  final ScrollController controller;
  final List<TransactionModel> transactions;
  final AccountState state;

  AnimatedTransactionList(
      {super.key,
      required this.controller,
      required this.transactions,
      required this.state});

  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  late List<TransactionModel> _filteredTransactions = List.from(transactions);

  void _filterTransactions(TransactionStatus filter) {
    final List<TransactionModel> newList;
    if (filter == TransactionStatus.all) {
      newList = transactions;
    } else {
      newList = transactions
          .where((transaction) => transaction.status == filter)
          .toList();
    }

    final oldLength = _filteredTransactions.length;
    final newLength = newList.length;

    if (newLength > oldLength) {
      // Items were added
      for (int i = oldLength; i < newLength; i++) {
        _filteredTransactions.add(newList[i]);
        _listKey.currentState?.insertItem(i);
      }
    } else if (newLength < oldLength) {
      // Items were removed
      for (int i = oldLength - 1; i >= newLength; i--) {
        final removedItem = _filteredTransactions.removeAt(i);
        _listKey.currentState?.removeItem(
          i,
          (context, animation) => _buildItem(removedItem, animation),
          duration: const Duration(milliseconds: 300),
        );
      }
    }

    // Update remaining items
    for (int i = 0; i < newLength; i++) {
      if (i < _filteredTransactions.length) {
        _filteredTransactions[i] = newList[i];
      }
    }
  }

  Widget _buildItem(TransactionModel transaction, Animation<double> animation) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 1),
        end: Offset.zero,
      ).animate(animation),
      child: SizeTransition(
        sizeFactor: animation,
        child: FadeTransition(
          opacity: animation,
          child: TransactionTile(transaction: transaction),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AccountBloc>.value(
      value: sl<AccountBloc>(),
      child: BlocListener<AccountBloc, AccountState>(
        listener: (previous, current) {
          if (current
              is AccountSuccess<GetTransactionsEvent, List<TransactionModel>>) {
            _filteredTransactions = current.data!;
          }
          if (current is AccountLoading<GetTransactionsEvent>) {}
          if (current is AccountException<GetTransactionsEvent>) {}
        },
        child: Column(
          children: [
            FilterWidget(onFilter: (status) {
              _filterTransactions(status);
            }),
            if (state is! AccountException<GetTransactionsEvent>)
              Expanded(
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: state is AccountLoading<GetTransactionsEvent>
                        ? Shimmer.fromColors(
                            baseColor: AppColors.secondary,
                            highlightColor: AppColors.bg,
                            direction: ShimmerDirection.ttb,
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
                                itemCount: 8),
                          )
                        : _filteredTransactions.isEmpty
                            ? const Center(
                                child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 24.0),
                                child: Text("No Transactions yet!"),
                              ))
                            : AnimatedList(
                                controller: controller,
                                padding: const EdgeInsets.only(top: 4),
                                key: _listKey,
                                initialItemCount: _filteredTransactions.length,
                                itemBuilder: (context, index, animation) {
                                  return Column(
                                    children: [
                                      _buildItem(_filteredTransactions[index],
                                          animation),
                                      const Divider(
                                        height: 0.0,
                                        color: AppColors.grey,
                                        thickness: 0.2,
                                      ),
                                      if (index ==
                                          _filteredTransactions.length - 1)
                                        Padding(
                                            padding:
                                                MediaQuery.of(context).padding)
                                    ],
                                  );
                                },
                              )),
              ),
          ],
        ),
      ),
    );
  }
}
