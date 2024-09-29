import 'package:flutter/material.dart';
import 'package:trustlink/features/home/presentation/pages/transaction_details_screen.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/resources/enums.dart';
import '../../../../core/resources/global.dart';
import '../../data/models/transaction/transaction_model.dart';

class TransactionTile extends StatelessWidget {
  final TransactionModel transaction;
  final bool showDetails;

  const TransactionTile(
      {super.key, required this.transaction, this.showDetails = false});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (co) => TransactionDetailsScreen(transaction)));
      },
      leading: CircleAvatar(
        radius: 25,
        backgroundColor: transaction.color.withOpacity(0.1),
        child: Icon(
          transaction.icon,
          size: 28.0,
          color: transaction.color,
        ),
      ),
      title: Text(
        transaction.description!.isEmpty
            ? transaction.mode!.name
            : transaction.description!,
        style: Theme.of(context).textTheme.titleMedium,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        "${transaction.date?.day} ${transaction.date?.monthShort}, ${transaction.date?.year} ",
        style: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(color: AppColors.grey),
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            "${transaction.type! == TransactionType.credit ? "+" : "-"}${Global.formatCurrency(transaction.amount.toString())}",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: transaction.type! == TransactionType.credit
                    ? Colors.green
                    : AppColors.error),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
            margin: const EdgeInsets.only(top: 4.0),
            decoration: BoxDecoration(
                color: transaction.color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(4.0)),
            child: Text(
              transaction.status!.name.toUpperCase(),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: transaction.color,
                  fontSize: 10.0,
                  fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 4.0),
    );
  }
}

class ShimmerTransactionTile extends StatelessWidget {
  const ShimmerTransactionTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 25,
        backgroundColor: AppColors.mainColor.shade50,
        child: Icon(
          Icons.pending,
          size: 28.0,
          color: Colors.transparent,
        ),
      ),
      title: Row(
        children: [
          Container(
            decoration: BoxDecoration(
                color: AppColors.mainColor.shade100,
                borderRadius: BorderRadius.circular(8.0)),
            margin: EdgeInsets.symmetric(vertical: 4.0),
            width: 120.0,
            child: Text(
              "",
              style: Theme.of(context).textTheme.titleMedium,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      subtitle: Row(
        children: [
          Container(
            decoration: BoxDecoration(
                color: AppColors.mainColor.shade50,
                borderRadius: BorderRadius.circular(8.0)),
            width: 200.0,
            child: Text(
              "",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: AppColors.grey),
            ),
          ),
        ],
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            decoration: BoxDecoration(
                color: AppColors.mainColor.shade50,
                borderRadius: BorderRadius.circular(8.0)),
            width: 80.0,
            child: Text("", style: Theme.of(context).textTheme.titleMedium),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
            margin: const EdgeInsets.only(top: 4.0),
            width: 50.0,
            decoration: BoxDecoration(
                color: AppColors.mainColor.shade100,
                borderRadius: BorderRadius.circular(4.0)),
            child: Text(
              "",
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(fontSize: 10.0, fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 4.0),
    );
  }
}
