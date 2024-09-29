import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:trustlink/features/home/presentation/bloc/account_event.dart';
import 'package:trustlink/features/home/presentation/bloc/account_state.dart';
import 'package:trustlink/features/home/presentation/components/transaction_tile.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/resources/enums.dart';
import '../../data/models/transaction/transaction_model.dart';
import '../pages/fliter_widget.dart';

class AnimatedTransactionList extends StatefulWidget {
  final ScrollController controller;
  final List<TransactionModel> transactions;
  final AccountState state;

  const AnimatedTransactionList(
      {super.key,
      required this.controller,
      required this.transactions,
      required this.state});

  @override
  State<AnimatedTransactionList> createState() =>
      _AnimatedTransactionListState();
}

class _AnimatedTransactionListState extends State<AnimatedTransactionList> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  late List<TransactionModel> _filteredTransactions;

  @override
  void initState() {
    super.initState();
    _filteredTransactions = List.from(widget.transactions);
  }

  void _filterTransactions(TransactionStatus filter) {
    final List<TransactionModel> newList;
    if (filter == TransactionStatus.all) {
      newList = widget.transactions;
    } else {
      newList = widget.transactions
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
    return Column(
      children: [
        FilterWidget(onFilter: (status) {
          _filterTransactions(status);
        }),
        if (widget.state is! AccountException<GetTransactionsEvent>)
          SizedBox(
            height: 900.0,
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: widget.state is AccountLoading<GetTransactionsEvent>
                    ? Shimmer.fromColors(
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
                            itemCount: 8),
                      )
                    : widget.transactions.isEmpty
                        ? const Text("No Transactions yet!")
                        : AnimatedList(
                            controller: widget.controller,
                            padding: const EdgeInsets.only(top: 4),
                            key: _listKey,
                            initialItemCount: _filteredTransactions.length,
                            itemBuilder: (context, index, animation) {
                              return Column(
                                children: [
                                  _buildItem(
                                      _filteredTransactions[index], animation),
                                  const Divider(
                                    height: 0.0,
                                    color: AppColors.grey,
                                    thickness: 0.2,
                                  ),
                                ],
                              );
                            },
                          )),
          ),
      ],
    );
  }
}
