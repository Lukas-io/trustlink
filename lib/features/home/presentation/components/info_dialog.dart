import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class InfoDialog extends StatelessWidget {
  const InfoDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Transaction Status Details:",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(
                height: 12.0,
              ),
              Text(
                "Pending:",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: AppColors.secondary),
              ),
              SizedBox(
                height: 4.0,
              ),
              Text(
                "Transactions that are yet to be verified by the receiver, they need a pin from the sender to verify transaction.",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(
                height: 8.0,
              ),
              Text(
                "Cancelled:",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: AppColors.orange),
              ),
              SizedBox(
                height: 4.0,
              ),
              Text(
                "A transaction that was cancelled by the sender, it could be they are requesting a refund. They need a pin from the receiver to complete refund",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(
                height: 8.0,
              ),
              Text(
                "Completed:",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: AppColors.completed),
              ),
              SizedBox(
                height: 4.0,
              ),
              Text(
                "Transactions that have been completed, no further action can be taken on this transaction.",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(
                height: 8.0,
              ),
              Text(
                "Pending:",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: AppColors.purple),
              ),
              SizedBox(
                height: 4.0,
              ),
              Text(
                "Transactions that were just initialized, they need a pin from the receiver to be completed.",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(
                height: 8.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
