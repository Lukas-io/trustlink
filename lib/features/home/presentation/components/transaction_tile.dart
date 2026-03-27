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

  Color get _statusBgColor {
    switch (transaction.status) {
      case TransactionStatus.pending:
        return AppColors.pendingBg;
      case TransactionStatus.completed:
        return AppColors.completedBg;
      case TransactionStatus.canceled:
        return AppColors.canceledBg;
      case TransactionStatus.refunded:
        return AppColors.refundedBg;
      default:
        return AppColors.shade100;
    }
  }

  Color get _statusTextColor {
    switch (transaction.status) {
      case TransactionStatus.pending:
        return AppColors.pendingText;
      case TransactionStatus.completed:
        return AppColors.completedText;
      case TransactionStatus.canceled:
        return AppColors.canceledText;
      case TransactionStatus.refunded:
        return AppColors.refundedText;
      default:
        return AppColors.text;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (co) => TransactionDetailsScreen(transaction)));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
        child: Row(
          children: [
            // Status icon
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: _statusBgColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                transaction.icon,
                size: 20,
                color: _statusTextColor,
              ),
            ),
            const SizedBox(width: 12),
            // Description + date
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transaction.description!.isEmpty
                        ? transaction.mode!.name
                        : transaction.description!,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: AppColors.text,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 3),
                  Text(
                    "${transaction.date?.day} ${transaction.date?.monthShort}, ${transaction.date?.year}",
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            // Amount + status badge
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "${transaction.type! == TransactionType.credit ? "+" : "-"}${Global.formatCurrency(transaction.amount.toString())}",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: transaction.type! == TransactionType.credit
                        ? AppColors.completedText
                        : AppColors.error,
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: _statusBgColor,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    transaction.status!.name.toUpperCase(),
                    style: TextStyle(
                      color: _statusTextColor,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ShimmerTransactionTile extends StatelessWidget {
  const ShimmerTransactionTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.mainColor.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 14,
                  width: 140,
                  decoration: BoxDecoration(
                    color: AppColors.mainColor.shade100,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  height: 12,
                  width: 90,
                  decoration: BoxDecoration(
                    color: AppColors.mainColor.shade50,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                height: 14,
                width: 70,
                decoration: BoxDecoration(
                  color: AppColors.mainColor.shade100,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              const SizedBox(height: 6),
              Container(
                height: 16,
                width: 50,
                decoration: BoxDecoration(
                  color: AppColors.mainColor.shade50,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
