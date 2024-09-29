import 'package:flutter/material.dart';
import 'package:trustlink/core/components/primary_button.dart';
import 'package:trustlink/features/home/data/models/transaction/transaction_model.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/resources/enums.dart';
import '../../../../core/resources/global.dart';

class TransactionDetailsScreen extends StatelessWidget {
  final TransactionModel transaction;

  const TransactionDetailsScreen(this.transaction, {super.key});

  @override
  Widget build(BuildContext context) {
    DateTime localDate = transaction.date!.toLocal();
    bool isPm = localDate.hour > 12;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Transaction Details"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            // mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(),
              Text(
                "${transaction.type! == TransactionType.credit ? "+" : "-"}${Global.formatCurrency(transaction.amount.toString())}",
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    color: transaction.type! == TransactionType.credit
                        ? Colors.green
                        : AppColors.error),
              ),
              Text(
                "${localDate.hour - (isPm ? 12 : 0)}:${localDate.minute}${isPm ? "PM" : "AM"} ${transaction.date?.day} ${transaction.date?.monthShort}, ${transaction.date?.year} ",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: AppColors.grey),
              ),
              const SizedBox(
                height: 4.0,
              ),
              Wrap(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 4.0),
                    margin: const EdgeInsets.only(top: 8.0),
                    decoration: BoxDecoration(
                        color: transaction.colorMode.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4.0)),
                    child: Text(
                      transaction.mode!.name.toUpperCase(),
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: transaction.colorMode,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 4.0),
                    margin: const EdgeInsets.only(top: 8.0),
                    decoration: BoxDecoration(
                        color: transaction.color.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8.0)),
                    child: Text(
                      transaction.status!.name.toUpperCase(),
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: transaction.color,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 12.0,
              ),
              DescriptionColumn(
                  title: "Receiver", description: transaction.receiver!.email!),
              DescriptionColumn(
                title: "Sender",
                description: transaction.sender!.email!,
                isMe: true,
              ),
              DescriptionColumn(
                  title: "Description", description: transaction.description!),
              if (transaction.type == TransactionType.credit &&
                  transaction.status == TransactionStatus.pending)
                PrimaryButton(onPressed: () {}, title: "Verify Payment"),
              if (transaction.type == TransactionType.debit &&
                  transaction.status == TransactionStatus.pending)
                PrimaryButton(onPressed: () {}, title: "Request Refund"),
              if (transaction.type == TransactionType.debit &&
                  transaction.status == TransactionStatus.canceled)
                PrimaryButton(onPressed: () {}, title: "Confirm Refund"),
            ],
          ),
        ),
      ),
    );
  }
}

class DescriptionColumn extends StatelessWidget {
  final String title;
  final String description;
  final bool isMe;

  const DescriptionColumn(
      {super.key,
      required this.title,
      required this.description,
      this.isMe = false});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.only(top: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "$title:",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: AppColors.grey),
            ),
            Text(
              description + (isMe ? " (Me)" : ""),
              style: Theme.of(context).textTheme.titleLarge,
              // overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
